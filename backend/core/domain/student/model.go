package student

type Student struct {
	Code *int    `json:"code"`
	Name *string `json:"name"`
}

// Pagination is used for pagination
type Pagination struct {
	Student []*Student `json:"students"`
	Total   *int       `json:"total"`
}
