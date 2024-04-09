default:
	@echo "Please specify a target to run"

clean:
	rm -rf node_modules

install:
	npm install

docker-compose-up:
	docker-compose up -d

prisma-db-push:
	npx --yes wait-on tcp:5432 && \
	DATABASE_URL=postgres://postgres:sample@localhost:5432/sample npm run prisma db push

prisma-generate:
	npm run prisma generate

run-only:
	DATABASE_URL=postgres://postgres:sample@localhost:5432/sample \
	npx --yes esno src/index.ts

run: docker-compose-up prisma-generate prisma-db-push run-only

format:
	npm run prisma format
	npx --yes biome format --write ./src

# Aliases
dcu: docker-compose-up
pdp: prisma-db-push
pg: prisma-generate
r: run
ro: run-only
first: clean install run
fresh: first
f: fresh
