#!/usr/bin/env bash

if ! [ -x "$(command -v docker)" ]; then
	echo "docker is not installed"
fi

select_available_postgres() {
	docker images --format json postgres | jq -r '.Tag' | fzf
}

start_tempgres() {
	docker run --name tempgres -e POSTGRES_PASSWORD=secret -d -p 5432:5432 "postgres:$1"
	sleep 3
}

start_psql() {
	docker exec -it "$1" psql -U postgres
}

cleanup() {
	_=$(docker container stop tempgres; docker container rm -fv tempgres)
}

selected=$(select_available_postgres)
container_id=$(start_tempgres $selected)
start_psql $container_id
cleanup
