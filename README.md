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

# Initial setup

### Install docker
```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

Install the latest version :
```
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Test the installation:
```
sudo docker run hello-world
```

Add user to the docker group, allowing to use it without sudo (requires restart to take effect)
```
sudo usermod -aG docker $USER
```

### Install docker-compose
Download the latest version from GitHub in /usr/local/bin/docker-compose
```
sudo curl -L "https://github.com/docker/compose/releases/download/v2.34.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

Make it executable :
```
sudo chmod +x /usr/local/bin/docker-compose
```

Check installed version :
```
docker-compose --version
```

## Usage
Simply clone this repository and use ```make``` to build the project.
Then, in your web browser, visit http://localhost and authorize the certifacte.

## Other useful commands

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

Check mariadb
```
mysql -u root -p
SHOW DATABASES;
```

Remove a docker and its image
```
docker stop container-name
docker rm container-name
docker rmi container-image
```