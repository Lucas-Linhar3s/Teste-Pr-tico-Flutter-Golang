package infrastructure

import (
	"database/sql"
	"errors"
	"fmt"

	"github.com/Masterminds/squirrel"
	"github.com/duke-git/lancet/convertor"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/database"
)

type PGStudent struct {
	Db *database.Database
}

// CreateStudent creates a new student
func (r *PGStudent) CreateStudent(student *StudentModel) (err error) {
	if _, err = r.Db.Builder.
		Insert("aluno").
		Columns("nome").
		Values(student.Name).
		Exec(); err != nil {
		return
	}
	return
}

// ListStudents lists all students
func (r *PGStudent) ListStudents(params map[string]interface{}) (pagination *[]StudentModel, err error) {
	var rows *sql.Rows

	limit, err := convertor.ToInt(params["limit"])
	offset, err := convertor.ToInt(params["offset"])
	if err != nil {
		return
	}
	if rows, err = r.Db.Builder.
		Select("codigo", "nome").
		Column("COUNT(*) OVER() AS count").
		From("aluno").
		Where(
			squirrel.Case().
				When(squirrel.Eq{"nome": ""}, squirrel.Expr("true")).
				Else(squirrel.ILike{"unaccent(nome)": fmt.Sprintf("%%%s%%", params["name"])}),
		).
		OrderBy("codigo").
		Limit(uint64(limit)).
		Offset(uint64(offset)).
		Query(); err != nil {
		return
	}
	defer rows.Close()

	pagination = &[]StudentModel{}

	for rows.Next() {
		var student StudentModel
		if err = rows.Scan(&student.Code, &student.Name, &student.Total); err != nil {
			return
		}
		*pagination = append(*pagination, student)
	}
	return
}

// UpdateStudent updates a student
func (r *PGStudent) UpdateStudent(student *StudentModel) (err error) {
	var exist bool

	if err = r.Db.Builder.
		Select("COUNT(*) > 0").
		From("aluno").
		Where(squirrel.Eq{"codigo": student.Code}).
		Scan(&exist); err != nil {
		return
	}

	if exist {
		if _, err = r.Db.Builder.
			Update("aluno").
			Set("nome", student.Name).
			Where(squirrel.Eq{"codigo": student.Code}).
			Exec(); err != nil {
			return
		}
	} else {
		err = errors.New("student not found")
		return
	}
	return
}
