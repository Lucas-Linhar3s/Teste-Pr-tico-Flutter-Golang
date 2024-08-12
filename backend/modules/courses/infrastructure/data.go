package infrastructure

import (
	"database/sql"
	"errors"
	"fmt"

	"github.com/Masterminds/squirrel"
	"github.com/duke-git/lancet/convertor"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/database"
)

type PGCourse struct {
	Db *database.Database
}

// CreateCourse creates a new course
func (r *PGCourse) CreateCourse(course *CourseModel) (err error) {
	if _, err = r.Db.Builder.
		Insert("manager.curso").
		Columns("descricao", "ementa").
		Values(course.Description, course.Ementa).
		Exec(); err != nil {
		return
	}
	return
}

// AddStudents adds students to a course
func (r *PGCourse) AddStudents(courseStudent *CourseModel) (err error) {
	var courntStudent int
	var countCourse int

	// Verifica se o aluno já está matriculado em 3 cursos
	if err = r.Db.Builder.
		Select("COUNT(*)").
		From("manager.curso_aluno").
		Where(squirrel.Eq{"codigo_aluno": courseStudent.StudentCode}).
		Scan(&courntStudent); err != nil {
		return err
	}

	if courntStudent >= 3 {
		return errors.New("student already enrolled in 3 courses")
	}

	// Verifica se o curso já atingiu o limite de 10 alunos matriculados
	if err = r.Db.Builder.
		Select("COUNT(*)").
		From("manager.curso_aluno").
		Where(squirrel.Eq{"codigo_curso": courseStudent.Code}).
		Scan(&countCourse); err != nil {
		return err
	}

	if countCourse >= 10 {
		return errors.New("course is full")
	}

	// Cria o relacionamento entre o curso e o aluno
	if _, err = r.Db.Builder.
		Insert("manager.curso_aluno").
		Columns("codigo_curso", "codigo_aluno").
		Values(courseStudent.Code, courseStudent.StudentCode).
		Exec(); err != nil {
		return
	}
	return
}

// ListCourses lists all courses
func (r *PGCourse) ListCourses(params map[string]interface{}) (pagination *[]CourseModel, err error) {
	var rows *sql.Rows

	limit, err := convertor.ToInt(params["limit"])
	offset, err := convertor.ToInt(params["offset"])
	if err != nil {
		return
	}
	if rows, err = r.Db.Builder.
		Select("codigo", "descricao", "ementa").
		Column("COUNT(*) OVER() AS count").
		From("manager.curso").
		Where(
			squirrel.Case().
				When(squirrel.Eq{"descricao": ""}, squirrel.Expr("true")).
				Else(squirrel.ILike{"descricao": fmt.Sprintf("%%%s%%", params["descricao"])}),
		).
		OrderBy("codigo").
		Limit(uint64(limit)).
		Offset(uint64(offset)).
		Query(); err != nil {
		return
	}
	defer rows.Close()

	pagination = &[]CourseModel{}
	for rows.Next() {
		var course CourseModel
		if err = rows.Scan(&course.Code, &course.Description, &course.Ementa, &course.Total); err != nil {
			return
		}
		*pagination = append(*pagination, course)
	}

	return
}

// ListCoursesStudents lists students in a course
func (r *PGCourse) ListCoursesStudents(params map[string]interface{}) (pagination *[]CourseModel, err error) {
	var rows *sql.Rows

	if rows, err = r.Db.Builder.
		Select("s.codigo", "s.nome").
		Column("COUNT(*) OVER() AS count").
		From("manager.curso_aluno ca").
		Join("manager.aluno s ON s.codigo = ca.codigo_aluno").
		Where(
			squirrel.Eq{"ca.codigo_curso::INTEGER": params["code"]},
		).
		Query(); err != nil {
		return
	}
	defer rows.Close()

	pagination = &[]CourseModel{}
	for rows.Next() {
		var student CourseModel
		if err = rows.Scan(&student.Code, &student.StudentName, &student.Total); err != nil {
			return
		}
		*pagination = append(*pagination, student)
	}
	return
}

// UpdateCourse updates a course
func (r *PGCourse) UpdateCourse(course *CourseModel) (err error) {
	var exist bool

	if err = r.Db.Builder.
		Select("COUNT(*) > 0").
		From("manager.curso").
		Where(squirrel.Eq{"codigo": course.Code}).
		Scan(&exist); err != nil {
		return
	}

	if exist {
		if _, err = r.Db.Builder.
			Update("manager.curso").
			Set("descricao", course.Description).
			Set("ementa", course.Ementa).
			Where(squirrel.Eq{"codigo": course.Code}).
			Exec(); err != nil {
			return
		}
	} else {
		err = errors.New("course not found")
		return
	}
	return
}
