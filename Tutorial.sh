# Install docker and other dependencies :
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin openssl

# Download and test the docker image for debian:buster and apline 3.21
sudo docker run -it debian:buster bash
sudo docker run -it alpine:3.21 sh

# Build a container from local dockerfile
docker build -t image-name .

# Rune a container from the specified image, opening the specified port
docker run -p 443:443 --name container-name image-name

# Remove a docker and its image
docker container-name
docker docker rm container-name
docker rmi container-image