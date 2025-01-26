# Install docker and other dependencies :
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin openssl python3-dev python3-distutils

# Adds the user to the docker group, allowing to use it without sudo
# (requires logout to take effect)
sudo usermod -aG docker $USER

# Download and test the docker image for debian:buster and apline 3.21
sudo docker run -it debian:buster bash
sudo docker run -it alpine:3.21 sh

# Build a container from local dockerfile
docker build -t image-name .

# Run a container from the specified image, opening the specified port
docker run -p 443:443 --name container-name image-name

# Access the container's shell
docker exec -it container-name bash

# Check mariadb
mysql -u root -p
SHOW DATABASES;

# Remove a docker and its image
docker stop container-name
docker rm container-name
docker rmi container-image