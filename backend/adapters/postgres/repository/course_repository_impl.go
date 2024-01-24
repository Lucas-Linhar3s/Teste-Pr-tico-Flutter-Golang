package repository

import (
	"database/sql"
	"errors"
	"fmt"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/adapters/postgres"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/domain/course"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/dtos"
	sq "github.com/Masterminds/squirrel"
)

type courseRepositoryImpl struct {
	db *postgres.Postgres
}

// NewCourseRepository returns contract implementation of ProductRepository
func NewCourseRepository(db *postgres.Postgres) course.ICourseRepository {
	return &courseRepositoryImpl{
		db: db,
	}
}

// CreateCourse implements course.ICourseRepository.
func (r *courseRepositoryImpl) CreateCourse(course *dtos.CreateCourseRequestBody) (err error) {
	if _, err = r.db.Builder.
		Insert("curso").
		Columns("descricao", "ementa").
		Values(course.Description, course.Ementa).
		Exec(); err != nil {
		return
	}
	return
}

// AddStudents implements course.ICourseRepository.
func (r *courseRepositoryImpl) AddStudents(courseStudent *dtos.CreateCourseStudent) (err error) {
	var courntStudent int
	var countCourse int

	// Verifica se o aluno já está matriculado em 3 cursos
	if err = r.db.Builder.
		Select("COUNT(*)").
		From("curso_aluno").
		Where(sq.Eq{"codigo_aluno": courseStudent.CodeStudent}).
		Scan(&courntStudent); err != nil {
		return err
	}

	if courntStudent >= 3 {
		return errors.New("student already enrolled in 3 courses")
	}

	// Verifica se o curso já atingiu o limite de 10 alunos matriculados
	if err = r.db.Builder.
		Select("COUNT(*)").
		From("curso_aluno").
		Where(sq.Eq{"codigo_curso": courseStudent.CodeCourse}).
		Scan(&countCourse); err != nil {
		return err
	}

	if countCourse >= 10 {
		return errors.New("course is full")
	}

	// Cria o relacionamento entre o curso e o aluno
	if _, err = r.db.Builder.
		Insert("curso_aluno").
		Columns("codigo_curso", "codigo_aluno").
		Values(courseStudent.CodeCourse, courseStudent.CodeStudent).
		Exec(); err != nil {
		return
	}
	return
}

// ListCourses implements course.ICourseRepository.
func (r *courseRepositoryImpl) ListCourses(params *dtos.RequestPagination) (pagination *course.Pagination, err error) {
	var rows *sql.Rows

	if rows, err = r.db.Builder.
		Select("codigo", "descricao", "ementa").
		Column("COUNT(*) OVER() AS count").
		From("curso").
		Where(
			sq.Case().
				When(sq.Eq{"descricao": ""}, sq.Expr("true")).
				Else(sq.ILike{"descricao": fmt.Sprintf("%%%s%%", *params.Search)}),
		).
		OrderBy("codigo").
		Limit(uint64(*params.Limit)).
		Offset(uint64(*params.Offset)).
		Query(); err != nil {
		return
	}
	defer rows.Close()

	pagination = &course.Pagination{}

	for rows.Next() {
		var course course.Course
		if err = rows.Scan(&course.Code, &course.Description, &course.Ementa, &pagination.Total); err != nil {
			return
		}
		pagination.Courses = append(pagination.Courses, &course)
	}

	return
}

// ListCoursesStudents implements course.ICourseRepository.
func (r *courseRepositoryImpl) ListCoursesStudents(params *dtos.RequestPagination) (pagination *course.ListStudentCourse, err error) {
	var rows *sql.Rows

	if rows, err = r.db.Builder.
		Select("s.codigo", "s.nome").
		Column("COUNT(*) OVER() AS count").
		From("curso_aluno ca").
		Join("aluno s ON s.codigo = ca.codigo_aluno").
		Where(
			sq.Eq{"ca.codigo_curso::INTEGER": params.Search},
		).
		Query(); err != nil {
		return
	}
	defer rows.Close()

	pagination = &course.ListStudentCourse{}

	for rows.Next() {
		var student course.Student
		if err = rows.Scan(&student.Code, &student.Name, &pagination.Total); err != nil {
			return
		}
		pagination.Student = append(pagination.Student, &student)
	}
	return
}

// UpdateCourse implements course.ICourseRepository.
func (r *courseRepositoryImpl) UpdateCourse(course *dtos.UpdateCourseRequestBody) (err error) {
	var exist bool

	if err = r.db.Builder.
		Select("COUNT(*) > 0").
		From("curso").
		Where(sq.Eq{"codigo": course.Code}).
		Scan(&exist); err != nil {
		return
	}

	if exist {
		if _, err = r.db.Builder.
			Update("curso").
			Set("descricao", course.Description).
			Set("ementa", course.Ementa).
			Where(sq.Eq{"codigo": course.Code}).
			Exec(); err != nil {
			return
		}
	} else {
		err = errors.New("course not found")
		return
	}
	return
}
