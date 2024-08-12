package main

import (
	d "go.uber.org/dig"
	"go.uber.org/zap"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/di"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/config"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/dig"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/server"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/jwt"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
)

type dependencies struct {
	d.In
	Log        *log.Logger    `name:"LOGGER"`
	HTTPServer *server.Server `name:"SERVER"`
	JWT        *jwt.JWT       `name:"JWT"`
	Config     *config.Config `name:"CONFIG"`
}

// @title TESTE PRATICO FLUTTER/GOLANG API
// @version 1.0.1
// @description Esse e um teste pratico para a vaga Flutter/Golang da empresa X.
// @termsOfService  http://swagger.io/terms/
// @contact.name   API Support
// @contact.url    http://www.swagger.io/support
// @contact.email  support@swagger.io
// @license.name  Apache 2.0
// @license.url   http://www.apache.org/licenses/LICENSE-2.0.html
// @host      localhost:8000
// @securityDefinitions.apiKey Bearer
// @in header
// @name Authorization
// @externalDocs.description  OpenAPI
// @externalDocs.url          https://swagger.io/resources/open-api/
func main() {
	var err error
	var dep *dependencies
	container := dig.BuildContainer()

	if err = di.RegisterDI(container); err != nil {
		panic(err)
	}

	if dep, err = dig.InvokeService(container, dep); err != nil {
		panic(err)
	}

	if err := dig.ResgisterModules(container, dep.HTTPServer.Router, dep.Log, dep.Config); err != nil {
		dep.Log.Logger.Fatal("error in resgister modules", zap.Error(err))
	}

	if err = dep.HTTPServer.Run(dep.Log, dep.JWT, dep.Config); err != nil {
		dep.Log.Logger.Fatal("error in init server", zap.Error(err))
	}
}
