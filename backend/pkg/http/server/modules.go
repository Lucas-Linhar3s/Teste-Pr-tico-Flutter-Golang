package server

import (
	"github.com/gin-gonic/gin"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/middleware"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/config"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
)

// Modules represents all modules of the application
type Route struct {
	Method      string
	Path        string
	Handler     gin.HandlerFunc
	Description string
	Middlewares []gin.HandlerFunc
}

// Module represents a module of the application
type Module struct {
	Group  string
	Routes []Route
}

// Register register modules
func (m *Module) Register(router *gin.Engine, logger *log.Logger, config *config.Config) {
	group := router.Group(("/" + m.Group))
	group.Use(
		middleware.CORSMiddleware(),
		middleware.RequestLogMiddleware(logger),
		middleware.SignMiddleware(logger, config),
	)
	for _, route := range m.Routes {
		handlers := append(route.Middlewares, route.Handler)
		switch route.Method {
		case "GET":
			group.GET(route.Path, handlers...)
		case "POST":
			group.POST(route.Path, handlers...)
		case "PUT":
			group.PUT(route.Path, handlers...)
		case "DELETE":
			group.DELETE(route.Path, handlers...)
		case "PATCH":
			group.PATCH(route.Path, handlers...)
		default:
			group.Any(route.Path, handlers...)
		}
	}
}
