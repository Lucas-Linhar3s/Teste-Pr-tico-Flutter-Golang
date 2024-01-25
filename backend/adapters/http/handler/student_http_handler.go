package handler

import (
	"net/http"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/adapters/http/service"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/domain/student"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/dtos"
	"github.com/gin-gonic/gin"
)

type studentServiceImpl struct {
	studentService student.IStudentUsecase
}

// NewStudentService is a constructor of studentServiceImpl
func NewStudentService(studentService student.IStudentUsecase) service.IStudentService {
	return &studentServiceImpl{
		studentService: studentService,
	}
}

// @Summary Create a new student
// @Description Create a new student with the provided data
// @Tags Student
// @ID create-student
// @Accept json
// @Produce json
// @Param input body dtos.CreateStudentRequestBody true "Student data to create"
// @Success 204 {string} string "No Content"
// @Router /student/create [post]
func (s *studentServiceImpl) CreateStudent(c *gin.Context) {
	var studentRequestBody dtos.CreateStudentRequestBody

	if err := c.ShouldBindJSON(&studentRequestBody); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	err := s.studentService.CreateStudent(&studentRequestBody)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(204, nil)
}

// @Summary List students
// @Description Get a list of students with pagination
// @ID list-students
// @Tags Student
// @Accept json
// @Produce json
// @Param limit query int true "Limit the number of results (default is 10)"
// @Param offset query int true "Offset for pagination"
// @Param search query string false "Search term"
// @Success 200 {object} student.Pagination
// @Router /student/list [get]
func (s *studentServiceImpl) ListStudents(c *gin.Context) {
	params, err := dtos.FromValueRequestPagination(c.Request)

	pagination, err := s.studentService.ListStudents(params)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(200, pagination)
}

// @Summary Update a student
// @Description Update an existing student with the provided data
// @Tags Student
// @ID update-student
// @Accept json
// @Produce json
// @Param input body dtos.UpdateStudentRequestBody true "Student data to update"
// @Success 204 {string} string "No Content"
// @Router /student/update [patch]
func (s *studentServiceImpl) UpdateStudent(c *gin.Context) {
	var studentRequestBody dtos.UpdateStudentRequestBody

	if err := c.ShouldBindJSON(&studentRequestBody); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	err := s.studentService.UpdateStudent(&studentRequestBody)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(204, nil)
}
