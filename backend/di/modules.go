package di

import (
	"go.uber.org/dig"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/courses"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/students"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/server"
)

func Modules(container *dig.Container) []server.Module {
	return []server.Module{
		*courses.Module(container),
		*students.Module(container),
	}
}
