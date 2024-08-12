package infrastructure

// StudentModel is model of student
type StudentModel struct {
	Code  *int64  `copier:"Code"`
	Name  *string `copier:"Name"`
	Total *int    `copier:"Total"`
}
