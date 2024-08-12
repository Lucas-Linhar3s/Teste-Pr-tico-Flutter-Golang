package interfaces

import (
	"fmt"

	"github.com/gin-gonic/gin"
	"go.uber.org/dig"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/server"
)

type routesDependencies struct {
	dig.In
	Handler *StudentHandler `name:"STUDENTS_HANDLER"`
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
			Handler:     dep.Handler.CreateStudent,
			Description: "Create a new student",
			Middlewares: middlewares(),
		},
		{
			Method:      "GET",
			Path:        "/list",
			Handler:     dep.Handler.ListStudents,
			Description: "List students",
			Middlewares: nil,
		},
		{
			Method:      "PATCH",
			Path:        "/update",
			Handler:     dep.Handler.UpdateStudent,
			Description: "Update a student",
			Middlewares: middlewares(),
		},
	}
}

func middlewares() []gin.HandlerFunc {
	return []gin.HandlerFunc{}
}
