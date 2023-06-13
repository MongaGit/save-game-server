#!/bin/sh
cd ~/save-game-server/
git pull

# Variaveis de Container
IMAGE_NAME='monga-project-zomboid'
CONTAINER_SAVE='/home/steam/Zomboid/Saves/Multiplayer/Monga'
BACKUP='./saves-monga-server/'
REPO_SAVE='./project-zomboid-v1.0/'

# Buscando Continer ID
CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')

# Excluindo Save do Container
docker exec $CONTAINER_ID rm -rf $CONTAINER_SAVE

# Criando /temp/ e copiando ultimo backup
cd ~/save-game-server/project-zomboid/
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
