#!/usr/bin/env sh

docker-compose down --remove-orphans
docker system prune -af
docker-compose up --build -d main-services
