FROM debian:bullseye

RUN	apt-get update -y && apt-get install -y mariadb-server \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/

COPY tools/configure.sh /

EXPOSE 3306

# Make the script executable
RUN chmod +x configure.sh

# Specify the default command to run when the container starts.
# Unlike ENTRYPOINT, this can be overridden using 'docker run image command'.
CMD ["/configure.sh"]