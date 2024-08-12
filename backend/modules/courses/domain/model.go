package domain

// CourseModel is model of course
type CourseModel struct {
	Code        *int64  `copier:"Code"`
	Description *string `copier:"Description"`
	Ementa      *string `copier:"Ementa"`
	StudentCode *int64  `copier:"StudentCode"`
	StudentName *string `copier:"StudentName"`
	Total       *int    `copier:"Total"`
}
