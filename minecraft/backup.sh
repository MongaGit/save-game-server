#!/bin/sh

#docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}'
#CONTAINER_ID='cbc1627fac72'
cd ~/save-game-server/
git reset --hard HEAD
git pull origin main

# Variaveis identificação de Save
SAVE_NAME='monga-vanila'
VERSION_BACKUP='v1.0'
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
cd $(echo $PATH_REPO)
cp -RT $FULLPATH_ACTUAL_SAVE $PATH_REPO

# Comitando Repositorio com Save
cd $(echo $REPO_DIR)
CURRENTDATE=`date +"%d%m%y-%H%m"`
git add .
git commit -m "$CURRENTDATE MINECRAFT: backup monga-vnila world"
git push -u origin main --force

# Iniciando Container
docker start $CONTAINER_ID

