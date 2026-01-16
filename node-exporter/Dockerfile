ARG DOCKERHUB=docker.io
FROM ${DOCKERHUB}/prom/node-exporter:v1.10.2 AS node-exporter

# rootfs
FROM scratch AS rootfs
ADD rootfs /
COPY --from=node-exporter /bin/node_exporter /usr/local/bin/node_exporter

# final image
FROM alpine
COPY --from=rootfs / /
EXPOSE 9100/tcp
