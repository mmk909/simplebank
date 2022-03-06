postgres:
	docker run --name postgres12 -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank --username=postgres

migrateup:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test: 
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test