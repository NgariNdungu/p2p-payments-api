# P2P PAYMENTS API

A peer to peer money transfer system built using rails on docker.

**This is a review project and is not to be used for commercial purposes.**

[see documentation](https://app.swaggerhub.com/apis-docs/NgariNdungu/green-mamba-re/1.0.0).

## Prerequisites

1. [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
2. [Docker-compose](https://docs.docker.com/compose/)
## Run local

1. Clone
```bash
$ git clone https://github.com/NgariNdungu/p2p-payments-api.git
```
2. cd into project directory and build image
```bash
$ cd p2p-payments-api
```
3. Checkout to the develop branch
```bash
$ git checkout -b develop
```
4. Build image
```
$ docker-compose build
```
5. Run
```bash
$ docker-compose up -d
```

## Test
1. [Run app](#run-local).
2. Run tests.
```bash
$ docker-compose exec api bundle exec guard
```

## Project Wrap up

[Wrap Up](https://github.com/NgariNdungu/p2p-payments-api/blob/develop/project-wrapup.md)
