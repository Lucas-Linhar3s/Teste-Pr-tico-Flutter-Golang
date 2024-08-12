package application

// CourseReq struct to create a new course
type CourseReq struct {
	Code        *int    `json:"code"`
	Description *string `json:"description" validate:"required"`
	Ementa      *string `json:"ementa" validate:"required"`
}

// CourseStudentReq struct to create a new course
type CourseStudentReq struct {
	CourseCode  *int `json:"code_course" validate:"required"`
	StudentCode *int `json:"code_student" validate:"required"`
}

// Params search params
type Params struct {
	Code        *int   `form:"code"`
	Description string `form:"description"`
	Limit       *int   `form:"limit" validate:"required"`
	Offset      *int   `form:"offset" validate:"required"`
}

// Res response of course
type Res struct {
	Data  []*CourseRes
	Total *int `json:"total,omitempty" copier:"Total"`
}

// CourseRes response of course
type CourseRes struct {
	Code        *int64  `json:"code"`
	Ementa      *string `json:"ementa,omitempty"`
	Description *string `json:"description,omitempty"`
	StudentName *string `json:"student_name,omitempty"`
}
