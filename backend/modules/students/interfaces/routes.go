package interfaces

import (
	"github.com/gin-gonic/gin"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/middleware"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/server"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
)

func Routes(logger *log.Logger, r *server.Server, handler *StudentHandler) []gin.IRoutes {
	group := r.Router.Group("/students")
	group.Use(
		middleware.CORSMiddleware(),
		middleware.RequestLogMiddleware(logger),
	)
	return []gin.IRoutes{
		group.POST("/create", handler.CreateStudent),
		group.GET("/list", handler.ListStudents),
		group.PATCH("/update", handler.UpdateStudent),
	}
}
