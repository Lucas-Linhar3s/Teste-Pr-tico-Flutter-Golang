package dtos

import (
	"net/http"
	"strconv"
	"strings"
	"unicode"

	"golang.org/x/text/transform"
	"golang.org/x/text/unicode/norm"
)

// RequestPagination struct to request pagination
type RequestPagination struct {
	Limit  *int    `json:"limit"`
	Offset *int    `json:"offset"`
	Search *string `json:"search"`
}

// FromValueRequestPagination decodes a JSON request body into a RequestPagination struct
func FromValueRequestPagination(value *http.Request) (request *RequestPagination, err error) {
	limit, _ := strconv.Atoi(value.FormValue("limit"))
	offset, _ := strconv.Atoi(value.FormValue("offset"))
	search := strings.TrimSpace(strings.ReplaceAll(value.FormValue("search"), " ", "%"))

	// Remove acentuações
	nameWithoutAccents := removeAccents(search)

	request = &RequestPagination{
		Limit:  &limit,
		Offset: &offset,
		Search: &nameWithoutAccents,
	}

	return
}

func removeAccents(input string) string {
	// Cria um transformador para remover acentuações
	t := transform.Chain(norm.NFD, transform.RemoveFunc(isMn), norm.NFC)

	// Aplica a transformação à string
	result, _, _ := transform.String(t, input)
	return result
}

// Função auxiliar para verificar se um rune é um marcador de não-combinação
func isMn(r rune) bool {
	return unicode.Is(unicode.Mn, r) // Marcador de não-combinação
}
