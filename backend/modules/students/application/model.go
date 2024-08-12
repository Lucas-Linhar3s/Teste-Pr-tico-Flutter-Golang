package application

// StudentReq struct to create a new course
type StudentReq struct {
	Code *int    `json:"code"`
	Name *string `json:"name" validate:"required"`
}

// Params search params
type Params struct {
	Name   string `form:"name"`
	Limit  *int   `form:"limit" validate:"required"`
	Offset *int   `form:"offset" validate:"required"`
}

// Res response of student
type Res struct {
	Data  []*StudentRes
	Total *int `json:"total,omitempty" copier:"Total"`
}

// StudentRes response of student
type StudentRes struct {
	Code *int64  `json:"code"`
	Name *string `json:"name"`
}
