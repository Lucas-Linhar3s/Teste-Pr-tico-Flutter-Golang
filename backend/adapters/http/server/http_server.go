package server

import (
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/adapters/http/service"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/adapters/postgres"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/di"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/docs"
	"github.com/gin-gonic/gin"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

// InitServer inicializa o servidor Gin
func InitServer(port string, conn *postgres.Postgres) (err error) {
	// Configure the dependency injection for the course service
	courseService := di.ConfigCourseDI(conn)

	// Configure the dependency injection for the student service
	studentService := di.ConfigStudentDI(conn)

	r := gin.Default()

	r.Use(
		gin.Logger(),
	)

	// Definir suas rotas aqui
	courseRoutes(r, courseService)
	studentRoutes(r, studentService)
	internalRoutes(r)

	r.NoRoute(func(c *gin.Context) {
		c.JSON(404, gin.H{"code": "PAGE_NOT_FOUND", "message": "Page not found " + " : " + c.Request.URL.String()})
	})

	// Inicia o servidor
	if err = r.Run(port); err != nil {
		return err
	}

	return
}

func courseRoutes(r *gin.Engine, handlers service.ICourseService) {
	course := r.Group("course")
	{
		course.POST("/create", handlers.CreateCourse)
		course.POST("/add-students", handlers.AddStudents)
		course.GET("/list", handlers.ListCourses)
		course.GET("/list-students", handlers.ListCoursesStudent)
		course.PATCH("/update", handlers.UpdateCourse)
	}
}

func studentRoutes(r *gin.Engine, handlers service.IStudentService) {
	student := r.Group("student")
	{
		student.POST("/create", handlers.CreateStudent)
		student.GET("/list", handlers.ListStudents)
		student.PATCH("/update", handlers.UpdateStudent)
	}
}

func internalRoutes(r *gin.Engine) {
	docs.SwaggerInfo.BasePath = "/"
	api := r.Group("api")

	{
		api.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
	}
}
