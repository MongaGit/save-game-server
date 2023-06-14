#!/bin/sh
cd /root/save-game-server/
git reset --hard HEAD
git pull origin main
# Variaveis de Container


# Variaveis de Container
VERSION_BACKUP='v1.0'
IMAGE_NAME='minecraft'

BACKUP_FILE_NAME="monga-vanila-$VERSION_BACKUP"
PATH_ACTUAL_SAVE='/root/data/minecraft/'
PATH_REPO='/root/save-game-server/minecraft/'
FULLPATH_REPO="$PATH_REPO/monga-vanila-$VERSION_BACKUP.tar.gz"
FULLPATH_ACTUAL_SAVE='/root/data/minecraft/monga-vanila/'

# Pausando Container
CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')
docker stop $CONTAINER_ID

#Excluindo save local
cd $(echo $PATH_ACTUAL_SAVE)
sudo rm -rf monga-vanila
mkdir monga-vanila

# Copiando Save
cd $(echo $PATH_REPO)
cp $BACKUP_FILE_NAME.tar.gz $FULLPATH_ACTUAL_SAVE

cd $(echo $FULLPATH_ACTUAL_SAVE)
tar -xvzf monga-vanila-v1.0.tar.gz

tar -xvzf $BACKUP_FILE_NAME.tar.gz


cd $(echo $PATH_REPO)
sudo rm 

# Compactando Save e excluindo pasta
cd ~/data/save-game-server/minecraft/monga-vanila/
tar -cvzf ./$BACKUP_FILE_NAME ./


# Descompactando Save /monga-v1.0/
cd ~/save-game-server/minecraft/
tar -xvzf monga-v1.0.tar.gz

# Copiando Backup para Container
docker cp $REPO_SAVE $CONTAINER_ID:$CONTAINER_SAVE 

# Excluindo /monga-v1.0/
cd ~/save-game-server/project-zomboid/
sudo rm -rf monga-v1.0/

# Reiniciando Container
docker restart $CONTAINER_ID

#FIM

