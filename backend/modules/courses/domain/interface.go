package domain

import (
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/courses/infrastructure"
)

// ICourses is a interface
type ICourses interface {
	CreateCourse(course *infrastructure.CourseModel) (err error)
	AddStudents(courseStudent *infrastructure.CourseModel) (err error)
	UpdateCourse(course *infrastructure.CourseModel) (err error)
	ListCourses(params map[string]interface{}) (pagination *[]infrastructure.CourseModel, err error)
	ListCoursesStudents(params map[string]interface{}) (pagination *[]infrastructure.CourseModel, err error)
	ConvertModelInfraToDomain(studentModelInfra *infrastructure.CourseModel) (studentModelDomain *CourseModel, err error)
	ConvertDomainToModelInfra(studentModelDomain *CourseModel) (studentModelInfra *infrastructure.CourseModel, err error)
}
