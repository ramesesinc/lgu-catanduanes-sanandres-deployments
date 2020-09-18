#!/bin/sh
RUN_DIR=`pwd`
cd ../../etracs
docker-compose down
docker system prune -f
sleep 1
docker-compose -f docker-compose.yml -f docker-compose-test.yml up -d
docker-compose logs -f etracs25-server
cd $RUN_DIR

