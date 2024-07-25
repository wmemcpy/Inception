FROM debian:bullseye

RUN apt-get update && \
    apt-get full-upgrade -y && \
    apt-get install -y \
        curl \
        wget \
        php \
        php-fpm \
        php-mysql \
        php-gd \
        mariadb-client \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php /var/www/html

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY conf/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
