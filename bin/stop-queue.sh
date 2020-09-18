#!/bin/sh
RUN_DIR=`pwd`
cd ../queue
docker-compose down
docker system prune -f
cd $RUN_DIR
