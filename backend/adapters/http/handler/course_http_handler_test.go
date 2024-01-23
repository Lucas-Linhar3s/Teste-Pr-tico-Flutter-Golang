package handler_test

import (
	"bytes"
	"encoding/json"
	"log"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/adapters/postgres"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/config"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/di"
	"github.com/gin-gonic/gin"
	"github.com/stretchr/testify/assert"
)

func TestCourseIntegration(t *testing.T) {
	config.LoadConfig("../../../")
	config := config.GetConfig()

	conn, err := postgres.Open(config)
	if err != nil {
		log.Fatal(err)
	}
	defer conn.Close()

	di := di.ConfigCourseDI(conn)

	reqCreateCourse := map[string]interface{}{
		"description": "Teste",
		"ementa":      "Teste",
	}

	reqUpdateCourse := map[string]interface{}{
		"code":        1,
		"description": "Teste update",
		"ementa":      "Teste update",
	}

	reqAddStudentCourse := map[string]interface{}{
		"code_course":  1,
		"code_student": 1,
	}

	bodyCreateCourse, _ := json.Marshal(reqCreateCourse)
	bodyAddStudentCourse, _ := json.Marshal(reqAddStudentCourse)
	bodyUpdateCourse, _ := json.Marshal(reqUpdateCourse)

	r := gin.Default()
	n := r.Group("courseTest")
	{
		n.POST("/create", di.CreateCourse)
		n.POST("/add-students", di.AddStudents)
		n.GET("/list", di.ListCourses)
		n.GET("/list-students", di.ListCoursesStudent)
		n.PATCH("/update", di.UpdateCourse)
	}

	t.Run("Create Course", func(t *testing.T) {
		w := httptest.NewRecorder()
		req, _ := http.NewRequest("POST", "/courseTest/create", bytes.NewBuffer(bodyCreateCourse))

		r.ServeHTTP(w, req)
		assert.Equal(t, http.StatusNoContent, w.Code)
	})

	t.Run("Add Students to Course", func(t *testing.T) {
		w := httptest.NewRecorder()
		req, _ := http.NewRequest("POST", "/add-students", bytes.NewBuffer(bodyAddStudentCourse))

		r.ServeHTTP(w, req)
		assert.Equal(t, http.StatusNoContent, w.Code)
	})

	t.Run("List Course", func(t *testing.T) {
		w := httptest.NewRecorder()
		req, _ := http.NewRequest("GET", "/courseTest/list", nil)

		r.ServeHTTP(w, req)
		assert.Equal(t, http.StatusOK, w.Code)
	})

	t.Run("List Students in Course", func(t *testing.T) {
		w := httptest.NewRecorder()
		req, _ := http.NewRequest("GET", "/courseTest/list-students", nil)

		r.ServeHTTP(w, req)
		assert.Equal(t, http.StatusOK, w.Code)
	})

	t.Run("Update Course", func(t *testing.T) {
		w := httptest.NewRecorder()
		req, _ := http.NewRequest("PATCH", "/courseTest/update", bytes.NewBuffer(bodyUpdateCourse))

		r.ServeHTTP(w, req)
		assert.Equal(t, http.StatusNoContent, w.Code)
	})
}
