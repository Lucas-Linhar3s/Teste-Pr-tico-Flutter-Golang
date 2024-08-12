package interfaces_test

import (
	"testing"
)

func TestCourseIntegration(t *testing.T) {
	// var err error
	// var dep *dependencies
	// container := dig.BuildContainer()

	// if err = di.RegisterDI(container); err != nil {
	// 	panic(err)
	// }

	// if dep, err = dig.InvokeService(container, dep); err != nil {
	// 	panic(err)
	// }

	// if err := dig.ResgisterModules(container, dep.HTTPServer.Router, dep.Log); err != nil {
	// 	dep.Log.Logger.Fatal("error in resgister modules", zap.Error(err))
	// }

	// if err = dep.HTTPServer.Run(dep.Log, dep.JWT, dep.Config); err != nil {
	// 	dep.Log.Logger.Fatal("error in init server", zap.Error(err))
	// }

	// reqCreateCourse := map[string]interface{}{
	// 	"description": "Teste",
	// 	"ementa":      "Teste",
	// }

	// reqUpdateCourse := map[string]interface{}{
	// 	"code":        1,
	// 	"description": "Teste update",
	// 	"ementa":      "Teste update",
	// }

	// reqAddStudentCourse := map[string]interface{}{
	// 	"code_course":  1,
	// 	"code_student": 1,
	// }

	// bodyCreateCourse, _ := json.Marshal(reqCreateCourse)
	// bodyAddStudentCourse, _ := json.Marshal(reqAddStudentCourse)
	// bodyUpdateCourse, _ := json.Marshal(reqUpdateCourse)

	// r := gin.Default()
	// n := r.Group("courseTest")
	// {
	// 	n.POST("/create", di.CreateCourse)
	// 	n.POST("/add-students", di.AddStudents)
	// 	n.GET("/list", di.ListCourses)
	// 	n.GET("/list-students", di.ListCoursesStudent)
	// 	n.PATCH("/update", di.UpdateCourse)
	// }

	// t.Run("Create Course", func(t *testing.T) {
	// 	w := httptest.NewRecorder()
	// 	req, _ := http.NewRequest("POST", "/courseTest/create", bytes.NewBuffer(bodyCreateCourse))

	// 	r.ServeHTTP(w, req)
	// 	assert.Equal(t, http.StatusNoContent, w.Code)
	// })

	// t.Run("Add Students to Course", func(t *testing.T) {
	// 	w := httptest.NewRecorder()
	// 	req, _ := http.NewRequest("POST", "/add-students", bytes.NewBuffer(bodyAddStudentCourse))

	// 	r.ServeHTTP(w, req)
	// 	assert.Equal(t, http.StatusNoContent, w.Code)
	// })

	// t.Run("List Course", func(t *testing.T) {
	// 	w := httptest.NewRecorder()
	// 	req, _ := http.NewRequest("GET", "/courseTest/list", nil)

	// 	r.ServeHTTP(w, req)
	// 	assert.Equal(t, http.StatusOK, w.Code)
	// })

	// t.Run("List Students in Course", func(t *testing.T) {
	// 	w := httptest.NewRecorder()
	// 	req, _ := http.NewRequest("GET", "/courseTest/list-students", nil)

	// 	r.ServeHTTP(w, req)
	// 	assert.Equal(t, http.StatusOK, w.Code)
	// })

	// t.Run("Update Course", func(t *testing.T) {
	// 	w := httptest.NewRecorder()
	// 	req, _ := http.NewRequest("PATCH", "/courseTest/update", bytes.NewBuffer(bodyUpdateCourse))

	// 	r.ServeHTTP(w, req)
	// 	assert.Equal(t, http.StatusNoContent, w.Code)
	// })
}
