#!/bin/sh
RUN_DIR=`pwd`
cd ../etracs
docker-compose down
docker system prune -f
sleep 1
docker-compose up -d
docker-compose logs -f etracs25-server
cd $RUN_DIR
