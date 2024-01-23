package handler

import (
	"net/http"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/adapters/http/service"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/domain/course"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/core/dtos"
	"github.com/gin-gonic/gin"
)

type courseServiceImpl struct {
	courseService course.ICourseUsecase
}

// NewCourseRepository returns contract implementation of ICourseService
func NewCourseService(courseService course.ICourseUsecase) service.ICourseService {
	return &courseServiceImpl{
		courseService: courseService,
	}
}

// @Summary Create a new course
// @Description Create a new course with the provided data
// @Tags Course
// @ID create-course
// @Accept json
// @Produce json
// @Param input body dtos.CreateCourseRequestBody true "Course data to create"
// @Success 204 {string} string "No Content"
// @Router /course/create [post]
func (s *courseServiceImpl) CreateCourse(c *gin.Context) {
	var course dtos.CreateCourseRequestBody

	if err := c.ShouldBindJSON(&course); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	err := s.courseService.CreateCourse(&course)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(204, nil)
}

// @Summary Add students to a course
// @Tags Course
// @Description Add students to a course.
// @ID add-students
// @Accept json
// @Produce json
// @Param student body dtos.CreateCourseStudent true "Student information"
// @Success 204 "No content"
// @Router /course/add-students [post]
func (s *courseServiceImpl) AddStudents(c *gin.Context) {
	var courseStudentRequestBody dtos.CreateCourseStudent

	if err := c.ShouldBindJSON(&courseStudentRequestBody); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	err := s.courseService.AddStudents(&courseStudentRequestBody)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(204, nil)
}

// @Summary List courses
// @Description Get a list of courses with pagination
// @ID list-courses
// @Tags Course
// @Accept json
// @Produce json
// @Param limit query int true "Limit the number of results (default is 10)"
// @Param offset query int true "Offset for pagination"
// @Param search query string false "Search term"
// @Success 200 {object} course.Pagination
// @Router /course/list [get]
func (s *courseServiceImpl) ListCourses(c *gin.Context) {
	params, err := dtos.FromValueRequestPagination(c.Request)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	pagination, err := s.courseService.ListCourses(params)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(200, pagination)
}

// @Summary List students in a course
// @Description Get a list of students in a course
// @ID list-students-in-course
// @Tags Course
// @Accept json
// @Produce json
// @Param search query string true "Codigo do curso"
// @Success 200 {object} course.ListStudentCourse
// @Router /course/list-students [get]
func (s *courseServiceImpl) ListCoursesStudent(c *gin.Context) {
	params, err := dtos.FromValueRequestPagination(c.Request)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	pagination, err := s.courseService.ListCoursesStudents(params)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(200, pagination)
}

// @Summary Update a course
// @Description Update an existing course with the provided data
// @Tags Course
// @ID update-course
// @Accept json
// @Produce json
// @Param input body dtos.UpdateCourseRequestBody true "Course data to update"
// @Success 204 {string} string "No Content"
// @Router /course/update [patch]
func (s *courseServiceImpl) UpdateCourse(c *gin.Context) {
	requestBody := dtos.UpdateCourseRequestBody{}

	if err := c.ShouldBindJSON(&requestBody); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	err := s.courseService.UpdateCourse(&requestBody)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(204, nil)
}
