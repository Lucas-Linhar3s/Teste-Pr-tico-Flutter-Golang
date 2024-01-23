package student

import "github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/dtos"

// IStudentUsecase is a contract of usecase layer
type IStudentUsecase interface {
	CreateStudent(student *dtos.CreateStudentRequestBody) (err error)
	UpdateStudent(student *dtos.UpdateStudentRequestBody) (err error)
	ListStudents(params *dtos.RequestPagination) (pagination *Pagination, err error)
}
