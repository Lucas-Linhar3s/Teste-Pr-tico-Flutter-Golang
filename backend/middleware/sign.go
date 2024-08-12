package middleware

import (
	"net/http"
	"sort"
	"strings"

	"github.com/duke-git/lancet/v2/cryptor"
	"github.com/gin-gonic/gin"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/config"
	v1 "github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/responses"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
)

// SignMiddleware check sign
func SignMiddleware(logger *log.Logger, conf *config.Config) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		requiredHeaders := []string{"Timestamp", "Nonce", "Sign", "App-Version"}

		for _, header := range requiredHeaders {
			value, ok := ctx.Request.Header[header]
			if !ok || len(value) == 0 {
				v1.HandleError(ctx, http.StatusBadRequest, v1.ErrBadRequest, nil)
				ctx.Abort()
				return
			}
		}

		data := map[string]string{
			"AppKey":     conf.Security.ApiSign.AppKey,
			"Timestamp":  ctx.Request.Header.Get("Timestamp"),
			"Nonce":      ctx.Request.Header.Get("Nonce"),
			"AppVersion": ctx.Request.Header.Get("App-Version"),
		}

		var keys []string
		for k := range data {
			keys = append(keys, k)
		}
		sort.Slice(keys, func(i, j int) bool { return strings.ToLower(keys[i]) < strings.ToLower(keys[j]) })

		var str string
		for _, k := range keys {
			str += k + data[k]
		}
		str += conf.Security.ApiSign.AppSecurity

		if ctx.Request.Header.Get("Sign") != strings.ToUpper(cryptor.Md5String(str)) {
			v1.HandleError(ctx, http.StatusBadRequest, v1.ErrBadRequest, nil)
			ctx.Abort()
			return
		}
		ctx.Next()
	}
}
