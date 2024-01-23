package di

import (
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/adapters/http/handler"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/adapters/http/service"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/adapters/postgres"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/adapters/postgres/repository"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/usecases"
)

func ConfigCourseDI(conn *postgres.Postgres) service.ICourseService {
	courseRepository := repository.NewCourseRepository(conn)
	courseUsecase := usecases.NewCourseUsecase(courseRepository)
	courseService := handler.NewCourseService(courseUsecase)

	return courseService
}

func ConfigStudentDI(conn *postgres.Postgres) service.IStudentService {
	studentRepository := repository.NewStudentRepository(conn)
	studentUsecase := usecases.NewStudentUsecase(studentRepository)
	studentService := handler.NewStudentService(studentUsecase)

	return studentService
}
