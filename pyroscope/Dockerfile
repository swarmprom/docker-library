FROM docker.io/grafana/pyroscope:1.17.1 AS pyroscope

FROM base
ADD rootfs /

ARG DOCKER_OTEL_LGTM_VERSION=v0.14.0
ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/${DOCKER_OTEL_LGTM_VERSION}/docker/pyroscope-config.yaml /etc/pyroscope/config.yaml

COPY --from=pyroscope /usr/bin/profilecli /usr/local/bin/profilecli
COPY --from=pyroscope /usr/bin/pyroscope /usr/local/bin/pyroscope
EXPOSE 4040/tcp
VOLUME [ "/data/pyroscope" ]
