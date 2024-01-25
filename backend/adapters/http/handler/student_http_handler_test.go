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

func TestStudenIntegration(t *testing.T) {
	config.LoadConfig("../../../")
	config := config.GetConfig()

	conn, err := postgres.Open(config)
	if err != nil {
		log.Fatal(err)
	}
	defer conn.Close()

	reqCreate := map[string]interface{}{
		"name": "Teste",
	}

	reqUpdate := map[string]interface{}{
		"code": 1,
		"name": "TesteUpdate",
	}

	bodyCreateStudent, _ := json.Marshal(reqCreate)
	bodyUpdateStudent, _ := json.Marshal(reqUpdate)

	di := di.ConfigStudentDI(conn)

	r := gin.Default()
	n := r.Group("studentTest")
	{
		n.POST("/create", di.CreateStudent)
		n.GET("/list", di.ListStudents)
		n.PATCH("/update", di.UpdateStudent)
	}

	t.Run("Create Student", func(t *testing.T) {
		w := httptest.NewRecorder()
		req, _ := http.NewRequest("POST", "/studentTest/create", bytes.NewBuffer(bodyCreateStudent))

		r.ServeHTTP(w, req)
		assert.Equal(t, http.StatusNoContent, w.Code)
	})

	t.Run("List Students", func(t *testing.T) {
		w := httptest.NewRecorder()
		req, _ := http.NewRequest("GET", "/studentTest/list", nil)

		r.ServeHTTP(w, req)
		assert.Equal(t, http.StatusOK, w.Code)
	})

	t.Run("Update Student", func(t *testing.T) {
		w := httptest.NewRecorder()
		req, _ := http.NewRequest("PATCH", "/studentTest/update", bytes.NewBuffer(bodyUpdateStudent))

		r.ServeHTTP(w, req)
		assert.Equal(t, http.StatusNoContent, w.Code)
	})
}
