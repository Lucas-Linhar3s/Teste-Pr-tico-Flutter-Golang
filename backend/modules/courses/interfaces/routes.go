package interfaces

import (
	"fmt"

	"github.com/gin-gonic/gin"
	"go.uber.org/dig"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/server"
)

type routesDependencies struct {
	dig.In
	Handler *CourseHandler `name:"COURSES_HANDLER"`
}

func Routes(container *dig.Container) []server.Route {
	var dep routesDependencies

	if err := container.Invoke(func(h routesDependencies) {
		dep = h
	}); err != nil {
		panic(fmt.Sprintf("failed to invoke dependencies module STUDENTS: %s", err))

	}

	return []server.Route{
		{
			Method:      "POST",
			Path:        "/create",
			Handler:     dep.Handler.CreateCourse,
			Description: "Create a new course",
			Middlewares: middlewares(),
		},
		{
			Method:      "GET",
			Path:        "/list",
			Handler:     dep.Handler.ListCourses,
			Description: "List courses",
			Middlewares: nil,
		},
		{
			Method:      "GET",
			Path:        "/list-students-course",
			Handler:     dep.Handler.ListStudentsCourse,
			Description: "List students by course",
			Middlewares: nil,
		},
		{
			Method:      "PATCH",
			Path:        "/update",
			Handler:     dep.Handler.UpdateCourse,
			Description: "Update a course",
			Middlewares: middlewares(),
		},
		{
			Method:      "POST",
			Path:        "/add-students",
			Handler:     dep.Handler.AddStudents,
			Description: "Add students to a course",
			Middlewares: middlewares(),
		},
	}
}

func middlewares() []gin.HandlerFunc {
	return []gin.HandlerFunc{}
}
