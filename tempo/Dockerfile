FROM docker.io/grafana/tempo:2.9.0 AS tempo

FROM base
ADD rootfs /

ARG DOCKER_OTEL_LGTM_VERSION=v0.14.0
ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/${DOCKER_OTEL_LGTM_VERSION}/docker/tempo-config.yaml /etc/tempo/config.yaml

COPY --from=tempo /tempo /usr/local/bin/tempo
EXPOSE 3200/tcp
VOLUME [ "/data/tempo"]
