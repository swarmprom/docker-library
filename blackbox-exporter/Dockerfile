ARG DOCKERHUB=docker.io
ARG BLACKBOX_EXPORTER_VERSION=0.28.0

FROM ${DOCKERHUB}/prom/blackbox-exporter:v${BLACKBOX_EXPORTER_VERSION} AS blackbox-exporter

# rootfs
FROM scratch AS rootfs
ADD rootfs /
COPY --from=blackbox-exporter /bin/blackbox_exporter /usr/local/bin/blackbox_exporter
COPY --from=blackbox-exporter /etc/blackbox_exporter/config.yml /etc/blackbox_exporter/config.yml

# final image
FROM base
COPY --from=rootfs / /
EXPOSE 9115/tcp
