FROM alpine:3.12

COPY default.conf .
COPY nginx_run.sh .
COPY index.html .
COPY telegraf.conf .
COPY supervisord.conf .

# make nginx socket directory
RUN	mkdir -p /run/nginx && \
	mkdir -p /etc/telegraf

# add packages
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# install openssl, nginx, telegraf, supervisor
# --no-cache는 캐쉬를 남기지 않고, --quiet는 터미널에 뜨는 실행로그를 보여주지 않는다.
RUN apk update && apk add openssl nginx telegraf supervisor --no-cache --quiet && \
	mv default.conf /etc/nginx/conf.d && \
	mv index.html /var/www/localhost/htdocs && \
	mv telegraf.conf /etc/telegraf && \
	mv supervisord.conf /etc/supervisord.conf

# make key
RUN openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/O=42Seoul/OU=Gun/CN=localhost" -keyout etc/ssl/private/localhost.dev.key -out etc/ssl/certs/localhost.dev.crt

RUN	chmod 600 etc/ssl/certs/localhost.dev.crt etc/ssl/private/localhost.dev.key

EXPOSE 80 443

ENTRYPOINT sh nginx_run.sh