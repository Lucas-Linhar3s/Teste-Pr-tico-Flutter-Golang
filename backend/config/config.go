package config

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"path/filepath"
)

var config *Config

// Config load file a valid JSON with all settings
func LoadConfig(dir string) {
	currentDir, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}
	path := filepath.Join(currentDir, fmt.Sprintf("%s/%s", dir, "/config.json"))

	raw, err := os.ReadFile(path)
	if err != nil {
		log.Fatal(err)
	}

	if err = json.Unmarshal(raw, &config); err != nil {
		log.Fatal(err)
	}
}

// GetConfig returns a pointer to a Config struct which holds a valid config
func GetConfig() *Config {
	if config == nil {
		log.Fatal("config was not successfully loaded")
	}
	return config
}
