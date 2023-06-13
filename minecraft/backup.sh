#!/bin/sh

#docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}'
#CONTAINER_ID='cbc1627fac72'
cd ~/save-game-server/
git pull

# Variaveis de Container
IMAGE_NAME='monga-minecraft'
CONTAINER_SAVE='/data/monga'
SERVER_PROPERTIES='./server.properties'
BACKUP='./monga/'
REPO_SAVE='./monga-v1.0/'


# Buscando Continer ID
CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')

# Copiando Save
cd ~/save-game-server/minecraft/
docker cp $CONTAINER_ID:$CONTAINER_SAVE $REPO_SAVE

# Compactando Save e excluindo pasta
tar -cvzf ./monga-v1.0.tar.gz ./monga-v1.0/
sudo rm -rf ./monga-v1.0/

# Commit Save
git add .
git commit -m "Minecraft: Backup Save monga"
git push -u origin main

