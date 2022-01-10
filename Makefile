server1: SHELL:=/usr/bin/zsh
server1:
	GOTRACEBACK=all go run cmd/server/main.go -port 50051 |& pp

server2: SHELL:=/usr/bin/zsh
server2:
	GOTRACEBACK=all go run cmd/server/main.go -port 50052 |& pp

server1tls: SHELL:=/usr/bin/zsh
server1tls:
	GOTRACEBACK=all go run cmd/server/main.go -port 50051 -tls |& pp

server2tls: SHELL:=/usr/bin/zsh
server2tls:
	GOTRACEBACK=all go run cmd/server/main.go -port 50052 -tls |& pp

server: SHELL:=/usr/bin/zsh
server:
	GOTRACEBACK=all go run cmd/server/main.go -port 8080 |& pp

client:
	go run cmd/client/main.go -address 0.0.0.0:8080

clienttls:
	go run cmd/client/main.go -address 0.0.0.0:8080 -tls

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

cert:
	cd cert; ./gen.sh; cd ..

verifyssl:
	cd cert; openssl verify -CAfile ca-cert.pem server-cert.pem; cd ..

nginxconf:
	cp /home/savaka/go/src/github.com/lavantien/go-laptop-booking/cert/server-cert.pem /home/savaka/go/src/github.com/lavantien/go-laptop-booking/cert/server-key.pem /home/savaka/go/src/github.com/lavantien/go-laptop-booking/cert/ca-cert.pem /home/linuxbrew/.linuxbrew/etc/nginx/cert/
	mv /home/linuxbrew/.linuxbrew/etc/nginx/nginx.conf /home/linuxbrew/.linuxbrew/etc/nginx/nginx.conf.bk
	cp nginx.conf /home/linuxbrew/.linuxbrew/etc/nginx/

.PHONY: server1 server2 server1tls server2tls server client clienttls gen clean test cover badge update evans grpcui cert verifyssl nginxconf
