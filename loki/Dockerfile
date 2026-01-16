ARG DOCKERHUB=docker.io
FROM ${DOCKERHUB}/grafana/loki:3.6.3 AS loki

FROM alpine
ADD rootfs /

ARG DOCKER_OTEL_LGTM_VERSION=v0.14.0
ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/${DOCKER_OTEL_LGTM_VERSION}/docker/loki-config.yaml /etc/loki/config.yaml

COPY --from=loki /usr/bin/loki /usr/local/bin/loki
EXPOSE 3100/tcp
VOLUME [ "/data/loki" ]
