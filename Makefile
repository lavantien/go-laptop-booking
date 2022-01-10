server: SHELL:=/usr/bin/zsh
server:
	export GOTRACEBACK=all
	go run cmd/server/main.go -port 8080 |& pp

client:
	go run cmd/client/main.go -address 0.0.0.0:8080

gen:
	protoc --proto_path=proto --go_out=plugins=grpc:pb --go_opt=paths=source_relative proto/*.proto

clean:
	rm pb/*.go

test:
	go test -cover -coverprofile=profile.cov -race -v -count=1 ./...

badge:
	gopherbadger -md="README.md"

update:
	go get -u ./...
	go mod tidy

evans:
	evans -r repl -p 8080

grpcui:
	grpcui -plaintext localhost:8080

.PHONY: server client gen clean test cover badge update evans grpcui
