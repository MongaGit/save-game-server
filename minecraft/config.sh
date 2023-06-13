#!/bin/sh

# Variaveis de Container
IMAGE_NAME='monga-minecraft'
SERVER_PROPERTIES='./server.properties'
REPO_SAVE='./monga-v1.0/'

# Buscando Continer ID
CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')

# Copiando server.properties para Container
cd ~/save-game-server/minecraft/
docker cp $SERVER_PROPERTIES  $CONTAINER_ID:./data/server.properties


#FIM

