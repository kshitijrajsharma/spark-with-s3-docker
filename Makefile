.PHONY: init up down restart logs scale clean test

WORKERS ?= 2

init:
	mkdir -p scripts data spark-logs warehouse notebooks
	[ -f .env ] || cp .env.example .env

up: init
	docker compose up -d --scale spark-worker=$(WORKERS)

down:
	docker compose down

restart: down up 

rebuild: 
	docker compose down
	docker compose build --no-cache
	docker compose up -d --scale spark-worker=$(WORKERS)

logs:
	docker compose logs -f

scale:
	docker compose up -d --scale spark-worker=$(N)

test:
	docker exec spark-master spark-submit scripts/test_wordcount.py

clean:
	docker compose down -v
	rm -rf spark-logs/*  warehouse/*