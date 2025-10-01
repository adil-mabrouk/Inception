FROM debian:bookworm

RUN apt update && \
	apt upgrade -y && \
	apt install -y mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY crip.sh /crip.sh

RUN chmod +x /crip.sh

ENTRYPOINT [ "/crip.sh" ]

CMD [ "mysqld_safe" ]