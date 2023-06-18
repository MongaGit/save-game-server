#!/bin/sh
cd /root/save-game-server/
git reset --hard HEAD
git pull origin main

# Variaveis de Container
SAVE_NAME='monga-vanila'
IMAGE_NAME='minecraft'
USER='/home/monga'

# Variaveis modeladoras estruturais
REPO_DIR="$USER/save-game-server"
PATH_REPO="$REPO_DIR/minecraft/data/$SAVE_NAME/"
BACKUP_FILE_NAME="$SAVE_NAME-$VERSION_BACKUP"
PATH_ACTUAL_SAVE="$USER/data/minecraft/"
FULLPATH_ACTUAL_SAVE="$USER/data/minecraft/$SAVE_NAME/"

# Copiando Save $SAVE_NAME para o container
#FULLPATH_REPO="$PATH_REPO/$SAVE_NAME-$VERSION_BACKUP.tar.gz"
#cd $(echo $PATH_ACTUAL_SAVE)
#cd $(echo $REPO_DIR/minecraft/data/)
BACK_SAVE="$REPO_DIR/minecraft/data/"

#cd $(echo $PATH_ACTUAL_SAVE)
#sudo rm -rf monga-vanila
cd $(echo $BACK_SAVE)
cp -RT $PATH_REPO $FULLPATH_ACTUAL_SAVE

# Restartando Container
cd $(echo $REPO_DIR/minecraft)
docker-compose -f docker-compose.yml up -d --build

# Restartando Container
#CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')
#docker restart $CONTAINER_ID
