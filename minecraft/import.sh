#!/bin/sh

# Variaveis de Container
IMAGE_NAME='monga-minecraft'
CONTAINER_SAVE='/data/monga'
SERVER_PROPERTIES='./server.properties'
BACKUP='./monga/'
REPO_SAVE='./monga-v1.0/'

# Buscando Continer ID
CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')

# Excluindo Save do Container
docker exec $CONTAINER_ID rm -rf $CONTAINER_SAVE

# Copiando server.properties para Container
cd ~/save-game-server/minecraft/
docker cp $SERVER_PROPERTIES  $CONTAINER_ID:./data/server.properties

# Criando /temp/ e copiando ultimo backup
cd ~/save-game-server/minecraft/
mkdir temp
cp project-zomboid-v1.0.tar.gz temp/

# Descompactando Save
cd ~/save-game-server/project-zomboid/temp/
tar -xvzf project-zomboid-v1.0.tar.gz

# Copiando Backup para Container
docker cp $REPO_SAVE $CONTAINER_ID:$CONTAINER_SAVE 

# Excluindo /temp/
cd ~/save-game-server/project-zomboid/
sudo rm -rf temp/

# Reiniciando Container
docker restart $CONTAINER_ID

#FIM

