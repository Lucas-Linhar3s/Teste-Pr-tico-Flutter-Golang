package application

import (
	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"github.com/jinzhu/copier"
	"go.uber.org/dig"
	"go.uber.org/zap"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/students/domain"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
)

type appDependencies struct {
	dig.In
	Service  *domain.Service     `name:"STUDENTS_SERVICE"`
	Logger   *log.Logger         `name:"LOGGER"`
	Validate *validator.Validate `name:"VALIDATE"`
}

// StudentApp application
type StudentApp struct {
	validate *validator.Validate
	logger   *log.Logger
	service  *domain.Service
}

// NewApplication new application
func NewApplication(dep appDependencies) *StudentApp {
	return &StudentApp{
		validate: dep.Validate,
		logger:   dep.Logger,
		service:  dep.Service,
	}
}

// CreateStudent create student
func (app *StudentApp) CreateStudent(ctx *gin.Context, req StudentReq) (err error) {
	const msg = "Error creating student"

	if err = app.validate.Struct(req); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	data, err := convertRequestToModel[domain.StudentModel](req)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = app.service.CreateStudent(&data); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	return
}

// UpdateStudent updates a student
func (app *StudentApp) UpdateStudent(ctx *gin.Context, req StudentReq) (err error) {
	const msg = "Error updating student"

	if err = app.validate.Struct(req); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	data, err := convertRequestToModel[domain.StudentModel](req)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	if err = app.service.UpdateStudent(&data); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	return
}

// ListStudents lists all students
func (app *StudentApp) ListStudents(ctx *gin.Context, req Params) (pagination *Res, err error) {
	const msg = "Error listing students"

	if err = app.validate.Struct(req); err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	paramsSearch := map[string]interface{}{
		"name":   req.Name,
		"limit":  *req.Limit,
		"offset": *req.Offset,
	}

	data, err := app.service.ListStudents(paramsSearch)
	if err != nil {
		app.logger.Error(msg, zap.Error(err))
		return
	}

	pagination = &Res{}
	for _, v := range *data {
		var student StudentRes
		student, err = convertRequestToModel[StudentRes](v)
		if err != nil {
			app.logger.Error(msg, zap.Error(err))
			return
		}

		pagination.Data = append(pagination.Data, &student)
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
