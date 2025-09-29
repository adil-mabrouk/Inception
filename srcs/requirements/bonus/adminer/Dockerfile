FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php \
	php-mysql \
	wget \
	&& rm -rf /var/lib/apt/lists/*

COPY ./script.sh ./script.sh

RUN chmod +x script.sh

ENTRYPOINT [ "./script.sh" ]