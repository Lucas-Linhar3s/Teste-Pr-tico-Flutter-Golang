package application

import (
	"errors"

	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"go.uber.org/zap"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/database"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/courses/domain"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/utils"
)

// CourseApp application
type CourseApp struct {
	logger   *log.Logger
	validate *validator.Validate
	db       *database.Database
}

// NewApplication new application
func NewApplication(
	logger *log.Logger,
	db *database.Database,
) *CourseApp {
	return &CourseApp{
		validate: validator.New(),
		logger:   logger,
		db:       db,
	}
}

// CreateCourse create course
func (app *CourseApp) CreateCourse(ctx *gin.Context, req CourseReq) (err error) {
	const msg = "Error creating course"

	tx, err := app.db.NewTransaction()
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}
	defer tx.Close()

	var (
		service = domain.GetService(domain.GetRepository(tx))
	)

	if err = app.validate.Struct(req); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	data, err := utils.ConvertRequestToModel[domain.CourseModel](req)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = service.CreateCourse(&data); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = tx.Commit(); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	return
}

// UpdateCourse updates a course
func (app *CourseApp) UpdateCourse(ctx *gin.Context, req CourseReq) (err error) {
	const msg = "Error updating course"

	tx, err := app.db.NewTransaction()
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}
	defer tx.Close()

	var (
		service = domain.GetService(domain.GetRepository(tx))
	)

	if err = app.validate.Struct(req); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	data, err := utils.ConvertRequestToModel[domain.CourseModel](req)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = service.UpdateCourse(&data); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = tx.Commit(); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	return
}

// AddStudents adds students to a course
func (app *CourseApp) AddStudents(ctx *gin.Context, req CourseStudentReq) (err error) {
	const msg = "Error adding students to course"

	tx, err := app.db.NewTransaction()
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}
	defer tx.Close()

	var (
		service = domain.GetService(domain.GetRepository(tx))
	)

	if err = app.validate.Struct(req); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	data, err := utils.ConvertRequestToModel[domain.CourseModel](req)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = service.AddStudents(&data); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = tx.Commit(); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	return
}

// ListCourses lists all courses
func (app *CourseApp) ListCourses(ctx *gin.Context, req Params) (pagination *Res, err error) {
	const msg = "Error listing courses"

	tx, err := app.db.NewTransaction()
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}
	defer tx.Close()

	var (
		service = domain.GetService(domain.GetRepository(tx))
	)

	if err = app.validate.Struct(req); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	paramsSearch := map[string]interface{}{
		"descricao": req.Description,
		"limit":     *req.Limit,
		"offset":    *req.Offset,
	}

	data, err := service.ListCourses(paramsSearch)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	pagination = &Res{}
	for _, v := range *data {
		var course CourseRes
		course, err = utils.ConvertRequestToModel[CourseRes](v)
		if err != nil {
			app.logger.Error(msg, zap.Error(err))
			return
		}

		pagination.Data = append(pagination.Data, &course)
	}

	return
}

// ListCoursesStudents lists students in a course
func (app *CourseApp) ListStudentsCourse(ctx *gin.Context, req Params) (pagination *Res, err error) {
	const msg = "Error listing students courses"

	tx, err := app.db.NewTransaction()
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}
	defer tx.Close()

	var (
		service = domain.GetService(domain.GetRepository(tx))
	)

	if req.Code == nil {
		return nil, errors.New("code is required")
	}

	paramsSearch := map[string]interface{}{
		"code": req.Code,
	}

	data, err := service.ListCoursesStudents(paramsSearch)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	pagination = &Res{}
	for _, v := range *data {
		var course CourseRes
		course, err = utils.ConvertRequestToModel[CourseRes](v)
		if err != nil {
			app.logger.Error(msg, zap.Error(err))
			return
		}
		pagination.Total = v.Total
		pagination.Data = append(pagination.Data, &course)
	}

	return
}
