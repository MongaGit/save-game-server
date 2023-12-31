# Monga Server Games Saves
Repositorio de Saves de servidores de jogos online

## Container Docker
Repositorio Terraform Container Docker.<br>
[MongaGit/monga-container-docker](https://github.com/MongaGit/monga-container-docker)


### Automation Terraform on Azure
`git clone https://github.com/MongaGit/monga-container-docker`

### Login Azure Provider
```
cd ./Docker-Container/
az login
```
### Terraform Deploy
```
terraform init
terraform plan
terraform apply --auto-approve
```
[Terraform Documentação](https://developer.hashicorp.com/terraform/downloads)

# Server Games

## Project Zomboid

### Criando Container
Imagem Docker utilizada [docker.io/lorthe/monga-project-zomboid](https://hub.docker.com/r/lorthe/monga-project-zomboid)

```
sudo apt update
sudo docker pull lorthe/monga-project-zomboid:latest

## Run Docker ProjectZomboid
sudo docker rm -f project-zomboid

sudo docker run -d -t -i -e SERVERNAME='Monga Projetc Zomboid' \
-p 27015:27015/tcp -p 16261:16261/udp -p 16262:16262/udp \
-e ADMINPASSWORD='Password@123' \
-e FORCEUPDATE='' \
-e MOD_IDS=2931602698,2931602698 \
-e WORKSHOP_IDS=2875848298,2849247394,2923439994,2859296947,2859296947,2859296947 \
--name project-zomboid lorthe/monga-project-zomboid
```

### Save Backup e Import
Clone o repositorio <br>
`git clone https://github.com/MongaGit/save-game-server.git`

~/save-game-server/


Backup Save Commit<br>
* ```sh ~/save-game-server/project-zomboid/backup.sh```

Import Last Save<br>
* ```git pull```
* ```sh ~/save-game-server/project-zomboid/import.sh```


## Minecraft

### Criando Container
Imagem Docker utilizada [docker.io/lorthe/monga-minecraft](https://hub.docker.com/r/lorthe/monga-minecraft)

```
sudo apt update
sudo docker pull lorthe/monga-minecraft:latest

## Run Docker Monga
docker run --name minecraft -d -it -p 25565:25565 -e EULA=TRUE lorthe/monga-minecraft:latest
```

```bash
docker run -d -it -p 25565:25565 -e EULA=TRUE /
-e RCON_PASSWORD='P@ssw0rd' /
-e SERVER_NAME='Monga Server' /
-e DIFFICULTY=hard /
-e MOTD='\u00A72MINECRAFT MONGA\u00A7r\n\u00A74Save Monga V2.0' /
-e ICON='https://raw.githubusercontent.com/MongaGit/.github/main/profile/images/images.png' /
-v '~/data/minecraft/monga-vanila/:/data' /
--name minecraft lorthe/monga-minecraft:latest
```

### Save Backup e Import
Clone o repositorio <br>
`git clone https://github.com/MongaGit/save-game-server.git`
~/save-game-server/


Backup Save Commit<br>
* ```sh ~/save-game-server/minecraft/backup.sh```

Import Last Save<br>
* ```git pull```
* ```sh ~/save-game-server/minecraft/import.sh```

Import Config<br>
* ```git pull```
* ```sh ~/save-game-server/minecraft/config.sh```



```bash
IMAGE_NAME='lorthe/monga-minecraft'
CONTAINER_ID=$(docker container ls --all | grep -w $IMAGE_NAME | awk '{print $1}')

docker logs $CONTAINER_ID --follow

docker exec -it $CONTAINER_ID sh

```


# Counter Strike GO

### Install docker

[SRCDS_TOKEN](https://steamcommunity.com/dev/managegameservers)
[SRCDS_WORKSHOP_AUTHKEY](https://steamcommunity.com/dev/apikey)

```docker pull cm2network/csgo:sourcemod```

```bash
docker run -d --net=host -v $(pwd)/data/csgo/monga-default:/home/steam/csgo-dedicated/ /
-e SRCDS_TOKEN='DEVxMANAGEMAMESERVER' /
-e SRCDS_WORKSHOP_AUTHKEY='DEVxAPIKEY' /
-e SRCDS_PW='YOUTPASSWORD' /
-e SRCDS_PORT=27015 /
-e SRCDS_TV_PORT=27020 /
-e SRCDS_TICKRATE=128 /
-e SRCDS_MAXPLAYERS=10 /
-e SRCDS_STARTMAP="de_mirage" /
-e SRCDS_HOSTNAME="MONGA CSGO SERVER" /
-e SRCDS_HOST_WORKSHOP_COLLECTION=0 /
--name=csgo-dedicated cm2network/csgo:sourcemod

```

