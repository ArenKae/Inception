FROM debian:bullseye

RUN	apt update -y && apt install -y mariadb-server

COPY configure.sh /

# Make the script executable
RUN chmod +x configure.sh

CMD ["/configure.sh"]