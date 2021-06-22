FROM alpine:3.12

COPY telegraf.conf .
COPY grafana_run.sh .
COPY supervisord.conf .
COPY grafana.db .

RUN mkdir -p /etc/telegraf

# add packages
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# install openrc, telegraf, supervisor
RUN apk update && apk add openrc telegraf supervisor --no-cache --quiet && \
	mv telegraf.conf /etc/telegraf && \
	mv supervisord.conf /etc/supervisord.conf

# install grafana
RUN apk add --no-cache --quiet --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ grafana

RUN mkdir -p /usr/share/grafana/data
RUN mv grafana.db /usr/share/grafana/data

EXPOSE 3000

ENTRYPOINT sh grafana_run.sh
