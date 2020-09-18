#!/bin/sh
RUN_DIR=`pwd`
cd ../gdx-client
docker-compose down
docker system prune -f
cd $RUN_DIR
