
.PHONY: init up down restart logs scale clean test build update

# Info message for Spark services
SPARK_SERVICES_INFO = \
	\033[1;32mSpark Master:\033[0m    http://localhost:8080\n\
	\033[1;32mSpark History:\033[0m   http://localhost:18080\n\
	\033[1;32mJupyter:\033[0m         http://localhost:8889 (token: spark)\n

WORKERS ?= 1
PETA ?= 1

# Select docker-compose file based on PETA flag
ifeq ($(PETA),1)
	COMPOSE_FILE = -f docker-compose-peta.yml
else
	COMPOSE_FILE = -f docker-compose.yml
endif

init:
	mkdir -p scripts data spark-logs spark-results warehouse notebooks
	chmod -R 777 spark-logs
	chmod -R 777 spark-results
	[ -f .env ] || cp .env.example .env

build: init
	docker compose $(COMPOSE_FILE) build


up: init
	docker compose $(COMPOSE_FILE) up -d --scale spark-worker=$(WORKERS)
	@echo
	@echo "$(SPARK_SERVICES_INFO)"


pull: 
	docker compose $(COMPOSE_FILE) pull

down:
	docker compose $(COMPOSE_FILE) down


restart: down up
	@echo
	@echo "$(SPARK_SERVICES_INFO)"

rebuild: 
	docker compose $(COMPOSE_FILE) down
	docker compose $(COMPOSE_FILE) build --no-cache
	docker compose $(COMPOSE_FILE) up -d --scale spark-worker=$(WORKERS)

update:
	docker compose $(COMPOSE_FILE) pull

logs:
	docker compose $(COMPOSE_FILE) logs -f

scale:
	docker compose $(COMPOSE_FILE) up -d --scale spark-worker=$(N)

test:
	docker exec spark-master spark-submit \
		--master spark://spark-master:7077 \
		--driver-memory 1g \
		--executor-memory 2g \
		--executor-cores 2 \
		--total-executor-cores 4 \
		scripts/test_wordcount.py

clean:
	docker compose $(COMPOSE_FILE) down -v
	rm -rf spark-logs/*  warehouse/*