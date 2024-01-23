package course

// Course is entity of table curso database column
type Course struct {
	Code        *int    `json:"code"`
	Description *string `json:"description" bind:"required"`
	Ementa      *string `json:"ementa" bind:"required"`
}

// Student is entity of table aluno database column
type Student struct {
	Code *int    `json:"code"`
	Name *string `json:"name"`
}

// CourseStudent is entity of table curso_aluno database column
type CourseStudent struct {
	Code        *int `json:"code"`
	CodeStudent *int `json:"code_student" binding:"required"`
	CodeCourse  *int `json:"code_course" binding:"required"`
}

// Pagination is used for pagination
type Pagination struct {
	Courses []*Course `json:"courses"`
	Total   *int      `json:"total"`
}

// ListStudentCourse is used for pagination
type ListStudentCourse struct {
	Student []*Student `json:"student"`
	Total   *int       `json:"total"`
}
