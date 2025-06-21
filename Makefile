APP_NAME := restGO
MAIN := ./cmd/main.go
BIN := bin/$(APP_NAME).exe

.PHONY: all build run stop deps

all: stop run

build:
	@if not exist bin mkdir bin
	go build -o $(BIN) $(MAIN)

run: build
	@tasklist | findstr /i $(APP_NAME).exe >nul \
		&& echo "$(APP_NAME) is already running." \
		|| cmd /c "start /b $(BIN)"

stop:
	@taskkill /f /im $(APP_NAME).exe 2>nul || echo "$(APP_NAME) is not running."

deps:
	go mod init $(APP_NAME) 2>nul || echo go.mod already initialized
	go get github.com/gin-gonic/gin
	go mod tidy
