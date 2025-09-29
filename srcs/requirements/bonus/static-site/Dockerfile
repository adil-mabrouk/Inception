FROM debian:bookworm

RUN apt update -y && apt install -y nginx \
	&& rm -rf /var/lib/apt/lists/*

COPY ./index.html /var/www/html/index.html

CMD [ "nginx", "-g", "daemon off;" ]