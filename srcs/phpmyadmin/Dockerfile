FROM alpine:3.12

COPY default.conf .
COPY phpmyadmin_run.sh .
COPY supervisor.conf .
COPY telegraf.conf .
COPY config.inc.php .

# make nginx socket directory
RUN mkdir -p /run/nginx && \
	mkdir -p /etc/telegraf

# make root directory
RUN mkdir -p /www

# add packages
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# install openrc, wget, php7
RUN apk update && apk add --no-cache --quiet openrc wget php7 php7-fpm php7-opcache \
	php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

# install openssl, nginx, telegraf
RUN apk add openssl nginx telegraf --no-cache --quiet && \
	mv default.conf /etc/nginx/conf.d && \
	mv telegraf.conf /etc/telegraf

# install supervisor
RUN apk add supervisor --no-cache --quiet && \
	mv supervisor.conf /etc/supervisord.conf

# make key
RUN openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/O=42Seoul/OU=Gun/CN=localhost" -keyout etc/ssl/private/localhost.dev.key -out etc/ssl/certs/localhost.dev.crt

EXPOSE 5000

ENTRYPOINT sh phpmyadmin_run.sh
