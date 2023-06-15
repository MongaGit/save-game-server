#!/bin/sh

#docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}'
#CONTAINER_ID='cbc1627fac72'
cd ~/save-game-server/
git reset --hard HEAD
git pull origin main

SAVE_NAME='Monga'
VERSION_BACKUP='v1.0'
IMAGE_NAME='monga-project-zomboid'
USER='/home/monga'

# Variaveis de Container
CONTAINER_SAVE='/home/steam/Zomboid/Saves/Multiplayer/Monga'
DATA_SAVE="$USER/data/project-zomboid"
PATH_REPO="$USER/save-game-server/project-zomboid/data"

FULLPATH_REPO="$PATH_REPO/$SAVE_NAME/$SAVE_NAME"

LOCAL_BACKUP=$DATA_SAVE/$SAVE_NAME.tar.gz
CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')

# Copiando Save
cd $(echo $DATA_SAVE/$SAVE_NAME)
sudo docker cp $CONTAINER_ID:$CONTAINER_SAVE $DATA_SAVE

# Compactando Save e excluindo pasta
sudo tar -cvzf ./$SAVE_NAME.tar.gz ./
sudo cp -RT $LOCAL_BACKUP $PATH_REPO

/home/monga/save-game-server/project-zomboid/data/Monga/Monga

sudo rm -rf ./project-zomboid-v1.0/

# Commit Save
git add .
git commit -m "Zomboid: Backup Save monga"
git push -u origin main

