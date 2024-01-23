package dtos

import (
	"encoding/json"
	"io"
)

// CreateStudentRequest struct to create a new student
type CreateStudentRequestBody struct {
	Name *string `json:"name"`
}

// UpdateStudentRequestBody struct to update a student
type UpdateStudentRequestBody struct {
	Code *int    `json:"code"`
	Name *string `json:"name"`
}

// JSONStudentRequestBody decodes a JSON request body into a StudentRequestBody struct
func FromJSONCreateStudentRequestBody(request io.Reader) (studentRequest *CreateStudentRequestBody, err error) {
	if err = json.NewDecoder(request).Decode(&studentRequest); err != nil {
		return
	}

	return
}

// JSONStudentRequestBody decodes a JSON request body into a StudentRequestBody struct
func FromJSONUpdateStudentRequestBody(request io.Reader) (studentRequest *UpdateStudentRequestBody, err error) {
	if err = json.NewDecoder(request).Decode(&studentRequest); err != nil {
		return
	}
	return
}
