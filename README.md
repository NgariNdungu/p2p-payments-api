# P2P PAYMENTS API

A peer to peer money transfer system built using rails on docker.

[see documentation](https://app.swaggerhub.com/apis-docs/NgariNdungu/green-mamba-re/1.0.0).

## Prerequisite

1. Docker
2. Docker-compose 

## Run local

1. Clone
```bash
$ git clone https://github.com/NgariNdungu/p2p-payments-api.git
```
2. cd into project directory and build build image
```bash
$ cd p2p-payments-api && docker-compose build
```
3. Run
```bash
$ docker-compose up -d
```

## Test
1. [Run app](##RUN LOCALLY).
2. Run tests.
```bash
$ docker-compose exec api bundle exec guard
```




