FROM alpine:3.12

COPY telegraf.conf .
COPY vsftpd.conf .
COPY ftps_run.sh .
COPY healthy.sh .

RUN mkdir -p /var/ftp && \
	mkdir -p /etc/telegraf

# add packages
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# install vsftpd, openssl, telegraf, supervisor
RUN apk update && apk add openrc vsftpd openssl telegraf --no-cache --quiet && \
	mv telegraf.conf /etc/telegraf && \
	mv vsftpd.conf /etc/vsftpd

# make key
RUN openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/O=42Seoul/OU=Gun/CN=localhost" -keyout /etc/vsftpd/ftps.key -out /etc/vsftpd/ftps.crt

# make id
RUN adduser -D -g 'hyunkim' hyunkim && \
	echo "hyunkim:password" | chpasswd

EXPOSE 21 21000

ENTRYPOINT sh ftps_run.sh
