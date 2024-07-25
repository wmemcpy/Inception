FROM debian:bullseye

RUN apt-get update && \
    apt-get full-upgrade -y && \
    apt-get install -y \
        mariadb-server \
        curl \
        wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 700 /var/run/mysqld

COPY conf/my.cnf /etc/mysql/my.cnf
COPY conf/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
