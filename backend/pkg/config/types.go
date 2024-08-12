package config

// Config represents the configuration of variables for the application.
type Config struct {
	Env string
	Http *Http
	Security *Security
	Data *Data
	Log *Log
}
// Log represents the log configuration of the application.
type Log struct {
	LogLevel string
	Encoding string
	LogFileName string
	MaxBackups int
	MaxAge int
	MaxSize int
	Compress bool
}
// Data represents the data configuration of the application.
type Data struct {
	Db *Db
}
// Db represents the database configuration of the application.
type Db struct {
	User *User
}
// User represents the user configuration of the application.
type User struct {
	Driver string
	Nick string
	Name string
	Username string
	Password string
	Hostname string
	Port string
	MaxConn int
	MaxIdle int
	TransactionTimeout int
	Dsn string
}
// Http represents the http configuration of the application.
type Http struct {
	Host string
	Port string
}
// Security represents the security configuration of the application.
type Security struct {
	ApiSign *ApiSign
	Jwt *Jwt 
}
// ApiSign represents the api sign configuration of the application.
type ApiSign struct {
	AppKey string
	AppSecurity string
}
// Jwt represents the jwt configuration of the application.
type Jwt struct {
	Key string
}
