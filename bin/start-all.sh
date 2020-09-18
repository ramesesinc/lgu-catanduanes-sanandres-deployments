#!/bin/sh
RUN_DIR=`pwd`
cd .. 
BASE_DIR=`pwd`

docker system prune -f

cd $BASE_DIR/mail
docker-compose up -d

cd $BASE_DIR/notification
docker-compose up -d

cd $BASE_DIR/etracs
docker-compose up -d
sleep 2

cd $BASE_DIR/gdx-client
docker-compose up -d

cd $BASE_DIR/queue
docker-compose up -d

cd $RUN_DIR
