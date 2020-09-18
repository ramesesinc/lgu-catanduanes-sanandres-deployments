#!/bin/sh
RUN_DIR=`pwd`
cd ../mail
docker-compose down
docker system prune -f
cd $RUN_DIR
