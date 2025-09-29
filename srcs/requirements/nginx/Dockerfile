FROM debian:bookworm

RUN apt update && apt install -y openssl nginx \
	&& rm -rf /var/lib/apt/lists/*
RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -newkey rsa:4096 \
    -keyout /etc/nginx/ssl/amabrouk.key \
    -out /etc/nginx/ssl/amabrouk.crt -sha256 -days 365 -nodes \
    -subj "/C=MA/ST=Casablanca/L=Casablanca/O=1337/OU=1337/CN=amabrouk.42.fr"

COPY nginx.conf /etc/nginx/sites-available/default

RUN echo 'Hello from Nginx in Docker' > /var/www/html/index.html

CMD ["nginx" ,"-g" ,"daemon off;"]
