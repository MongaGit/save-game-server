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

### Save Backup e Import
Clone o repositorio <br>
`git clone https://github.com/MongaGit/save-game-server.git`
~/save-game-server/


Backup Save Commit<br>
* ```sh ~/save-game-server/minecraft/backup.sh```

Import Last Save<br>
* ```git pull```
* ```sh ~/save-game-server/minecraft/import.sh```






