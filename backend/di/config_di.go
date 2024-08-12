package di

import (
	d "go.uber.org/dig"

	"github.com/Lucas-Linhar3s/Teste-Pratico-Flutter-Golang/backend/pkg/http/server"
)

func RegisterDI(container *d.Container) error {
	for _, v := range Dependencies {
		if err := container.Provide(v.Constructor, d.Name(v.Token)); err != nil {
			return err
		}
	}

	if err := container.Provide(func () []server.Module {
		return Modules(container);
	}); err != nil {
		return err
	}

	return nil
}
