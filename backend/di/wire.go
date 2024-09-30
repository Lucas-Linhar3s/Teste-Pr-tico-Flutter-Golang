//go:build wireinject
// +build wireinject

package di

import (
	"github.com/google/wire"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/database"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/courses"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/students"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/config"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/server"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/jwt"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
)

type App struct {
	Server *server.Server
	Config *config.Config
	Logger *log.Logger
}

func newApp(
	server *server.Server,
	config *config.Config, logger *log.Logger,

	courseModule *courses.Module,
	studentModule *students.Module,
) *App {
	return &App{
		Server: server,
		Config: config,
		Logger: logger,
	}
}

var globalSet = wire.NewSet(
	config.NewViper,
	config.LoadAttributes,
	jwt.NewJwt,
	log.NewLog,
	server.NewServer,
	database.NewDatabase,
	newApp,
)

func Initialize() (*App, func(), error) {
	panic(wire.Build(
		globalSet,
		courses.ExampleModuleSet,
		students.ExampleModuleSet,
	))
}
