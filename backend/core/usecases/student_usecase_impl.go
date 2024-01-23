package usecases

import (
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/domain/student"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/dtos"
)

type studentUsecaseImpl struct {
	studentRepository student.IStudentRepository
}

// NewStudentUsecase is a constructor of studentUsecaseImpl
func NewStudentUsecase(studentRepository student.IStudentRepository) student.IStudentUsecase {
	return &studentUsecaseImpl{
		studentRepository: studentRepository,
	}
}

// CreateStudent implements student.IStudentUsecase.
func (u *studentUsecaseImpl) CreateStudent(student *dtos.CreateStudentRequestBody) (err error) {
	return u.studentRepository.CreateStudent(student)
}

// ListStudents implements student.IStudentUsecase.
func (u *studentUsecaseImpl) ListStudents(params *dtos.RequestPagination) (pagination *student.Pagination, err error) {
	return u.studentRepository.ListStudents(params)
}

// UpdateStudent implements student.IStudentUsecase.
func (u *studentUsecaseImpl) UpdateStudent(student *dtos.UpdateStudentRequestBody) (err error) {
	return u.studentRepository.UpdateStudent(student)
}
