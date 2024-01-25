package dtos

import (
	"encoding/json"
	"io"
)

// CreateCourseRequestBody struct to create a new course
type CreateCourseRequestBody struct {
	Description *string `json:"description" binding:"required"`
	Ementa      *string `json:"ementa" binding:"required"`
}

// UpdateCourseRequestBody struct to create a new course
type UpdateCourseRequestBody struct {
	Code        *int    `json:"code"`
	Description *string `json:"description" binding:"required"`
	Ementa      *string `json:"ementa" binding:"required"`
}

// CreateCourseStudent struct to create a new course
type CreateCourseStudent struct {
	CodeStudent *int `json:"code_student" binding:"required"`
	CodeCourse  *int `json:"code_course" binding:"required"`
}

// UpdateCourseStudent struct to update a course
type UpdateCourseStudent struct {
	Code        *int `json:"code"`
	CodeStudent *int `json:"code_student" binding:"required"`
	CodeCourse  *int `json:"code_course" binding:"required"`
}

// JSONCourseRequestBody decodes a JSON request body into a CourseRequestBody struct
func FromJSONCreateCourseRequestBody(request io.Reader) (courseRequest *CreateCourseRequestBody, err error) {
	if err = json.NewDecoder(request).Decode(&courseRequest); err != nil {
		return
	}

	return
}

// FromJSONUpdateCourseRequestBody decodes a JSON request body into a CourseRequestBody struct
func FromJSONUpdateCourseRequestBody(request io.Reader) (courseRequest *UpdateCourseRequestBody, err error) {
	if err = json.NewDecoder(request).Decode(&courseRequest); err != nil {
		return
	}

	return
}

// FromJSONCreateCourseStudent decodes a JSON request body into a CreateCourseStudent struct
func FromJSONCreateCourseStudent(request io.Reader) (courseRequest *CreateCourseStudent, err error) {
	if err = json.NewDecoder(request).Decode(&courseRequest); err != nil {
		return
	}

	return
}

// FromJSONUpdateCourseStudent decodes a JSON request body into a UpdateCourseStudent struct
func FromJSONUpdateCourseStudent(request io.Reader) (courseRequest *UpdateCourseStudent, err error) {
	if err = json.NewDecoder(request).Decode(&courseRequest); err != nil {
		return
	}

	return
}
