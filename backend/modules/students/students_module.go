package students

import (
	"go.uber.org/dig"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/students/application"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/students/domain"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/students/interfaces"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/server"
)

type dependenciesModel struct {
	Constructor interface{}
	Token       string
}

var dependencies = []dependenciesModel{
	{
		Constructor: domain.GetRepository,
		Token:       "STUDENTS_REPOSITORY",
	},
	{
		Constructor: domain.GetService,
		Token:       "STUDENTS_SERVICE",
	},
	{
		Constructor: application.NewApplication,
		Token:       "STUDENTS_APP",
	},
	{
		Constructor: interfaces.NewHander,
		Token:       "STUDENTS_HANDLER",
	},
}

// Module binds all modules to the container
func Module(container *dig.Container) *server.Module {
	for _, v := range dependencies {
		if err := container.Provide(v.Constructor, dig.Name(v.Token)); err != nil {

		}
	}
	return &server.Module{
		Group:  "students",
		Routes: interfaces.Routes(container),
	}
}
