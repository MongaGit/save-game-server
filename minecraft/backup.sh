#!/bin/sh

#docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}'
#CONTAINER_ID='cbc1627fac72'
cd ~/save-game-server/
git reset --hard HEAD
git pull origin main

# Variaveis de Container
VERSION_BACKUP='v1.0'
IMAGE_NAME='minecraft-monga-vanila'

BACKUP_FILE_NAME="monga-vanila-$VERSION_BACKUP.tar.gz"
PATH_ACTUAL_SAVE='~/server-data/minecraft/monga-vanila'
PATH_REPO='~/save-game-server/minecraft/monga-vanila/data'
FULLPATH_REPO="$PATH_REPO/monga-vanila-$VERSION_BACKUP.tar.gz"

BACKUP='~/server-data/monga-vanila/'

CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')
docker stop $CONTAINER_ID

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

