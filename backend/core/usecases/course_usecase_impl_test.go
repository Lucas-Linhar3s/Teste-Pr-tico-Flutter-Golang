package usecases_test

import (
	"testing"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/domain/course"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/dtos"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/usecases"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
)

type IRepositoryMock interface {
	CreateCourse(course *dtos.CreateCourseRequestBody) (err error)
	AddStudents(courseStudent *dtos.CreateCourseStudent) (err error)
	UpdateCourse(course *dtos.UpdateCourseRequestBody) (err error)
	ListCourses(params *dtos.RequestPagination) (pagination *course.Pagination, err error)
	ListCoursesStudents(params *dtos.RequestPagination) (pagination *course.ListStudentCourse, err error)
}

type RepositoryMockCourse struct {
	mock.Mock
	Courses       course.Pagination
	CourseStudent course.CourseStudent
}

// ListCourses implements course.ICourseRepository.
func (m *RepositoryMockCourse) ListCourses(params *dtos.RequestPagination) (pagination *course.Pagination, err error) {
	args := m.Mock.Called(params)
	return args.Get(0).(*course.Pagination), args.Error(1)
}

// AddStudents implements course.ICourseRepository.
func (m *RepositoryMockCourse) AddStudents(courseStudent *dtos.CreateCourseStudent) (err error) {
	args := m.Mock.Called(courseStudent)

	code := 0

	if args.Error(0) == nil {
		newCourseStudent := &course.CourseStudent{
			Code:        getNumberPointer(code + 1),
			CodeStudent: courseStudent.CodeStudent,
			CodeCourse:  courseStudent.CodeCourse,
		}

		m.CourseStudent = *newCourseStudent
	}

	return args.Error(0)
}

// CreateCourse implements course.ICourseRepository.
func (m *RepositoryMockCourse) CreateCourse(courseCreate *dtos.CreateCourseRequestBody) (err error) {
	args := m.Mock.Called(courseCreate)

	code := 0
	if m.Courses.Courses == nil {
		m.Courses.Courses = make([]*course.Course, 0)
		m.Courses.Total = new(int)
	}

	if args.Error(0) == nil {
		newCourse := &course.Course{
			Code:        getNumberPointer(code + 1),
			Description: courseCreate.Description,
			Ementa:      courseCreate.Ementa,
		}

		m.Courses.Courses = append(m.Courses.Courses, newCourse)
	}

	return args.Error(0)
}

// ListCoursesStudents implements course.ICourseRepository.
func (m *RepositoryMockCourse) ListCoursesStudents(params *dtos.RequestPagination) (pagination *course.ListStudentCourse, err error) {
	args := m.Mock.Called(params)
	return args.Get(0).(*course.ListStudentCourse), args.Error(1)
}

// UpdateCourse implements course.ICourseRepository.
func (m *RepositoryMockCourse) UpdateCourse(courseUpdate *dtos.UpdateCourseRequestBody) (err error) {
	args := m.Mock.Called(courseUpdate)

	mock := NewRepository()

	if args.Error(0) == nil {
		for d, c := range mock.Courses.Courses {
			if *c.Code == *courseUpdate.Code {
				mock.Courses.Courses[d].Description = courseUpdate.Description
				mock.Courses.Courses[d].Ementa = courseUpdate.Ementa
				break
			}
		}
	}

	return args.Error(0)
}

func NewRepository() *RepositoryMockCourse {
	return &RepositoryMockCourse{
		Courses: course.Pagination{
			Total: getNumberPointer(2),
			Courses: []*course.Course{
				{Code: getNumberPointer(1), Description: getStringPointer("Teste"), Ementa: getStringPointer("Teste")},
				{Code: getNumberPointer(2), Description: getStringPointer("Teste"), Ementa: getStringPointer("Teste")},
			},
		},
		CourseStudent: course.CourseStudent{
			Code:        getNumberPointer(1),
			CodeStudent: getNumberPointer(1),
			CodeCourse:  getNumberPointer(1),
		},
	}
}

// TestCreateCourse testa a função CreateCourse
func TestCreateCourse(t *testing.T) {
	repositoryMock := new(RepositoryMockCourse)

	repositoryMock.On("CreateCourse", mock.Anything).Return(nil)

	usecase := usecases.NewCourseUsecase(repositoryMock)

	err := usecase.CreateCourse(&dtos.CreateCourseRequestBody{
		Description: getStringPointer("Novo Curso"),
		Ementa:      getStringPointer("Ementa do curso"),
	})

	assert.NoError(t, err, "Esperava-se nenhum erro ao criar curso")

	repositoryMock.AssertExpectations(t)
}

// TestAddStudents testa a função AddStudents
func TestAddStudents(t *testing.T) {
	repository := NewRepository()

	repository.On("AddStudents", mock.Anything).Return(nil)

	usecase := usecases.NewCourseUsecase(repository)

	err := usecase.AddStudents(&dtos.CreateCourseStudent{
		CodeStudent: getNumberPointer(1),
		CodeCourse:  getNumberPointer(3),
	})

	assert.NoError(t, err, "Esperava-se nenhum erro ao adicionar estudantes ao curso")
	repository.AssertExpectations(t)
}

// TestUpdateCourse testa a função UpdateCourse
func TestUpdateCourse(t *testing.T) {
	repository := NewRepository()

	repository.On("UpdateCourse", mock.Anything).Return(nil)

	usecase := usecases.NewCourseUsecase(repository)

	err := usecase.UpdateCourse(&dtos.UpdateCourseRequestBody{
		Code:        getNumberPointer(1),
		Description: getStringPointer("Curso Atualizado"),
		Ementa:      getStringPointer("Ementa atualizada"),
	})

	assert.NoError(t, err, "Esperava-se nenhum erro ao atualizar curso")
	repository.AssertExpectations(t)
}

// TestListCourses testa a função ListCourses
func TestListCourses(t *testing.T) {
	repository := NewRepository()

	repository.On("ListCourses", mock.Anything).Return(&course.Pagination{
		Total: getNumberPointer(2),
		Courses: []*course.Course{
			{Code: getNumberPointer(1), Description: getStringPointer("Teste"), Ementa: getStringPointer("Teste")},
			{Code: getNumberPointer(2), Description: getStringPointer("Teste"), Ementa: getStringPointer("Teste")},
		},
	}, nil)

	usecase := usecases.NewCourseUsecase(repository)

	pagination, err := usecase.ListCourses(&dtos.RequestPagination{})

	assert.NoError(t, err, "Esperava-se nenhum erro ao listar cursos")
	assert.Equal(t, 2, *pagination.Total, "Esperava-se 2 cursos na lista")
	repository.AssertExpectations(t)
}

// TestListCoursesStudents testa a função ListCoursesStudents
func TestListCoursesStudents(t *testing.T) {
	repository := NewRepository()

	repository.On("ListCoursesStudents", mock.Anything).Return(&course.ListStudentCourse{}, nil)

	usecase := usecases.NewCourseUsecase(repository)

	_, err := usecase.ListCoursesStudents(&dtos.RequestPagination{})

	assert.NoError(t, err, "Esperava-se nenhum erro ao listar estudantes do curso")
	repository.AssertExpectations(t)
}

// getStringPointer retorna um ponteiro para a string fornecida.
func getStringPointer(s string) *string {
	return &s
}

// getNumberPointer retorna um ponteiro para o número fornecido.
func getNumberPointer(n int) *int {
	return &n
}
