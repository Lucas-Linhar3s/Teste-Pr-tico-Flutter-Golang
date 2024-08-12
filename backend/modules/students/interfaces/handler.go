package interfaces

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"go.uber.org/dig"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/modules/students/application"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/responses"
)

type handlerDependencies struct {
	dig.In
	App *application.StudentApp `name:"STUDENTS_APP"`
}

type StudentHandler struct {
	app *application.StudentApp
}

func NewHander(dep handlerDependencies) *StudentHandler {
	return &StudentHandler{
		app: dep.App,
	}
}

// @Summary Create student
// @Description Create new student
// @Tags students
// @Produce json
// @Param body body application.StudentReq true "Student information"
// @Param Timestamp header string true "Timestamp of the request"
// @Param Sign header string true "Signature for the request"
// @Param Nonce header string true "Unique UUID for the request"
// @Param App-Version header string true "API version"
// @Success 201 {string} string  "Student created successfully"
// @Failure 400 {object} responses.Response "Invalid input"
// @Failure 500 {object} responses.Response "Internal server error"
// @Router /students/create [post]
func (s *StudentHandler) CreateStudent(c *gin.Context) {
	var course application.StudentReq

	if err := c.ShouldBindJSON(&course); err != nil {
		responses.HandleError(c, http.StatusBadRequest, responses.ErrBadRequest, nil)
		return
	}

	err := s.app.CreateStudent(c, course)
	if err != nil {
		responses.HandleError(c, http.StatusInternalServerError, responses.ErrInternalServerError, nil)
		return
	}

	responses.HandleSuccess(c, http.StatusNoContent, nil)
}

// @Summary List all students
// @Description List all students
// @Tags students
// @Produce json
// @Param limit query int true "Limit the number of results (default is 10)"
// @Param offset query int true "Offset for pagination"
// @Param name query string false "Student name"
// @Param Timestamp header string true "Timestamp of the request"
// @Param Sign header string true "Signature for the request"
// @Param Nonce header string true "Unique UUID for the request"
// @Param App-Version header string true "API version"
// @Success 200 {object} responses.Response  "List of students"
// @Failure 400 {object} responses.Response "Invalid input"
// @Failure 500 {object} responses.Response "Internal server error"
// @Router /students/list [get]
func (s *StudentHandler) ListStudents(c *gin.Context) {
	var req application.Params

	if err := c.ShouldBindQuery(&req); err != nil {
		responses.HandleError(c, http.StatusBadRequest, err, nil)
		return
	}

	courses, err := s.app.ListStudents(c, req)
	if err != nil {
		responses.HandleError(c, http.StatusInternalServerError, err, nil)
		return
	}

	responses.HandleSuccess(c, http.StatusOK, courses.Data)
}

// @Summary Update student
// @Description Update student
// @Tags students
// @Produce json
// @Param body body application.StudentReq true "Student information"
// @Param Timestamp header string true "Timestamp of the request"
// @Param Sign header string true "Signature for the request"
// @Param Nonce header string true "Unique UUID for the request"
// @Param App-Version header string true "API version"
// @Success 201 {string} string  "Student updated successfully"
// @Failure 400 {object} responses.Response "Invalid input"
// @Failure 500 {object} responses.Response "Internal server error"
// @Router /students/update [patch]
func (s *StudentHandler) UpdateStudent(c *gin.Context) {
	var req application.StudentReq

	if err := c.ShouldBindJSON(&req); err != nil {
		responses.HandleError(c, http.StatusBadRequest, responses.ErrBadRequest, nil)
		return
	}

	err := s.app.UpdateStudent(c, req)
	if err != nil {
		responses.HandleError(c, http.StatusInternalServerError, responses.ErrInternalServerError, nil)
		return
	}

	responses.HandleSuccess(c, http.StatusNoContent, nil)
}
