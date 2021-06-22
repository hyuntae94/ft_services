FROM alpine:3.12

COPY wordpress_run.sh .
COPY default.conf .
COPY supervisor.conf .
COPY telegraf.conf .

# make nginx socket directory
RUN mkdir -p /run/nginx && \
	mkdir -p /etc/telegraf

# make root directory
RUN mkdir -p /www

# add packages
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# pull wordpress
ADD https://wordpress.org/latest.tar.gz .

# tar wordpress
RUN tar -xf latest.tar.gz && \
	mv wordpress /www && \
	rm -f latest.tar.gz

# install php7 package
RUN apk update && \
	apk add --no-cache --quiet php7 php7-fpm php7-opcache php7-gd php7-mysqli \
	php7-zlib php7-curl php7-mbstring php7-json php7-session

# install nginx, telegraf
RUN apk add nginx telegraf --no-cache --quiet && \
	mv default.conf /etc/nginx/conf.d && \
	mv telegraf.conf /etc/telegraf

# install supervisor
RUN apk add supervisor --no-cache --quiet && \
	mv supervisor.conf /etc/supervisord.conf

EXPOSE 5050

ENTRYPOINT sh wordpress_run.sh
