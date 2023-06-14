#!/bin/sh
cd /root/save-game-server/
git reset --hard HEAD
git pull origin main
# Variaveis de Container


# Variaveis de Container
SAVE_NAME='monga-vanila'
IMAGE_NAME='minecraft'

# Variaveis modeladoras estruturais
REPO_DIR="/root/save-game-server"
PATH_REPO="$REPO_DIR/minecraft/data/$SAVE_NAME/"
BACKUP_FILE_NAME="$SAVE_NAME-$VERSION_BACKUP"
PATH_ACTUAL_SAVE='/root/data/minecraft/'
FULLPATH_REPO="$PATH_REPO/$SAVE_NAME-$VERSION_BACKUP.tar.gz"
FULLPATH_ACTUAL_SAVE="/root/data/minecraft/$SAVE_NAME/"

# Pausando Container
CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')
docker stop $CONTAINER_ID

# Copiando Save $SAVE_NAME para o container
#cd $(echo $PATH_ACTUAL_SAVE)
#cd $(echo $REPO_DIR/minecraft/data/)
BACK_SAVE="$REPO_DIR/minecraft/data/"

cd $(echo $PATH_ACTUAL_SAVE)
sudo rm -rf monga-vanila

cd $(echo $BACK_SAVE)
cp -RT $PATH_REPO $FULLPATH_ACTUAL_SAVE

# Iniciando Container
docker start $CONTAINER_ID
