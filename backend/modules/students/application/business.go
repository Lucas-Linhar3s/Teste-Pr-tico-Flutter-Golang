package application

import (
	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"go.uber.org/zap"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/database"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/students/domain"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/utils"
)

// StudentApp application
type StudentApp struct {
	logger   *log.Logger
	validate *validator.Validate
	db       *database.Database
}

// NewApplication new application
func NewApplication(
	logger *log.Logger,
	db *database.Database,
) *StudentApp {
	return &StudentApp{
		validate: validator.New(),
		logger:   logger,
		db:       db,
	}
}

// CreateStudent create student
func (app *StudentApp) CreateStudent(ctx *gin.Context, req StudentReq) (err error) {
	const msg = "Error creating student"

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

	data, err := utils.ConvertRequestToModel[domain.StudentModel](req)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = service.CreateStudent(&data); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = tx.Commit(); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	return
}

// UpdateStudent updates a student
func (app *StudentApp) UpdateStudent(ctx *gin.Context, req StudentReq) (err error) {
	const msg = "Error updating student"

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

	data, err := utils.ConvertRequestToModel[domain.StudentModel](req)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = service.UpdateStudent(&data); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = tx.Commit(); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	return
}

// ListStudents lists all students
func (app *StudentApp) ListStudents(ctx *gin.Context, req Params) (pagination *Res, err error) {
	const msg = "Error listing students"

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
		"name":   req.Name,
		"limit":  *req.Limit,
		"offset": *req.Offset,
	}

	data, err := service.ListStudents(paramsSearch)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	pagination = &Res{}
	for _, v := range *data {
		var student StudentRes
		student, err = utils.ConvertRequestToModel[StudentRes](v)
		if err != nil {
			app.logger.Error(msg, zap.Error(err))
			return
		}

		pagination.Data = append(pagination.Data, &student)
	}

	return
}
