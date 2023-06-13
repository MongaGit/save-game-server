#!/bin/sh
cd ~/save-game-server/
git pull

# Variaveis de Container
IMAGE_NAME='monga-minecraft'
CONTAINER_SAVE='/data/monga'
SERVER_PROPERTIES='./server.properties'
BACKUP='./monga/'
REPO_SAVE='./monga-v1.0/'
SAVE='monga-v1.0.tar.gz'

# Buscando Continer ID
CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')

# Excluindo Save do Container
docker exec $CONTAINER_ID rm -rf $CONTAINER_SAVE

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

