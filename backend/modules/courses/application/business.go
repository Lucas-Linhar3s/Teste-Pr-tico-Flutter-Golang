package application

import (
	"errors"

	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"github.com/jinzhu/copier"
	"go.uber.org/dig"
	"go.uber.org/zap"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/courses/domain"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
)

type appDependencies struct {
	dig.In
	Service  *domain.Service     `name:"COURSES_SERVICE"`
	Logger   *log.Logger         `name:"LOGGER"`
	Validate *validator.Validate `name:"VALIDATE"`
}

// CourseApp application
type CourseApp struct {
	validate *validator.Validate
	logger   *log.Logger
	service  *domain.Service
}

// NewApplication new application
func NewApplication(dep appDependencies) *CourseApp {
	return &CourseApp{
		validate: dep.Validate,
		logger:   dep.Logger,
		service:  dep.Service,
	}
}

// CreateCourse create course
func (app *CourseApp) CreateCourse(ctx *gin.Context, req CourseReq) (err error) {
	const msg = "Error creating course"

	if err = app.validate.Struct(req); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	data, err := convertRequestToModel[domain.CourseModel](req)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = app.service.CreateCourse(&data); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	return
}

// UpdateCourse updates a course
func (app *CourseApp) UpdateCourse(ctx *gin.Context, req CourseReq) (err error) {
	const msg = "Error updating course"

	if err = app.validate.Struct(req); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	data, err := convertRequestToModel[domain.CourseModel](req)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = app.service.UpdateCourse(&data); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	return
}

// AddStudents adds students to a course
func (app *CourseApp) AddStudents(ctx *gin.Context, req CourseStudentReq) (err error) {
	const msg = "Error adding students to course"

	if err = app.validate.Struct(req); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	data, err := convertRequestToModel[domain.CourseModel](req)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = app.service.AddStudents(&data); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	return
}

// ListCourses lists all courses
func (app *CourseApp) ListCourses(ctx *gin.Context, req Params) (pagination *Res, err error) {
	const msg = "Error listing courses"

	if err = app.validate.Struct(req); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	paramsSearch := map[string]interface{}{
		"descricao": req.Description,
		"limit":     *req.Limit,
		"offset":    *req.Offset,
	}

	data, err := app.service.ListCourses(paramsSearch)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	pagination = &Res{}
	for _, v := range *data {
		var course CourseRes
		course, err = convertRequestToModel[CourseRes](v)
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

	if req.Code == nil {
		return nil, errors.New("code is required")
	}

	paramsSearch := map[string]interface{}{
		"code": req.Code,
	}

	data, err := app.service.ListCoursesStudents(paramsSearch)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	pagination = &Res{}
	for _, v := range *data {
		var course CourseRes
		course, err = convertRequestToModel[CourseRes](v)
		if err != nil {
			app.logger.Error(msg, zap.Error(err))
			return
		}
		pagination.Total = v.Total
		pagination.Data = append(pagination.Data, &course)
	}

	return
}

func convertRequestToModel[T any](req interface{}) (T, error) {
	var data T
	if err := copier.Copy(&data, req); err != nil {
		return data, err
	}
	return data, nil
}
