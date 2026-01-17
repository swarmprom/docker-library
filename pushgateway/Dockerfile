ARG DOCKERHUB=docker.io
ARG PUSHGATEWAY_VERSION=1.11.2

FROM ${DOCKERHUB}/prom/pushgateway:v${PUSHGATEWAY_VERSION} AS pushgateway

# rootfs
FROM scratch AS rootfs
ADD rootfs /
COPY --from=pushgateway /bin/pushgateway /usr/local/bin/pushgateway

# final image
FROM base
COPY --from=rootfs / /
EXPOSE 9091/tcp
