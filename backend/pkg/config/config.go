package config

import (
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"

	"github.com/spf13/viper"
)

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
func LoadAttributes(viper *viper.Viper) *Config {
	return &Config{
		Env: viper.GetString("env"),
		Http: &Http{
			Host: viper.GetString("http.host"),
			Port: viper.GetString("http.port"),
		},
		Security: &Security{
			ApiSign: &ApiSign{
				AppKey:      viper.GetString("security.api_sign.app_key"),
				AppSecurity: viper.GetString("security.api_sign.app_security"),
			},
			Jwt: &Jwt{
				Key: viper.GetString("security.jwt.key"),
			},
		},
		Data: &Data{
			Db: &Db{
				User: &User{
					Driver:             viper.GetString("data.db.user.driver"),
					Nick:               viper.GetString("data.db.user.nick"),
					Name:               viper.GetString("data.db.user.name"),
					Username:           viper.GetString("data.db.user.username"),
					Password:           viper.GetString("data.db.user.password"),
					Hostname:           viper.GetString("data.db.user.hostname"),
					Port:               viper.GetString("data.db.user.port"),
					MaxConn:            viper.GetInt("data.db.user.max_conn"),
					MaxIdle:            viper.GetInt("data.db.user.max_idle"),
					TransactionTimeout: viper.GetInt("data.db.user.transaction_timeout"),
					Dsn:                viper.GetString("data.db.user.dsn"),
				},
			},
		},
		Log: &Log{
			LogLevel:    viper.GetString("log.log_level"),
			Encoding:    viper.GetString("log.encoding"),
			LogFileName: viper.GetString("log.log_file_name"),
			MaxBackups:  viper.GetInt("log.max_backups"),
			MaxAge:      viper.GetInt("log.max_age"),
			MaxSize:     viper.GetInt("log.max_size"),
			Compress:    viper.GetBool("log.compress"),
		},
	}
}
