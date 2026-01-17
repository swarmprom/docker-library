ARG DOCKERHUB=docker.io
ARG NODE_EXPORTER_VERSION=1.10.2

FROM ${DOCKERHUB}/prom/node-exporter:v${NODE_EXPORTER_VERSION} AS node-exporter

# rootfs
FROM scratch AS rootfs
ADD rootfs /
COPY --from=node-exporter /bin/node_exporter /usr/local/bin/node_exporter

# final image
FROM base
COPY --from=rootfs / /
EXPOSE 9100/tcp
