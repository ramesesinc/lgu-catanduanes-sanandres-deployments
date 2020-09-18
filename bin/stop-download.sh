#!/bin/sh
RUN_DIR=`pwd`
cd ../download
docker-compose down
docker system prune -f
cd $RUN_DIR
