FROM alpine:3.12

COPY mariadb-server.cnf /tmp/
COPY mysql_init /tmp/
COPY mysql_run.sh .
COPY telegraf.conf .
COPY wordpress_db.sql .
COPY healthy.sh .

RUN chmod 777 -R /tmp/*

RUN mkdir -p /etc/telegraf

# add packages
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# install mysql, openrc, telegraf
RUN apk update && apk add openrc telegraf mysql mysql-client --no-cache --quiet && \
	mv telegraf.conf /etc/telegraf

EXPOSE 3306

ENTRYPOINT sh mysql_run.sh
