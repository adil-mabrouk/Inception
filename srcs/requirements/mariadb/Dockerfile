FROM debian:bookworm

RUN apt update && \
	apt upgrade -y && \
	apt install -y mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT [ "/script.sh" ]

CMD [ "mysqld_safe" ]