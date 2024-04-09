.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean: ## remove dependencies
	rm -rf node_modules

node_modules:
	npm install

docker-compose-up: ## start dependencies
	docker-compose up -d

prisma-db-push: ## push prisma schema to database
	npx --yes wait-on tcp:5432 && \
	DATABASE_URL=postgres://postgres:sample@localhost:5432/sample npm run prisma db push

prisma-generate: ## generate prisma classes
	npm run prisma generate

run-only: ## run the project
	DATABASE_URL=postgres://postgres:sample@localhost:5432/sample \
	npx --yes esno src/index.ts

run: docker-compose-up prisma-generate prisma-db-push run-only ## run the project + dependencies

format: ## format code
	npm run prisma format
	npx --yes biome format --write ./src

# Aliases
install: node_modules ## install dependencies
dcu: docker-compose-up
pdp: prisma-db-push
pg: prisma-generate
r: run
ro: run-only
first: clean install run ## first execution
fresh: first ## fresh execution
f: fresh
