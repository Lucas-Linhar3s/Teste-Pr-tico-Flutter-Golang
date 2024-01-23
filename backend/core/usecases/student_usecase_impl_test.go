package usecases_test

import (
	"testing"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/domain/student"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/dtos"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/usecases"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
)

type IStudentRepositoryMock interface {
	CreateStudent(student *dtos.CreateStudentRequestBody) (err error)
	UpdateStudent(student *dtos.UpdateStudentRequestBody) (err error)
	ListStudents(params *dtos.RequestPagination) (pagination *student.Pagination, err error)
}

type RepositoryMock struct {
	mock.Mock
	Students student.Pagination
}

func NewRepositoryMock() *RepositoryMock {
	mock := &RepositoryMock{
		Students: student.Pagination{
			Total: new(int),
			Student: []*student.Student{
				{Code: getNumberPointer(1), Name: getStringPointer("Lucas")},
				{Code: getNumberPointer(2), Name: getStringPointer("Leandro")},
			},
		},
	}

	// Atualize o campo Total na estrutura Pagination
	*mock.Students.Total = len(mock.Students.Student)

	return mock
}

// ListStudents implements student.IStudentRepository.
func (m *RepositoryMock) ListStudents(params *dtos.RequestPagination) (pagination *student.Pagination, err error) {
	args := m.Mock.Called(params)
	return args.Get(0).(*student.Pagination), args.Error(1)
}

// UpdateStudent implements student.IStudentRepository.
func (m *RepositoryMock) UpdateStudent(studentUpdate *dtos.UpdateStudentRequestBody) (err error) {
	args := m.Mock.Called(studentUpdate)

	mock := NewRepositoryMock()

	if args.Error(0) == nil {
		for d, c := range mock.Students.Student {
			if *c.Code == *studentUpdate.Code {
				mock.Students.Student[d].Name = studentUpdate.Name
				break
			}
		}
	}

	return args.Error(0)
}

// CreateStudent implements student.IStudentRepository.
func (m *RepositoryMock) CreateStudent(studentCreate *dtos.CreateStudentRequestBody) (err error) {
	args := m.Mock.Called(studentCreate)

	if m.Students.Student == nil {
		m.Students.Student = make([]*student.Student, 0)
		m.Students.Total = new(int)
	}

	if args.Error(0) == nil {
		newStudent := &student.Student{
			Name: studentCreate.Name,
		}

		m.Students.Student = append(m.Students.Student, newStudent)
	}

	return args.Error(0)
}

// TestCreateStudent testa a função CreateStudent
func TestCreateStudent(t *testing.T) {
	repositoryMock := new(RepositoryMock)

	repositoryMock.On("CreateStudent", mock.AnythingOfType("*dtos.CreateStudentRequestBody")).Return(nil)

	usecase := usecases.NewStudentUsecase(repositoryMock)

	err := usecase.CreateStudent(&dtos.CreateStudentRequestBody{
		Name: getStringPointer("Lucas"),
	})

	// Verifica se não há erro
	assert.NoError(t, err, "Esperava-se nenhum erro ao criar estudante")

	// Verifica se a função CreateCourse foi chamada corretamente
	repositoryMock.AssertExpectations(t)
}

// TestUpdateStudent testa a função UpdateStudent
func TestUpdateStudent(t *testing.T) {
	repositoryMock := new(RepositoryMock)

	repositoryMock.On("UpdateStudent", mock.AnythingOfType("*dtos.UpdateStudentRequestBody")).Return(nil)

	usecase := usecases.NewStudentUsecase(repositoryMock)

	err := usecase.UpdateStudent(&dtos.UpdateStudentRequestBody{
		Code: getNumberPointer(1),
		Name: getStringPointer("Leandro"),
	})

	// Verifica se não há erro
	assert.NoError(t, err, "Esperava-se nenhum erro ao atualizar estudante")

	// Verifica se a função UpdateStudent foi chamada corretamente
	repositoryMock.AssertExpectations(t)
}

func TestListStudents(t *testing.T) {
	repositoryMock := new(RepositoryMock)

	repositoryMock.On("ListStudents", mock.AnythingOfType("*dtos.RequestPagination")).Return(
		&student.Pagination{
			Total: getNumberPointer(2),
			Student: []*student.Student{
				{Code: getNumberPointer(1), Name: getStringPointer("Lucas")},
				{Code: getNumberPointer(2), Name: getStringPointer("Leandro")},
			},
		},
		nil,
	)

	usecase := usecases.NewStudentUsecase(repositoryMock)

	_, err := usecase.ListStudents(&dtos.RequestPagination{
		Limit:  getNumberPointer(10),
		Offset: getNumberPointer(0),
		Search: getStringPointer(""),
	})

	// Verifica se não há erro
	assert.NoError(t, err, "Esperava-se nenhum erro ao listar estudantes")

	// Verifica se a função ListStudents foi chamada corretamente
	repositoryMock.AssertExpectations(t)
}
