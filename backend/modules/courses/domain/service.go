package domain

import (
	"go.uber.org/dig"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/database"
)

type serviceDependencies struct {
	dig.In
	Repo ICourses `name:"COURSES_REPOSITORY"`
}

type repositoryDependencies struct {
	dig.In
	Database *database.Database `name:"DATABASE"`
}

// Service struct
type Service struct {
	iCourse ICourses
}

// GetService is a factory method
func GetService(dep serviceDependencies) *Service {
	return &Service{iCourse: dep.Repo}
}

// GetRepository is a factory method
func GetRepository(dep repositoryDependencies) ICourses {
	return newRepository(dep.Database)
}

// CreateCourse creates a new course
func (s *Service) CreateCourse(course *CourseModel) (err error) {
	data, err := s.iCourse.ConvertDomainToModelInfra(course)
	if err != nil {
		return
	}

	return s.iCourse.CreateCourse(data)
}

// AddStudents adds students to a course
func (s *Service) AddStudents(courseStudent *CourseModel) (err error) {
	data, err := s.iCourse.ConvertDomainToModelInfra(courseStudent)
	if err != nil {
		return
	}

	return s.iCourse.AddStudents(data)
}

// UpdateCourse updates a course
func (s *Service) UpdateCourse(course *CourseModel) (err error) {
	data, err := s.iCourse.ConvertDomainToModelInfra(course)
	if err != nil {
		return
	}

	return s.iCourse.UpdateCourse(data)
}

// ListCourses lists all courses
func (s *Service) ListCourses(params map[string]interface{}) (pagination *[]CourseModel, err error) {
	result, err := s.iCourse.ListCourses(params)
	if err != nil {
		return
	}

	pagination = &[]CourseModel{}
	for _, course := range *result {
		var courseDomain *CourseModel
		courseDomain, err = s.iCourse.ConvertModelInfraToDomain(&course)
		if err != nil {
			return
		}

		*pagination = append(*pagination, *courseDomain)
	}

	return
}

// ListCoursesStudents lists students in a course
func (s *Service) ListCoursesStudents(params map[string]interface{}) (pagination *[]CourseModel, err error) {
	result, err := s.iCourse.ListCoursesStudents(params)
	if err != nil {
		return
	}

	pagination = &[]CourseModel{}
	for _, course := range *result {
		var courseDomain *CourseModel
		courseDomain, err = s.iCourse.ConvertModelInfraToDomain(&course)
		if err != nil {
			return
		}

		*pagination = append(*pagination, *courseDomain)
	}

	return
}
