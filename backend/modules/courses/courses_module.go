package courses

import (
	"go.uber.org/dig"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/courses/application"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/courses/domain"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/courses/interfaces"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/server"
)

type dependenciesModel struct {
	Constructor interface{}
	Token       string
}

var dependencies = []dependenciesModel{
	{
		Constructor: domain.GetRepository,
		Token:       "COURSES_REPOSITORY",
	},
	{
		Constructor: domain.GetService,
		Token:       "COURSES_SERVICE",
	},
	{
		Constructor: application.NewApplication,
		Token:       "COURSES_APP",
	},
	{
		Constructor: interfaces.NewHander,
		Token:       "COURSES_HANDLER",
	},
}

// Module binds all modules to the container
func Module(container *dig.Container) *server.Module {
	for _, v := range dependencies {
		if err := container.Provide(v.Constructor, dig.Name(v.Token)); err != nil {

		}
	}
	return &server.Module{
		Group:  "courses",
		Routes: interfaces.Routes(container),
	}
}
