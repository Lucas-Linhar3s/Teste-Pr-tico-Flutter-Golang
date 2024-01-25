package course

import "github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/dtos"

// ICourseUsecase is a contract of usecase layer
type ICourseUsecase interface {
	CreateCourse(course *dtos.CreateCourseRequestBody) (err error)
	AddStudents(courseStudent *dtos.CreateCourseStudent) (err error)
	UpdateCourse(course *dtos.UpdateCourseRequestBody) (err error)
	ListCourses(params *dtos.RequestPagination) (pagination *Pagination, err error)
	ListCoursesStudents(params *dtos.RequestPagination) (pagination *ListStudentCourse, err error)
}
