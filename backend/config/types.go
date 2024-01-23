package config

type Config struct {
	Databases      Database `json:"databases"`
	QueryTimeLimit float32  `json:"query_time_limit"`
	Server         Server   `json:"server"`
}

type Server struct {
	Port string `json:"port"`
}

// Database contains data needed for database connections
type Database struct {
	Nick               string `json:"nick"`
	Name               string `json:"name"`
	Username           string `json:"username"`
	Password           string `json:"password"`
	Host               string `json:"hostname"`
	Port               string `json:"port"`
	MaxConn            int    `json:"max_conn"`
	MaxIdle            int    `json:"max_idle"`
	TransactionTimeout int    `json:"transaction_timeout"`
}
