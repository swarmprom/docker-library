ARG DOCKERHUB=docker.io
ARG PYROSCOPE_VERSION=1.17.1

FROM ${DOCKERHUB}/grafana/pyroscope:${PYROSCOPE_VERSION} AS pyroscope

# rootfs
FROM scratch AS rootfs
ADD rootfs /
ARG DOCKER_OTEL_LGTM_VERSION=v0.14.0
ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/${DOCKER_OTEL_LGTM_VERSION}/docker/pyroscope-config.yaml /etc/pyroscope/config.yaml
COPY --from=pyroscope /usr/bin/profilecli /usr/local/bin/profilecli
COPY --from=pyroscope /usr/bin/pyroscope /usr/local/bin/pyroscope

# final image
FROM base
COPY --from=rootfs / /
EXPOSE 4040/tcp
VOLUME [ "/data/pyroscope" ]
