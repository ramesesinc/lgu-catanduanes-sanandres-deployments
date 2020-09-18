#!/bin/sh
RUN_DIR=`pwd`
cd ../../etracs
docker-compose down
docker system prune -f
cd $RUN_DIR

