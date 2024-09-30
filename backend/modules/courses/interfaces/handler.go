package interfaces

import (
	"net/http"

	"github.com/gin-gonic/gin"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/courses/application"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/responses"
)

type CourseHandler struct {
	app *application.CourseApp
}

func NewHander(app *application.CourseApp) *CourseHandler {
	return &CourseHandler{
		app: app,
	}
}

// @Summary Create course
// @Description Create new course
// @Tags courses
// @Produce json
// @Param body body application.CourseReq true "Course information"
// @Param Timestamp header string true "Timestamp of the request"
// @Param Sign header string true "Signature for the request"
// @Param Nonce header string true "Unique UUID for the request"
// @Param App-Version header string true "API version"
// @Success 201 {string} string  "Course created successfully"
// @Failure 400 {object} responses.Response "Invalid input"
// @Failure 500 {object} responses.Response "Internal server error"
// @Router /courses/create [post]
func (s *CourseHandler) CreateCourse(c *gin.Context) {
	var course application.CourseReq

	if err := c.ShouldBindJSON(&course); err != nil {
		responses.HandleError(c, http.StatusBadRequest, responses.ErrBadRequest, nil)
		return
	}

	err := s.app.CreateCourse(c, course)
	if err != nil {
		responses.HandleError(c, http.StatusInternalServerError, responses.ErrInternalServerError, nil)
		return
	}

	responses.HandleSuccess(c, http.StatusNoContent, nil)
}

// @Summary List all course
// @Description List all course
// @Tags courses
// @Produce json
// @Param limit query int true "Limit the number of results (default is 10)"
// @Param offset query int true "Offset for pagination"
// @Param description query string false "Course description"
// @Param Timestamp header string true "Timestamp of the request"
// @Param Sign header string true "Signature for the request"
// @Param Nonce header string true "Unique UUID for the request"
// @Param App-Version header string true "API version"
// @Success 200 {object} responses.Response  "List of courses"
// @Failure 400 {object} responses.Response "Invalid input"
// @Failure 500 {object} responses.Response "Internal server error"
// @Router /courses/list [get]
func (s *CourseHandler) ListCourses(c *gin.Context) {
	var req application.Params

	if err := c.ShouldBindQuery(&req); err != nil {
		responses.HandleError(c, http.StatusBadRequest, err, nil)
		return
	}

	courses, err := s.app.ListCourses(c, req)
	if err != nil {
		responses.HandleError(c, http.StatusInternalServerError, err, nil)
		return
	}

	responses.HandleSuccess(c, http.StatusOK, courses.Data)
}

// @Summary Add students to course
// @Description Add students to course
// @Tags courses
// @Produce json
// @Param body body application.CourseStudentReq true "Students and Course information"
// @Param Timestamp header string true "Timestamp of the request"
// @Param Sign header string true "Signature for the request"
// @Param Nonce header string true "Unique UUID for the request"
// @Param App-Version header string true "API version"
// @Success 201 {string} string  "Student add successfully"
// @Failure 400 {object} responses.Response "Invalid input"
// @Failure 500 {object} responses.Response "Internal server error"
// @Router /courses/add-students [post]
func (s *CourseHandler) AddStudents(c *gin.Context) {
	var req application.CourseStudentReq

	if err := c.ShouldBindJSON(&req); err != nil {
		responses.HandleError(c, http.StatusBadRequest, responses.ErrBadRequest, nil)
		return
	}

	err := s.app.AddStudents(c, req)
	if err != nil {
		responses.HandleError(c, http.StatusInternalServerError, responses.ErrInternalServerError, nil)
		return
	}

	responses.HandleSuccess(c, http.StatusNoContent, nil)
}

// @Summary Update course
// @Description Update course
// @Tags courses
// @Produce json
// @Param body body application.CourseReq true "Course information"
// @Param Timestamp header string true "Timestamp of the request"
// @Param Sign header string true "Signature for the request"
// @Param Nonce header string true "Unique UUID for the request"
// @Param App-Version header string true "API version"
// @Success 201 {string} string  "Course updated successfully"
// @Failure 400 {object} responses.Response "Invalid input"
// @Failure 500 {object} responses.Response "Internal server error"
// @Router /courses/update [patch]
func (s *CourseHandler) UpdateCourse(c *gin.Context) {
	var req application.CourseReq

	if err := c.ShouldBindJSON(&req); err != nil {
		responses.HandleError(c, http.StatusBadRequest, responses.ErrBadRequest, nil)
		return
	}

	err := s.app.UpdateCourse(c, req)
	if err != nil {
		responses.HandleError(c, http.StatusInternalServerError, responses.ErrInternalServerError, nil)
		return
	}

	responses.HandleSuccess(c, http.StatusNoContent, nil)
}

// @Summary List all course students
// @Description List all course students
// @Tags courses
// @Produce json
// @Param search query int true "Codigo do curso"
// @Param Timestamp header string true "Timestamp of the request"
// @Param Sign header string true "Signature for the request"
// @Param Nonce header string true "Unique UUID for the request"
// @Param App-Version header string true "API version"
// @Success 200 {object} responses.Response  "List of courses"
// @Failure 400 {object} responses.Response "Invalid input"
// @Failure 500 {object} responses.Response "Internal server error"
// @Router /courses/list-students-course [get]
func (s *CourseHandler) ListStudentsCourse(c *gin.Context) {
	var req application.Params

	if err := c.ShouldBindQuery(&req); err != nil {
		responses.HandleError(c, http.StatusBadRequest, err, nil)
		return
	}

	students, err := s.app.ListStudentsCourse(c, req)
	if err != nil {
		responses.HandleError(c, http.StatusInternalServerError, err, nil)
		return
	}

	responses.HandleSuccess(c, http.StatusOK, students)
}
