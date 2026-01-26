ARG DOCKERHUB=docker.io
ARG ALLOY_VERSION=1.12.2

FROM ${DOCKERHUB}/grafana/alloy:v${ALLOY_VERSION} AS alloy

# rootfs
FROM scratch AS rootfs
ADD rootfs /
COPY --from=alloy /bin/alloy /usr/local/bin/alloy
# COPY --from=alloy /etc/alloy/config.alloy /etc/alloy/config.alloy

# final image
FROM base
COPY --from=rootfs / /
EXPOSE 12344/tcp
