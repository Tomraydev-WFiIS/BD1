#!/usr/bin/env bash
docker-compose up -d
docker-compose logs -f > logs/server.log &
