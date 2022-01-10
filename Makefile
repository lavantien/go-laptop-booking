server:
	go run cmd/server/main.go -port 8080

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

.PHONY: run gen clean test cover badge
