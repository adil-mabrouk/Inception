FROM debian:bookworm

RUN apt update && apt install -y \
	php8.2 \
	php8.2-fpm \
	php-mysql \
	wget \
	&& rm -rf /var/lib/apt/lists/*

COPY ./script.sh ./script.sh

RUN chmod +x script.sh

ENTRYPOINT [ "./script.sh" ]