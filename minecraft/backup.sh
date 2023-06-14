#!/bin/sh

#docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}'
#CONTAINER_ID='cbc1627fac72'
cd ~/save-game-server/
git reset --hard HEAD
git pull origin main

# Variaveis de Container
VERSION_BACKUP='v1.0'
IMAGE_NAME='monga'

BACKUP_FILE_NAME="monga-vanila-$VERSION_BACKUP.tar.gz"
PATH_ACTUAL_SAVE='/root/data/minecraft/monga-vanila/'
PATH_REPO='/root/save-game-server/minecraft/monga-vanila/data'
FULLPATH_REPO="$PATH_REPO/monga-vanila-$VERSION_BACKUP.tar.gz"

#Pausando Container
CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')
docker stop $CONTAINER_ID

/root/dat

# Copiando Save
cd $(echo $PATH_ACTUAL_SAVE)


# Compactando Save e excluindo pasta
cd ~/data/save-game-server/minecraft/monga-vanila/
tar -cvzf ./$BACKUP_FILE_NAME ./



# Commit Save

CURRENTDATE=`date +"%y-%m-%d %T"`

git add .
git commit -m "$CURRENTDATE MINECRAFT: backup monga-vnila world"
git push -u origin main --force

docker start $CONTAINER_ID

