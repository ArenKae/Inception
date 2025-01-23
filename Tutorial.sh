# Install docker and other dependencies :
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin openssl

# Download and test the docker image for debian:buster and apline 3.21
sudo docker run -it debian:buster bash
sudo docker run -it alpine:3.21 sh

