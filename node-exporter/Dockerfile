FROM docker.io/prom/node-exporter:v1.10.2 AS node-exporter

FROM alpine
ADD rootfs /

COPY --from=node-exporter /bin/node_exporter /usr/local/bin/node_exporter
EXPOSE 9100/tcp
