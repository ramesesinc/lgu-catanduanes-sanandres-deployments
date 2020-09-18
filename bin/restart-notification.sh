#!/bin/sh
RUN_DIR=`pwd`
cd ../notification
docker-compose down
docker system prune -f
sleep 1
docker-compose up -d
docker-compose logs -f rameses-notification-server
cd $RUN_DIR
