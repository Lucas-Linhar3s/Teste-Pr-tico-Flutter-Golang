package main

import (
	"log"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/adapters/http/server"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/adapters/postgres"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/config"
)

// @title TESTE PRATICO FLUTTER/GOLANG API
// @version 1.0
// @description Esse e um teste pratico para a vaga Flutter/Golang da empresa VR SOFTWARE.

// @contact.name Vr Software

// @host localhost:3000
// @BasePath /
func main() {
	// Load the configuration from file
	config.LoadConfig("")

	// Get the loaded configuration
	conf := config.GetConfig()

	// Open the database connection using the configuration
	conn, err := postgres.Open(conf)
	if err != nil {
		log.Fatal(err)
	}

	if err := server.InitServer(conf.Server.Port, conn); err != nil {
		log.Fatal(err)
	}

}
