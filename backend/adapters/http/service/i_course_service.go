package service

import (
	"github.com/gin-gonic/gin"
)

// ICourseService is a contract of http adapter layer
type ICourseService interface {
	CreateCourse(c *gin.Context)
	AddStudents(c *gin.Context)
	UpdateCourse(c *gin.Context)
	ListCourses(c *gin.Context)
	ListCoursesStudent(c *gin.Context)
}
