package repository

import (
	"database/sql"
	"errors"
	"fmt"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/adapters/postgres"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/domain/student"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/dtos"
	sq "github.com/Masterminds/squirrel"
)

type studentRepositoryImpl struct {
	db *postgres.Postgres
}

// NewStudentRepository returns contract implementation of ProductRepository
func NewStudentRepository(db *postgres.Postgres) student.IStudentRepository {
	return &studentRepositoryImpl{
		db: db,
	}
}

// CreateStudent implements student.IStudentRepository.
func (r *studentRepositoryImpl) CreateStudent(student *dtos.CreateStudentRequestBody) (err error) {
	if _, err = r.db.Builder.
		Insert("aluno").
		Columns("nome").
		Values(student.Name).
		Exec(); err != nil {
		return
	}
	return
}

// ListStudents implements student.IStudentRepository.
func (r *studentRepositoryImpl) ListStudents(params *dtos.RequestPagination) (pagination *student.Pagination, err error) {
	var rows *sql.Rows

	if rows, err = r.db.Builder.
		Select("codigo", "nome").
		Column("COUNT(*) OVER() AS count").
		From("aluno").
		Where(
			sq.Case().
				When(sq.Eq{"nome": ""}, sq.Expr("true")).
				Else(sq.ILike{"unaccent(nome)": fmt.Sprintf("%%%s%%", *params.Search)}),
		).
		Limit(uint64(*params.Limit)).
		Offset(uint64(*params.Offset)).
		Query(); err != nil {
		return
	}
	defer rows.Close()

	pagination = &student.Pagination{}

	for rows.Next() {
		var student student.Student
		if err = rows.Scan(&student.Code, &student.Name, &pagination.Total); err != nil {
			return
		}
		pagination.Student = append(pagination.Student, &student)
	}
	return
}

// UpdateStudent implements student.IStudentRepository.
func (r *studentRepositoryImpl) UpdateStudent(student *dtos.UpdateStudentRequestBody) (err error) {
	var exist bool

	if err = r.db.Builder.
		Select("COUNT(*) > 0").
		From("aluno").
		Where(sq.Eq{"codigo": student.Code}).
		Scan(&exist); err != nil {
		return
	}

	if exist {
		if _, err = r.db.Builder.
			Update("aluno").
			Set("nome", student.Name).
			Where(sq.Eq{"codigo": student.Code}).
			Exec(); err != nil {
			return
		}
	} else {
		err = errors.New("student not found")
		return
	}
	return
}
