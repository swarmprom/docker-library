ARG DOCKERHUB=docker.io
FROM ${DOCKERHUB}/prom/blackbox-exporter:v0.28.0 AS blackbox-exporter

# rootfs
FROM scratch AS rootfs
ADD rootfs /
COPY --from=blackbox-exporter /bin/blackbox_exporter /usr/local/bin/blackbox_exporter
COPY --from=blackbox-exporter /etc/blackbox_exporter/config.yml /etc/blackbox_exporter/config.yml

# final image
FROM alpine
COPY --from=rootfs / /
EXPOSE 9115/tcp
