package utils

import "time"

// GetBoolPointer returns a pointer to the given bool
func GetBoolPointer(i bool) *bool {
	return &i
}

// GetTimePointer returns a pointer to the given time.Time
func GetTimePointer(t time.Time) *time.Time {
	return &t
}

// GetIntPointer returns a pointer to the given int
func GetIntPointer(i int) *int {
	return &i
}

// GetInt64Pointer returns a pointer to the given int64
func GetInt64Pointer(i int64) *int64 {
	return &i
}

// GetUInt64Pointer returns a pointer to the given int64
func GetUInt64Pointer(i uint64) *uint64 {
	return &i
}

// GetInt32Pointer returns a pointer to the given int32
func GetInt32Pointer(i int32) *int32 {
	return &i
}

// GetStringPointer returns a pointer to the given string
func GetStringPointer(i string) *string {
	return &i
}

// GetMapStrIntPointer returns a pointer to the given map
func GetMapStrIntPointer(m map[string]interface{}) *map[string]interface{} {
	return &m
}

// GetFloat64Pointer returns a pointer to the given float64
func GetFloat64Pointer(f float64) *float64 {
	return &f
}
