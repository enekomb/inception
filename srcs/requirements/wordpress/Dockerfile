FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    wget \
    php7.4 php-all-dev \
    php7.4-fpm \
    php7.4-mysqli php7.4-mysqlnd \
    php-mysql \
    mariadb-client

RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && mv wp-cli.phar /bin/wp-cli.phar && chmod +x /bin/wp-cli.phar && ln -s  /bin/wp-cli.phar /bin/wp

COPY conf/auto_config.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

COPY conf/www.conf /etc/php/7.4/fpm/php-fpm.conf 

ENTRYPOINT ["/usr/local/bin/script.sh"]
