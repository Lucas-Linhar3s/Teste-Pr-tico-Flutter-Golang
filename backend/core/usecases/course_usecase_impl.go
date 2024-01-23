package usecases

import (
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/domain/course"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/dtos"
)

type courseUsecaseImpl struct {
	courseRepository course.ICourseRepository
}

// NewCourseUsecase creates a new course usecase
func NewCourseUsecase(courseRepository course.ICourseRepository) course.ICourseUsecase {
	return &courseUsecaseImpl{
		courseRepository: courseRepository,
	}
}

// CreateCourse implements course.ICourseUsecase.
func (u *courseUsecaseImpl) CreateCourse(course *dtos.CreateCourseRequestBody) (err error) {
	return u.courseRepository.CreateCourse(course)
}

// AddStudents implements course.ICourseUsecase.
func (u *courseUsecaseImpl) AddStudents(courseStudent *dtos.CreateCourseStudent) (err error) {
	return u.courseRepository.AddStudents(courseStudent)
}

// ListCourses implements course.ICourseUsecase.
func (u *courseUsecaseImpl) ListCourses(params *dtos.RequestPagination) (pagination *course.Pagination, err error) {
	return u.courseRepository.ListCourses(params)
}

// ListCoursesStudents implements course.ICourseUsecase.
func (u *courseUsecaseImpl) ListCoursesStudents(params *dtos.RequestPagination) (pagination *course.ListStudentCourse, err error) {
	return u.courseRepository.ListCoursesStudents(params)
}

// UpdateCourse implements course.ICourseUsecase.
func (u *courseUsecaseImpl) UpdateCourse(course *dtos.UpdateCourseRequestBody) (err error) {
	return u.courseRepository.UpdateCourse(course)
}
