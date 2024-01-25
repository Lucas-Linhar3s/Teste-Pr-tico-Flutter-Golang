package postgres

import (
	"database/sql"
	"time"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/config"
	sq "github.com/Masterminds/squirrel"
	"github.com/jackc/pgx"
	"github.com/jackc/pgx/stdlib"
)

type Postgres struct {
	db                 *sql.DB
	transactionTimeout int
	Builder            sq.StatementBuilderType
}

func Open(c *config.Config) (*Postgres, error) {
	driverConfig := stdlib.DriverConfig{
		ConnConfig: pgx.ConnConfig{
			RuntimeParams: map[string]string{
				//Verificar
				"application_name": "teste_pratico_flutter_golang",
				"DateStyle":        "ISO",
				"IntervalStyle":    "iso_8601",
				// TODO:
				"search_path": "public",
			},
		},
	}
	stdlib.RegisterDriverConfig(&driverConfig)

	db, err := sql.Open("pgx", driverConfig.ConnectionString("postgres://"+c.Databases.Username+":"+c.Databases.Password+"@"+c.Databases.Host+":"+c.Databases.Port+"/"+c.Databases.Name))
	if err != nil {
		return nil, err
	}

	db.SetMaxIdleConns(c.Databases.MaxIdle)
	db.SetMaxOpenConns(c.Databases.MaxConn)
	db.SetConnMaxLifetime(time.Second * 60)

	return &Postgres{
		db:                 db,
		transactionTimeout: c.Databases.TransactionTimeout,
		Builder:            sq.StatementBuilder.PlaceholderFormat(sq.Dollar).RunWith(db),
	}, nil
}

func (p *Postgres) Close() {
	if p.db != nil {
		p.db.Close()
	}
}
