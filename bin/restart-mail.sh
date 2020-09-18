#!/bin/sh
RUN_DIR=`pwd`
cd ../mail
docker-compose down
docker system prune -f
sleep 1
docker-compose up -d
docker-compose logs -f gdx-mail-server
cd $RUN_DIR
