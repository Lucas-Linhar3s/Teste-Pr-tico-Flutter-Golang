package student

import "github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/dtos"

// IStudentRepository is a contract of database connection adapter layer
type IStudentRepository interface {
	CreateStudent(student *dtos.CreateStudentRequestBody) (err error)
	UpdateStudent(student *dtos.UpdateStudentRequestBody) (err error)
	ListStudents(params *dtos.RequestPagination) (pagination *Pagination, err error)
}
