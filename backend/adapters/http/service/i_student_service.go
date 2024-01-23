package service

import "github.com/gin-gonic/gin"

// IStudentService is a contract of http adapter layer
type IStudentService interface {
	CreateStudent(c *gin.Context)
	UpdateStudent(c *gin.Context)
	ListStudents(c *gin.Context)
}
