package utils

import "github.com/jinzhu/copier"

// ConvertRequestToModel convert request to model
func ConvertRequestToModel[T any](req interface{}) (T, error) {
	var data T
	if err := copier.Copy(&data, req); err != nil {
		return data, err
	}
	return data, nil
}
