package database

import (
	"database/sql"
	"errors"
	"os"
	"path/filepath"
	"time"

	sq "github.com/Masterminds/squirrel"
	"github.com/jackc/pgx"
	"github.com/jackc/pgx/stdlib"
	_ "github.com/mattn/go-sqlite3"
	"go.uber.org/zap"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/config"
	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/log"
)

type Database struct {
	tx                 *sql.Tx
	db                 *sql.DB
	transactionTimeout int
	Builder            sq.StatementBuilderType
}

func NewDatabase(config *config.Config, logger *log.Logger) *Database {
	db, err := open(config)
	if err != nil {
		logger.Fatal("failed to open database", zap.Error(err))
	}

	return db
}

func open(c *config.Config) (database *Database, err error) {
	var db *sql.DB

	switch c.Data.Db.User.Driver {
	case "sqlite":
		currentDir, err := os.Getwd()
		if err != nil {
			return nil, err
		}
		path := filepath.Join(currentDir, "", c.Data.Db.User.Dsn)

		// Verifica se o arquivo do banco de dados existe
		if _, err := os.Stat(path); os.IsNotExist(err) {
			return nil, errors.New("banco de dados sqlite não encontrado")
		}

		db, err = sql.Open("sqlite3", path)
		if err != nil {
			return nil, err
		}
	case "postgres", "mysql":
		driverConfig := stdlib.DriverConfig{
			ConnConfig: pgx.ConnConfig{
				RuntimeParams: map[string]string{
					//Verificar
					"application_name": "github.com/Lucas-Linhar3s/Base-Structure-Golang",
					"DateStyle":        "ISO",
					"IntervalStyle":    "iso_8601",
					// TODO:
					"search_path": "public",
				},
			},
		}
		stdlib.RegisterDriverConfig(&driverConfig)

		db, err = sql.Open("pgx", driverConfig.ConnectionString(
			c.Data.Db.User.Nick+
				"://"+
				c.Data.Db.User.Username+
				":"+
				c.Data.Db.User.Password+
				"@"+
				c.Data.Db.User.Hostname+
				":"+
				c.Data.Db.User.Port+
				"/"+
				c.Data.Db.User.Name))
		if err != nil {
			return nil, err
		}
	default:
		panic("unknown db driver")
	}

	if err := db.Ping(); err != nil {
		return nil, err
	}

	db.SetMaxIdleConns(c.Data.Db.User.MaxIdle)
	db.SetMaxOpenConns(c.Data.Db.User.MaxConn)
	db.SetConnMaxLifetime(time.Second * 60)

	return &Database{
		db:                 db,
		transactionTimeout: c.Data.Db.User.TransactionTimeout,
		Builder:            sq.StatementBuilder.PlaceholderFormat(sq.Dollar).RunWith(db),
	}, nil
}

func (d *Database) NewTransaction() (*Database, error) {
	tx, err := d.db.Begin()
	if err != nil {
		return nil, err
	}
	return &Database{
		tx:      tx,
		Builder: sq.StatementBuilder.PlaceholderFormat(sq.Dollar).RunWith(tx),
	}, nil
}

func createTables(db *sql.DB) error {
	_, err := db.Exec(string(createTablesInitial))
	if err != nil {
		return err
	}

	res, err := db.Query("SELECT COUNT(*) FROM manager.curso")
	defer res.Close()
	for res.Next() {
		var count int
		if err = res.Scan(&count); err != nil {
			return err
		}
		if count == 0 {
			_, err = db.Exec(string(insertTablesInitial))
			if err != nil {
				return err
			}
		}
	}

	return err
}

func (p *Database) Close() {
	if p.tx != nil {
		p.tx.Rollback()
	}
}

func (p *Database) Commit() error {
	return p.tx.Commit()
}
