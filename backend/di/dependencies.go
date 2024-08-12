package di

import (
	"github.com/go-playground/validator/v10"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/database"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/config"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/server"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/jwt"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
)

type DependenciesModel struct {
	Constructor interface{}
	Token       string
}

var Dependencies = []DependenciesModel{
	{
		Constructor: config.NewViper,
		Token:       "VIPER",
	},
	{
		Constructor: config.LoadAttributes,
		Token:       "CONFIG",
	},
	{
		Constructor: jwt.NewJwt,
		Token:       "JWT",
	},
	{
		Constructor: log.NewLog,
		Token:       "LOGGER",
	},
	{
		Constructor: server.NewServer,
		Token:       "SERVER",
	},
	{
		Constructor: database.NewDatabase,
		Token:       "DATABASE",
	},
	{
		Constructor: validator.New,
		Token:       "VALIDATE",
	},
}
