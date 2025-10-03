FROM debian:bookworm

RUN apt-get update && apt-get install -y php8.2 \
	php8.2-fpm \
	php8.2-mysql \
	curl \
	&& rm -rf /var/lib/apt/lists/*

COPY ./script.sh ./script.sh

RUN chmod +x ./script.sh

RUN mkdir -p /run/php

ENTRYPOINT ["./script.sh"]

CMD ["php-fpm8.2", "-F"]