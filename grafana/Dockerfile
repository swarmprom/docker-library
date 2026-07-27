ARG TARGETARCH
ARG DOCKERHUB=docker.io
ARG GRAFANA_VERSION=12.3

FROM ${DOCKERHUB}/grafana/grafana:${GRAFANA_VERSION} AS grafana

# rootfs
FROM scratch AS rootfs
ADD rootfs /
COPY --from=grafana /usr/share/grafana /usr/share/grafana
COPY --from=grafana /run.sh /usr/local/bin/grafana-run

# final image
FROM base
COPY --from=rootfs / /
EXPOSE 3000/tcp
VOLUME [ "/data/grafana" ]
