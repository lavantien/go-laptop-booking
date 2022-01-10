# Laptop Booking Application in Golang and gRPC

![ci-test](https://github.com/lavantien/go-laptop-booking/actions/workflows/ci.yml/badge.svg?branch=master)
 <a href='https://github.com/jpoles1/gopherbadger' target='_blank'>![gopherbadger-tag-do-not-edit](https://img.shields.io/badge/Go%20Coverage-75%25-brightgreen.svg?longCache=true&style=flat)</a>

## Goals

- [X] GitHub CI & Coverage Badge
- [X] Serialize protobuf messages
- [X] Unary gRPC
- [X] Server-streaming gRPC
- [X] Chunk uploading image with client-streaming gRPC
- [ ] Bidirectional-streaming gRPC
- [ ] gRPC reflection and Evans CLI
- [ ] gRPC interceptor & JWT authentication
- [ ] Secure gRPC connection with SSL/TLS
- [ ] Load balancing gRPC service with NGINX
- [ ] Generate RESTful service and Swagger documentation with gRPC gateway

## Technology Stack

- **[Go 1.17](https://go.dev/)**
- **[gRPC](https://grpc.io/)**

## Get Start

- Clean the generated Go code: `make clean`
- Generate Go code of gRPC proto files: `make gen`
- Run the server: `make server`
- Run the client: `make client`
- Run the tests: `make test`
- Run the coverage and update the badge: `make badge`

## Sample

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
