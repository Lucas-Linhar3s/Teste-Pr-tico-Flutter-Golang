package interfaces

import (
	"github.com/gin-gonic/gin"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/middleware"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/server"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
)

func Routes(logger *log.Logger, r *server.Server, handler *CourseHandler) []gin.IRoutes {
	group := r.Router.Group("/courses")
	group.Use(
		middleware.CORSMiddleware(),
		middleware.RequestLogMiddleware(logger),
	)
	return []gin.IRoutes{
		group.POST("/create", handler.CreateCourse),
		group.GET("/list", handler.ListCourses),
		group.GET("/list-students-course", handler.ListStudentsCourse),
		group.PATCH("/update", handler.UpdateCourse),
		group.POST("/add-students", handler.AddStudents),
	}
}
