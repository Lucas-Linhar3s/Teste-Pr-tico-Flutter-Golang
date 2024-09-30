package courses

import (
	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"github.com/google/wire"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/courses/application"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/courses/interfaces"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/server"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
)

var ExampleModuleSet = wire.NewSet(
	application.NewApplication,
	interfaces.NewHander,
	ModuleRegister,
)

type Module struct {
	Routes []gin.IRoutes
}

func ModuleRegister(logger *log.Logger, r *server.Server, handler *interfaces.CourseHandler) *Module {
	validator.New()
	return &Module{
		Routes: interfaces.Routes(logger, r, handler),
	}
}
