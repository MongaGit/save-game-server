#!/bin/sh

#docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}'
#CONTAINER_ID='cbc1627fac72'

# Variaveis de Container
IMAGE_NAME='monga-project-zomboid'
CONTAINER_SAVE='/home/steam/Zomboid/Saves/Multiplayer/Monga'
REPO_SAVE='./saves-monga-server/'
REPO_SAVE='./project-zomboid-v1.0/'

# Buscando Continer ID
CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')

# Copiando Save
cd ~/save-game-server/
docker cp $CONTAINER_ID:$CONTAINER_SAVE $REPO_SAVE

# Compactando Save e excluindo pasta
tar -cvzf ./project-zomboid/project-zomboid-v1.0.tar.gz ./project-zomboid-v1.0/
sudo rm -rf ./project-zomboid-v1.0/

# Commit Save
git add .
git commit -m "Update Save Project Zomboid"
git push -u origin main

