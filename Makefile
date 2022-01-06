run:
	go run .

gen:
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative proto/*.proto

clean:
	rm pb/*.go

test:
	go test -cover -coverprofile=profile.cov -race -v -count=1 ./...

badger:
	gopherbadger -md="README.md"

.PHONY: run gen clean test cover badger
