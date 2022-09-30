#!/bin/sh

print_info() {
	printf "\e[1;35m$1\e[0m - \e[0;37m$2\e[0m\n"
}

help() {
	print_info help "Display callable targets"
	print_info up "Start Docker containers"
	print_info down "Stop and destroy running containers"
	print_info clean "Stop and aggressively remove everything"
	print_info init "Create a new project"
	print_info run "Run the webserver"
	print_info build "Build the site files"
}

up() {
	docker compose up -d --build
}

down() {
	docker compose down
}

clean() {
	docker compose down --rmi 'all' -v --remove-orphans
	docker container prune -f
	docker image prune -af
	docker volume prune -f
	docker system prune -f
}

init() {
	carton init --template tokamak
}

run() {
	carton dev -h 0.0.0.0
}

build() {
	carton bundle
}

if [ ${1:+x} ]; then
	$1
else
	help
fi
	