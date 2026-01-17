ARG TARGETARCH
ARG DOCKERHUB=docker.io
ARG GRAFANA_VERSION=12.3

FROM ${DOCKERHUB}/grafana/grafana:${GRAFANA_VERSION} AS grafana

FROM scratch AS grafana-overlay-amd64
COPY --from=grafana /lib64 /lib64
COPY --from=grafana /usr/glibc-compat /usr/glibc-compat

FROM scratch AS grafana-overlay-arm64
# No additional libraries needed for arm64

FROM grafana-overlay-${TARGETARCH} AS grafana-overlay

# rootfs
FROM scratch AS rootfs
ADD rootfs /
COPY --from=grafana-overlay / /
COPY --from=grafana /usr/share/grafana /usr/share/grafana
COPY --from=grafana /run.sh /usr/local/bin/grafana-run

# final image
FROM base
COPY --from=rootfs / /
EXPOSE 3000/tcp
VOLUME [ "/data/grafana" ]
