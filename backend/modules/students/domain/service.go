package domain

import (
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/database"
)

// Service struct
type Service struct {
	iStudent IStudents
}

// GetService is a factory method
func GetService(repo IStudents) *Service {
	return &Service{iStudent: repo}
}

// GetRepository is a factory method
func GetRepository(db *database.Database) IStudents {
	return newRepository(db)
}

// CreateStudent creates a new student
func (s *Service) CreateStudent(student *StudentModel) (err error) {
	data, err := s.iStudent.ConvertDomainToModelInfra(student)
	if err != nil {
		return
	}

	return s.iStudent.CreateStudent(data)
}

// UpdateStudent updates a student
func (s *Service) UpdateStudent(student *StudentModel) (err error) {
	data, err := s.iStudent.ConvertDomainToModelInfra(student)
	if err != nil {
		return
	}

	return s.iStudent.UpdateStudent(data)
}

// ListStudents lists all students
func (s *Service) ListStudents(params map[string]interface{}) (pagination *[]StudentModel, err error) {
	result, err := s.iStudent.ListStudents(params)
	if err != nil {
		return
	}

	pagination = &[]StudentModel{}
	for _, course := range *result {
		var studentDomain *StudentModel
		studentDomain, err = s.iStudent.ConvertModelInfraToDomain(&course)
		if err != nil {
			return
		}

		*pagination = append(*pagination, *studentDomain)
	}

	return
}
