ARG DOCKERHUB=docker.io
ARG LOKI_VERSION=3.6.3

FROM ${DOCKERHUB}/grafana/loki:${LOKI_VERSION} AS loki

# rootfs
FROM scratch AS rootfs
ADD rootfs /
ARG DOCKER_OTEL_LGTM_VERSION=v0.14.0
ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/${DOCKER_OTEL_LGTM_VERSION}/docker/loki-config.yaml /etc/loki/config.yaml
COPY --from=loki /usr/bin/loki /usr/local/bin/loki

# final image
FROM alpine
COPY --from=rootfs / /
EXPOSE 3100/tcp
VOLUME [ "/data/loki" ]
