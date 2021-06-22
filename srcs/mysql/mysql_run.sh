# nginx
chmod 444 /tmp/mariadb-server.cnf

# connect wordpress
mv /tmp/mariadb-server.cnf /etc/my.cnf.d/

# rc-status 이게 없으면 실행이 안됨 touch 이게 없으면 rc-service가 실행이 안됨
rc-status && touch /run/openrc/softlevel && rc-service mariadb setup && rc-service mariadb start

mysql -u root mysql < /tmp/mysql_init
mysql -u root wordpress_db < wordpress_db.sql

telegraf
/usr/bin/mysqld_safe
