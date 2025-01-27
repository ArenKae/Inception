FROM debian:bullseye

RUN	apt update -y && apt install -y mariadb-server

COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/

COPY tools/configure.sh /

EXPOSE 3306

# Make the script executable
RUN chmod +x configure.sh

CMD ["/configure.sh"]