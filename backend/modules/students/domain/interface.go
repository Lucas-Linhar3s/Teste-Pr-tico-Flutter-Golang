package domain

import (
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/students/infrastructure"
)

// IStudents is a interface
type IStudents interface {
	CreateStudent(course *infrastructure.StudentModel) (err error)
	UpdateStudent(course *infrastructure.StudentModel) (err error)
	ListStudents(params map[string]interface{}) (pagination *[]infrastructure.StudentModel, err error)
	ConvertModelInfraToDomain(studentModelInfra *infrastructure.StudentModel) (studentModelDomain *StudentModel, err error)
	ConvertDomainToModelInfra(studentModelDomain *StudentModel) (studentModelInfra *infrastructure.StudentModel, err error)
}
