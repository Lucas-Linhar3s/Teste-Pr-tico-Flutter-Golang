package config

import (
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"

	"github.com/spf13/viper"
	"go.uber.org/dig"
)

type configDependencies struct {
	dig.In
	Viper *viper.Viper `name:"VIPER"`
}

// NewConfig returns a new Viper instance configured to read the given config file.
func NewViper() *viper.Viper {
	p := flag.String("conf", "../../config/local.yml", "config path, eg: -conf ../../config/local.yml")
	flag.Parse()
	envConf := os.Getenv("APP_CONF")
	if envConf == "" {
		envConf = *p
	}
	fmt.Println("load conf file:", envConf)
	return getViper(envConf)
}

func getViper(dir string) *viper.Viper {
	currentDir, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}
	path := filepath.Join(currentDir, dir)
	conf := viper.New()
	conf.SetConfigFile(path)
	err = conf.ReadInConfig()
	if err != nil {
		panic(err)
	}
	return conf
}

// LoadAttributes loads attributes from config file and returns a new Config instance.
func LoadAttributes(dep configDependencies) *Config {
	return &Config{
		Env: dep.Viper.GetString("env"),
		Http: &Http{
			Host: dep.Viper.GetString("http.host"),
			Port: dep.Viper.GetString("http.port"),
		},
		Security: &Security{
			ApiSign: &ApiSign{
				AppKey:      dep.Viper.GetString("security.api_sign.app_key"),
				AppSecurity: dep.Viper.GetString("security.api_sign.app_security"),
			},
			Jwt: &Jwt{
				Key: dep.Viper.GetString("security.jwt.key"),
			},
		},
		Data: &Data{
			Db: &Db{
				User: &User{
					Driver:             dep.Viper.GetString("data.db.user.driver"),
					Nick:               dep.Viper.GetString("data.db.user.nick"),
					Name:               dep.Viper.GetString("data.db.user.name"),
					Username:           dep.Viper.GetString("data.db.user.username"),
					Password:           dep.Viper.GetString("data.db.user.password"),
					Hostname:           dep.Viper.GetString("data.db.user.hostname"),
					Port:               dep.Viper.GetString("data.db.user.port"),
					MaxConn:            dep.Viper.GetInt("data.db.user.max_conn"),
					MaxIdle:            dep.Viper.GetInt("data.db.user.max_idle"),
					TransactionTimeout: dep.Viper.GetInt("data.db.user.transaction_timeout"),
					Dsn:                dep.Viper.GetString("data.db.user.dsn"),
				},
			},
		},
		Log: &Log{
			LogLevel:    dep.Viper.GetString("log.log_level"),
			Encoding:    dep.Viper.GetString("log.encoding"),
			LogFileName: dep.Viper.GetString("log.log_file_name"),
			MaxBackups:  dep.Viper.GetInt("log.max_backups"),
			MaxAge:      dep.Viper.GetInt("log.max_age"),
			MaxSize:     dep.Viper.GetInt("log.max_size"),
			Compress:    dep.Viper.GetBool("log.compress"),
		},
	}
}
