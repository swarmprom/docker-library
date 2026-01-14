FROM docker.io/prom/blackbox-exporter:v0.28.0 AS blackbox-exporter

FROM base
ADD rootfs /
COPY --from=blackbox-exporter /bin/blackbox_exporter /usr/local/bin/blackbox_exporter
COPY --from=blackbox-exporter /etc/blackbox_exporter/config.yml /etc/blackbox_exporter/config.yml
EXPOSE 9115/tcp
