# Inception

<p align="center">
  <img src="https://github.com/ArenKae/ArenKae/blob/main/42%20badges/inceptione.png" alt="ft_irc 42 project badge"/>
</p>

## An introduction to containerization
Docker is a containerization technology that allows applications to run in isolated environments called containers. Unlike traditional virtual machines (VMs), which virtualize an entire operating system, Docker containers share the host OS kernel while maintaining their own dependencies, libraries, and configurations. This makes them much lighter, faster, and more efficient than VMs. Containers also provide consistency across environments, ensuring that applications run the same way in development, testing, and production.

The Inception project focuses on building a fully containerized website using Docker and Docker Compose.  We will need to create a small network of 3 Docker containers each running different services (nginx, wordpress, mariaDB). All three must work together over the Docker network to create a local website.

### 💻 This project was developed on Ubuntu 24.04.2 LTS.

## Status
Finished 28/01/2025.

Grade: 100/100

## Usage

Clone this repository and use ```make``` to build the project.

## Useful Commands

Install docker and other dependencies :
```
sudo apt-get install docker-ce docker-ce-cli docker-buildx-plugin docker-compose-plugin openssl python3-dev python3-distutils
```

Add user to the docker group, allowing to use it without sudo (requires logout to take effect)
```
sudo usermod -aG docker $USER
```

Download and test the docker image for debian:buster and apline 3.21
```
docker run -it debian:buster bash
docker run -it alpine:3.21 sh
```

Build a container from local dockerfile
```
docker build -t image-name .
```

Run a container from the specified image, opening the specified port
```
docker run -p 443:443 --name container-name image-name
```

Access the container's shell
```
docker exec -it container-name bash
```

```Check mariadb
mysql -u root -p
SHOW DATABASES;
```

Remove a docker and its image
```
docker stop container-name
docker rm container-name
docker rmi container-image
```