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
- [X] Generate RESTful service and OpenAPI documentation with gRPC gateway
- [X] Using Microcks/Postman to test OpenAPI endpoints

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
- **[grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway)**
- **[Swagger convert to OpenAPI 3](https://editor.swagger.io/)**
- **[Microcks](https://microcks.io/documentation/getting-started/)**

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
- Start server 1 with TLS: `make server1tls`
- Start server 2 with TLS: `make server2tls`
- Start client with TLS: `make clienttls`
- Start base server: `make server`
- Start rest server: `make rest`
- Start client to populate data: `make client`

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

- Some REST endpoints:

<details>
	<summary>See details</summary>

```bash
POST http://localhost:8081/v1/auth/login
{
  "username": "admin1",
  "password": "secret"
}
# Result
{
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NDE4MjkwNTAsInVzZXJuYW1lIjoiYWRtaW4xIiwicm9sZSI6ImFkbWluIn0.ZEXQ6XAiZsuTthepwUVxioYXJX-O0jXBIFaNtnWsicU"
}

GET http://localhost:8081/v1/laptop/search?filter.max_price_usd=5000&filter.min_cpu_cores=2&filter.min_cpu_ghz=2.0&filter.min_ram.value=3&filter.min_ram.unit=GIGABYTE
# Result (not a list because the nature of server-streaming)
{
    "result": {
        "laptop": {
            "id": "59811686-1bad-4755-9e00-b6519f082479",
            "brand": "Lenovo",
            "name": "Thinkpad X1",
            "cpu": {
                "brand": "Intel",
                "name": "Core i3-1005G1",
                "numberCores": 7,
                "numberThreads": 11,
                "minGhz": 3.25690128346152,
                "maxGhz": 4.869019798140393
            },
            "ram": {
                "value": "13",
                "unit": "GIGABYTE"
            },
            "gpus": [
                {
                    "brand": "NVIDIA",
                    "name": "RTX 2060",
                    "minGhz": 1.4789741714465086,
                    "maxGhz": 1.4922565481488161,
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
                        "value": "745",
                        "unit": "GIGABYTE"
                    }
                },
                {
                    "driver": "HDD",
                    "memory": {
                        "value": "1",
                        "unit": "TERABYTE"
                    }
                }
            ],
            "screen": {
                "sizeInch": 13.32892,
                "resolution": {
                    "width": 6499,
                    "height": 3656
                },
                "panel": "IPS",
                "multitouch": false
            },
            "keyboard": {
                "layout": "QWERTZ",
                "backlit": false
            },
            "weightKg": 1.7393324744695426,
            "priceUsd": 1501.6397915075097,
            "releaseYear": 2016,
            "updatedAt": "2022-01-10T15:36:56.420852677Z"
        }
    }
}
{
    "result": {
        "laptop": {
            "id": "d05e0809-09d2-4f7e-8fed-b1089513885d",
            "brand": "Apple",
            "name": "Macbook Pro",
            "cpu": {
                "brand": "Intel",
                "name": "Core i7-9750H",
                "numberCores": 6,
                "numberThreads": 11,
                "minGhz": 3.1830385478225462,
                "maxGhz": 4.256661649154569
            },
            "ram": {
                "value": "18",
                "unit": "GIGABYTE"
            },
            "gpus": [
                {
                    "brand": "NVIDIA",
                    "name": "RTX 2070",
                    "minGhz": 1.4077473666779245,
                    "maxGhz": 1.964320393328977,
                    "memory": {
                        "value": "2",
                        "unit": "GIGABYTE"
                    }
                }
            ],
            "storages": [
                {
                    "driver": "SSD",
                    "memory": {
                        "value": "303",
                        "unit": "GIGABYTE"
                    }
                },
                {
                    "driver": "HDD",
                    "memory": {
                        "value": "2",
                        "unit": "TERABYTE"
                    }
                }
            ],
            "screen": {
                "sizeInch": 16.230564,
                "resolution": {
                    "width": 3004,
                    "height": 1690
                },
                "panel": "OLED",
                "multitouch": false
            },
            "keyboard": {
                "layout": "QWERTY",
                "backlit": true
            },
            "weightKg": 1.344500870876185,
            "priceUsd": 2369.4463119126813,
            "releaseYear": 2017,
            "updatedAt": "2022-01-10T15:36:56.421404861Z"
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
