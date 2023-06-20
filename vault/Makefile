.ONESHELL:

docker-build:
	docker build --build-arg -t kevlar-xyz:kevlar-vault:latest .

run:
	docker compose -f docker/docker-compose.yml up -d --build --remove-orphans

all: docker-build run