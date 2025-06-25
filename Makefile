APP_NAME := restGO
MAIN := ./cmd/main.go
BIN := bin/$(APP_NAME).exe

.PHONY: all build run stop deps

all: run

build:
	@if not exist bin mkdir bin
	go build -o $(BIN) $(MAIN)

run: build
	@$(MAKE) --no-print-directory stop 2>nul
	@"$(BIN)" &
    # @cmd /c "start "" /B $(BIN)"
    # @"$(BIN)" & в текущей консоли
    
stop:
	@taskkill /f /im $(APP_NAME).exe 2>nul || echo "$(APP_NAME) is not running."

deps:
    # Инициализируем go.mod (если не существует)
	go mod init $(APP_NAME) 2>nul || echo go.mod already initialized
    # Устанавливаем Gin (веб-фреймворк)
	go get github.com/gin-gonic/gin
    # Устанавливаем Viper (для конфигурации) с флагом -u для обновления до последней версии
	go get -u github.com/spf13/viper
    # миграции
	go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest
    # Убираем неиспользуемые зависимости
    #(флаг -e предотвращает удаление неиспользуемых зависимостей) go mod tidy -e
	go mod tidy


# DB commands
# docker ps
# docker exec -it 155b8128516d /bin/bash
# psql -U postgres
# \d
# q (quit) для выхода из режима просмотра длинного вывода.
# exit -выити

# migrate create -ext sql -dir ./schema -seq init
# migrate -path ./schema -database 'postgres://postgres:qwerty@localhost:5432/postgres?sslmode=disable' up
# migrate -path ./schema -database 'postgres://postgres:qwerty@localhost:5432/postgres?sslmode=disable' down
# docker run --name=todo-db -e POSTGRES_PASSWORD='qwerty' -p 5432:5432 -d --rm postgres
# docker stop 155b8128516d

# postgres=# select * from schema_migrations;
# update schema_migrations set version='000001', dirty=false;
#
#
#
#
#

