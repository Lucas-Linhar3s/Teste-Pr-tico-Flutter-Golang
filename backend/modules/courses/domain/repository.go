package domain

import (
	"errors"

	"github.com/jinzhu/copier"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/database"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/courses/infrastructure"
)

type repository struct {
	repo infrastructure.PGCourse
}

func newRepository(db *database.Database) *repository {
	return &repository{
		repo: infrastructure.PGCourse{Db: db},
	}
}

// AddStudents implements ICourses.
func (r *repository) AddStudents(courseStudent *infrastructure.CourseModel) (err error) {
	return r.repo.AddStudents(courseStudent)
}

// CreateCourse implements ICourses.
func (r *repository) CreateCourse(course *infrastructure.CourseModel) (err error) {
	return r.repo.CreateCourse(course)
}

// ListCourses implements ICourses.
func (r *repository) ListCourses(params map[string]interface{}) (pagination *[]infrastructure.CourseModel, err error) {
	return r.repo.ListCourses(params)
}

// ListCoursesStudents implements ICourses.
func (r *repository) ListCoursesStudents(params map[string]interface{}) (pagination *[]infrastructure.CourseModel, err error) {
	return r.repo.ListCoursesStudents(params)
}

// UpdateCourse implements ICourses.
func (r *repository) UpdateCourse(course *infrastructure.CourseModel) (err error) {
	return r.repo.UpdateCourse(course)
}

// ConvertDomainToModelInfra converts domain model to infra model
func (r *repository) ConvertDomainToModelInfra(studentModelDomain *CourseModel) (studentModelInfra *infrastructure.CourseModel, err error) {
	var data infrastructure.CourseModel
	if studentModelDomain == nil {
		return nil, errors.New("courseModelDomain is nil")
	}

	if err = copier.Copy(&data, studentModelDomain); err != nil {
		return nil, err
	}

	return &data, nil
}

// ConvertModelInfraToDomain converts infra model to domain model
func (r *repository) ConvertModelInfraToDomain(studentModelInfra *infrastructure.CourseModel) (studentModelDomain *CourseModel, err error) {
	var data CourseModel
	if studentModelInfra == nil {
		return nil, errors.New("courseModelInfra is nil")
	}

	if err = copier.Copy(&data, studentModelInfra); err != nil {
		return nil, err
	}

	return &data, nil
}
