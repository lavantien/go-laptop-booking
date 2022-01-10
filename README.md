# Laptop Booking Application in Golang and gRPC

![ci-test](https://github.com/lavantien/go-laptop-booking/actions/workflows/ci.yml/badge.svg?branch=master)
 <a href='https://github.com/jpoles1/gopherbadger' target='_blank'>![gopherbadger-tag-do-not-edit](https://img.shields.io/badge/Go%20Coverage-57%25-brightgreen.svg?longCache=true&style=flat)</a>

## Goals

- [X] GitHub CI & Coverage Badge
- [X] Serialize protobuf messages
- [X] Create laptop unary gRPC
- [X] Search laptop Server-streaming gRPC
- [X] Chunk uploading image with client-streaming gRPC
- [X] Laptop rating bidirectional-streaming gRPC
- [X] gRPC reflection and Evans CLI + grpcui
- [X] Add user API
- [X] gRPC interceptor & JWT authentication with refresh token
- [X] Secure gRPC connection with Mutual SSL/TLS
- [X] Load balancing gRPC Mutual SSL/TLS services with NGINX
- [ ] Generate RESTful service and Swagger documentation with gRPC gateway

## Technology Stack

- **[Go 1.17](https://go.dev/)**
- **[gRPC](https://grpc.io/)**
- **[zsh](https://github.com/ohmyzsh/ohmyzsh)**
- **[panicparse on zsh](https://github.com/maruel/panicparse)**
- **[Evans CLI](https://github.com/ktr0731/evans)**
- **[grpcui](https://github.com/fullstorydev/grpcui)**
- **[golang-jwt](https://github.com/golang-jwt/jwt)**
- **[linuxbrew](https://docs.brew.sh/Homebrew-on-Linux)**
- **[NGINX on linuxbrew](https://nginx.org/en/docs/)**

## Get Start

- Clean the generated Go code: `make clean`
- Generate Go code of gRPC proto files: `make gen`
- Run the server: `make server`
- Run the client: `make client`
- Run the tests: `make test`
- Run the coverage and update the badge: `make badge`
- Run the Evans CLI: `make evans`
- Run the grpcui Web Interface: `make grpcui`
- Verify the SSL certs: `make verifyssl`
- Remake SSL certs: `make cert`
- Update NGINX configs and certs: `make nginxconf`

## Sample

- NGINX config

<details>
	<summary>See details</summary>

```nginx
worker_processes 1;

error_log /home/savaka/go/src/github.com/lavantien/go-laptop-booking/log/nginx/error.log;

events {
	worker_connections 10;
}

http {
	access_log /home/savaka/go/src/github.com/lavantien/go-laptop-booking/log/nginx/access.log;

	upstream auth_services {
		server 0.0.0.0:50051;
	}

	upstream laptop_services {
		server 0.0.0.0:50052;
	}

	server {
		listen 8080 ssl http2;

		# Mutual TLS between gRPC client and NGINX
		ssl_certificate cert/server-cert.pem;
		ssl_certificate_key cert/server-key.pem;

		ssl_client_certificate cert/ca-cert.pem;
		ssl_verify_client on;

		location /pb.AuthService {
			grpc_pass grpcs://auth_services;

			# Mutual TLS between NGINX and gRPC server
			grpc_ssl_certificate cert/server-cert.pem;
			grpc_ssl_certificate_key cert/server-key.pem;
		}

		location /pb.LaptopService {
			grpc_pass grpcs://laptop_services;

			# Mutual TLS between NGINX and gRPC server
			grpc_ssl_certificate cert/server-cert.pem;
			grpc_ssl_certificate_key cert/server-key.pem;
		}
	}
}

```

</details>

- Laptop JSON

<details>
	<summary>See datails</summary>

```json
{
  "id": "21d24c33-13fc-49cb-9e15-85969be270b5",
  "brand": "Apple",
  "name": "Macbook Pro",
  "cpu": {
    "brand": "AMD",
    "name": "Ryzen 7 PRO 2700U",
    "number_cores": 4,
    "number_threads": 11,
    "min_ghz": 2.4010226599566113,
    "max_ghz": 3.3472808181192493
  },
  "ram": {
    "value": "56",
    "unit": "GIGABYTE"
  },
  "gpus": [
    {
      "brand": "AMD",
      "name": "RX 580",
      "min_ghz": 1.438777166984461,
      "max_ghz": 1.9419486357490028,
      "memory": {
        "value": "6",
        "unit": "GIGABYTE"
      }
    }
  ],
  "storages": [
    {
      "driver": "SSD",
      "memory": {
        "value": "712",
        "unit": "GIGABYTE"
      }
    },
    {
      "driver": "HDD",
      "memory": {
        "value": "3",
        "unit": "TERABYTE"
      }
    }
  ],
  "screen": {
    "size_inch": 15.036544,
    "resolution": {
      "width": 4325,
      "height": 2433
    },
    "panel": "OLED",
    "multitouch": false
  },
  "keyboard": {
    "layout": "AZERTY",
    "backlit": false
  },
  "weight_kg": 1.7960889307648087,
  "price_usd": 1841.1951352165595,
  "release_year": 2015,
  "updated_at": "2022-01-06T22:55:18.744484334Z"
}
```

</details>
