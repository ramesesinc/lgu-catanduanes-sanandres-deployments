#!/bin/sh
RUN_DIR=`pwd`
cd ../download
docker-compose down
docker system prune -f
sleep 1
docker-compose up -d
docker-compose logs -f nginx-download-server node-download-server
cd $RUN_DIR
