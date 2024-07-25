#!/bin/sh

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

if [ -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	echo "MySQL database already exists"
else
	echo "MySQL database does not exist"
	mysql_install_db

	tfile="$(mktemp)"
	if [ ! -f "$tfile" ]; then
		return 1
	fi
	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
CREATE DATABASE $MARIADB_DATABASE;
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
FLUSH PRIVILEGES;
EOF

	echo "Initializing database"
	service mysql start
	cat $tfile
	echo "Executing init file"
	/usr/sbin/mysqld --user=mysql --bootstrap < $tfile
	echo "Removing init file"
	rm -f $tfile
fi

echo "Starting MySQL"
exec /usr/sbin/mysqld --user=mysql --console
