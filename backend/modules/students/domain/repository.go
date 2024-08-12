package domain

import (
	"errors"

	"github.com/jinzhu/copier"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/database"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/students/infrastructure"
)

type repository struct {
	repo infrastructure.PGStudent
}

func newRepository(db *database.Database) *repository {
	return &repository{
		repo: infrastructure.PGStudent{Db: db},
	}
}

// CreateStudent implements IStudents.
func (r *repository) CreateStudent(student *infrastructure.StudentModel) (err error) {
	return r.repo.CreateStudent(student)
}

// ListStudents implements IStudents.
func (r *repository) ListStudents(params map[string]interface{}) (pagination *[]infrastructure.StudentModel, err error) {
	return r.repo.ListStudents(params)
}

// UpdateStudent implements IStudents.
func (r *repository) UpdateStudent(course *infrastructure.StudentModel) (err error) {
	return r.repo.UpdateStudent(course)
}

// ConvertDomainToModelInfra converts domain model to infra model
func (r *repository) ConvertDomainToModelInfra(studentModelDomain *StudentModel) (studentModelInfra *infrastructure.StudentModel, err error) {
	var data infrastructure.StudentModel
	if studentModelDomain == nil {
		return nil, errors.New("courseModelDomain is nil")
	}

	if err = copier.Copy(&data, studentModelDomain); err != nil {
		return nil, err
	}

	return &data, nil
}

// ConvertModelInfraToDomain converts infra model to domain model
func (r *repository) ConvertModelInfraToDomain(studentModelInfra *infrastructure.StudentModel) (studentModelDomain *StudentModel, err error) {
	var data StudentModel
	if studentModelInfra == nil {
		return nil, errors.New("courseModelInfra is nil")
	}

	if err = copier.Copy(&data, studentModelInfra); err != nil {
		return nil, err
	}

	return &data, nil
}
