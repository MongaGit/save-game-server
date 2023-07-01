#!/bin/sh
cd ~/save-game-server/
git reset --hard HEAD
git pull origin main

# Variaveis Save
SAVE_NAME="Monga"
COMPACTADO="$SAVE_NAME.tar.gz"
IMAGE_NAME="monga-project-zomboid"
USER="/home/monga"
REPO_DIR="$USER/save-game-server/project-zomboid/data"

# Variaveis de Container
CONTAINER_SAVE="/home/steam/Zomboid/Saves/Multiplayer/Monga"
DATA_SAVE="$USER/data/project-zomboid"
FULLDATA_SAVE="$DATA_SAVE/Monga"
FULLPATH_BACKUP="$REPO_DIR/$SAVE_NAME.tar.gz"

# Pausando Container
CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')
docker stop $CONTAINER_ID

# Excluindo Save Data local folder
cd $(echo $DATA_SAVE)
sudo rm -rf Monga
sudo mkdir Monga

# Copiando save do container para Data local
sudo cp -v -r -f $FULLPATH_BACKUP $FULLDATA_SAVE
cd $(echo $FULLDATA_SAVE)
# Compactando save
sudo tar -xvf $COMPACTADO

# Copiando pasta Data com backup para Container
sudo docker cp $FULLDATA_SAVE $CONTAINER_ID:$CONTAINER_SAVE 

# Reiniciando Container
docker start $CONTAINER_ID

#FIM
