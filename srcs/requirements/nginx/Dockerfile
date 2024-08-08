FROM debian:bullseye

RUN apt-get update && \
    apt-get full-upgrade -y && \
    apt-get install -y \
        curl \
        wget \
        nginx \
        openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chown -R www-data:www-data /var/www/html

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
