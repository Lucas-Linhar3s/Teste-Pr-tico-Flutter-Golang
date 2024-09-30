package students

import (
	"github.com/gin-gonic/gin"
	"github.com/google/wire"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/students/application"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/students/interfaces"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/server"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
)

type Module struct {
	Routes []gin.IRoutes
}

var ExampleModuleSet = wire.NewSet(
	application.NewApplication,
	interfaces.NewHander,
	ModuleRegister,
)

func ModuleRegister(logger *log.Logger, r *server.Server, handler *interfaces.StudentHandler) *Module {
	return &Module{
		Routes: interfaces.Routes(logger, r, handler),
	}
}
