#!/bin/sh

#docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}'
#CONTAINER_ID='cbc1627fac72'
cd ~/save-game-server/
git reset --hard HEAD
git pull origin main

SAVE_NAME="Monga"
IMAGE_NAME="monga-project-zomboid"
USER="/home/monga"
REPO_DIR="$USER/save-game-server"

# Variaveis de Container
CONTAINER_SAVE="/home/steam/Zomboid/Saves/Multiplayer/Monga"
DATA_SAVE="$USER/data/project-zomboid"
PATH_REPO="$USER/save-game-server/project-zomboid/data/"
LOCAL_BACKUP=$DATA_SAVE/$SAVE_NAME/$SAVE_NAME.tar.gz
CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')

# Copiando Save Para Local Tempo
cd $(echo $DATA_SAVE/$SAVE_NAME)
sudo docker cp $CONTAINER_ID:$CONTAINER_SAVE $DATA_SAVE

# Compactando Save e copiando para repositorio
sudo tar -cvzf ./$SAVE_NAME.tar.gz ./
sudo cp -v -r -f $LOCAL_BACKUP $PATH_REPO


# Commit repo
git add .
git commit -m "Zomboid: Backup Save monga"
git push -u origin main

# Comitando Repositorio com Save
cd $(echo $REPO_DIR)
CURRENTDATE=`date +"%d%m%y-%H%m"`
git add .
git commit -m "$CURRENTDATE ZOMBOID: Backup $SAVE_NAME world"
git push -u origin main --force

