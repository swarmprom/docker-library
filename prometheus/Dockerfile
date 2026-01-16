ARG DOCKERHUB=docker.io
ARG PROMETHEUS_VERSION=3.9.1

FROM ${DOCKERHUB}/prom/prometheus:v${PROMETHEUS_VERSION} AS prometheus

# rootfs
FROM scratch AS rootfs
ADD rootfs /
COPY --from=prometheus /bin/prometheus /usr/local/bin/prometheus
COPY --from=prometheus /bin/promtool /usr/local/bin/promtool
# COPY --from=prometheus /etc/prometheus/prometheus.yml /etc/prometheus/prometheus.yml
COPY --from=prometheus /LICENSE /usr/share/prometheus/LICENSE
COPY --from=prometheus /NOTICE /usr/share/prometheus/NOTICE
COPY --from=prometheus /npm_licenses.tar.bz2 /usr/share/prometheus/npm_licenses.tar.bz2

# final image
FROM alpine
COPY --from=rootfs / /
EXPOSE 9090/tcp
VOLUME [ "/data/prometheus" ]
