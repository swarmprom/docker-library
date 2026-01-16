ARG DOCKERHUB=docker.io
FROM ${DOCKERHUB}/prom/prometheus:v3.9.1 AS prometheus

FROM alpine
ADD rootfs /

COPY --from=prometheus /bin/prometheus /usr/local/bin/prometheus
COPY --from=prometheus /bin/promtool /usr/local/bin/promtool
# COPY --from=prometheus /etc/prometheus/prometheus.yml /etc/prometheus/prometheus.yml
COPY --from=prometheus /LICENSE /usr/share/prometheus/LICENSE
COPY --from=prometheus /NOTICE /usr/share/prometheus/NOTICE
COPY --from=prometheus /npm_licenses.tar.bz2 /usr/share/prometheus/npm_licenses.tar.bz2

EXPOSE 9090/tcp
VOLUME [ "/data/prometheus" ]
