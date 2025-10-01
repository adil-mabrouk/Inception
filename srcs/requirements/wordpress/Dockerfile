FROM debian:bookworm
 
RUN apt update -y && apt install -y php php-fpm php-mysql curl \
	&& rm -rf /var/lib/apt/lists/*

COPY ./script.sh ./script.sh

RUN chmod +x ./script.sh

RUN mkdir -p /run/php

ENTRYPOINT ["./script.sh"]

CMD ["php-fpm8.2", "-F"]