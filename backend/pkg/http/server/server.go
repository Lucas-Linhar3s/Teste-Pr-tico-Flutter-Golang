package server

import (
	"github.com/gin-gonic/gin"
	swaggerfiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/docs"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/config"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/jwt"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
)

// Server http server
type Server struct {
	Router *gin.Engine
}

// NewServer new server with router
func NewServer() *Server {
	return &Server{
		Router: gin.Default(),
	}
}

// // Run server
func (s *Server) Run(logger *log.Logger,
	jwt *jwt.JWT, conf *config.Config) error {
	// swagger doc
	docs.SwaggerInfo.BasePath = "/"
	// docs
	swag := s.Router.Group("/swagger")
	swag.GET("/*any", ginSwagger.WrapHandler(
		swaggerfiles.Handler,
	))

	s.Router.NoRoute(func(c *gin.Context) {
		c.JSON(404, gin.H{"code": "PAGE_NOT_FOUND", "message": "Page not found " + " : " + c.Request.URL.String()})
	})
	return s.Router.Run(conf.Http.Port)
}
