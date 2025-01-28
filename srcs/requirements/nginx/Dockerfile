# Specifies the docker image and version to use for the container
FROM debian:bullseye

# Commands to execute at container start :

# Update packages list and install the necessary packages
RUN	apt-get update -y && apt-get install -y nginx openssl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Create the nginx directory (required for the server to start),
# as well as a directory for the ssl certificate (optional)
# The -p argument ensures the creation of parent directories with 777 permissions and no errors reported
RUN	mkdir -p /run/nginx && mkdir -p /etc/nginx/ssl

# Declare a bluid-time variable to dynamically get the username
ARG USER

# Generate a TLS certificate with the following options :
#	-newkey rsa:4096	-> 4096-bit long key, generated via RSA algorithm
#	-x509				-> generate a self-signed certificate (not issued by a certificate authority)
#	-sha256				-> use the sha-256 hashing algorith to secure the key, standard for TLS certificates
#	-days 365			-> the certificate will be valid for 1 year
#	-nodes				-> the key will not be encrypted with a passphrase (it would be impractical for an automated environment like Docker)
#	-out				-> specifie the output file for the generated certificate
#	-keyout				-> specifie the output file for the generated private key
#	-subj				-> set the subject informations in a non-interactive way (no prompts during execution)
RUN	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out /etc/nginx/ssl/ssl_certificat.pem -keyout /etc/nginx/ssl/ssl_key.key \
	-subj "/C=FR/ST=Nice/L=Nice/O=42Nice/OU=${USER}/CN=${USER}/"

# Copy the configuration file for the nginx server
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Main command to execute once the container is started.
# This syntax specifies that nginx must be launched with arguments -g daemon off.
# Without this, nginx will run in the background and its execution will be considered as complete, resulting in docker terminating the container.
ENTRYPOINT ["nginx", "-g", "daemon off;"]