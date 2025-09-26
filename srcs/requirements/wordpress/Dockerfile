FROM debian:bullseye
 
RUN apt update -y && apt install -y php php-fpm php-mysql curl

WORKDIR /var/www/html

COPY /script.sh /script.sh

RUN chmod +x /script.sh

RUN mkdir -p /run/php

ENTRYPOINT ["/script.sh"]

CMD ["php-fpm7.4", "-F"]