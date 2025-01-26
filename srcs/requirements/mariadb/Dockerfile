FROM debian:bullseye

RUN	apt update -y && apt install -y mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/

COPY configure.sh /

EXPOSE 3306

# Make the script executable
RUN chmod +x configure.sh

CMD ["/configure.sh"]