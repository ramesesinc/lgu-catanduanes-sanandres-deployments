#!/bin/sh
RUN_DIR=`pwd`
cd .. 
BASE_DIR=`pwd`

cd $BASE_DIR/mail
docker-compose down

cd $BASE_DIR/notification
docker-compose down

cd $BASE_DIR/etracs
docker-compose down

cd $BASE_DIR/gdx-client
docker-compose down

cd $BASE_DIR/queue
docker-compose down

cd $RUN_DIR
docker system prune -f
