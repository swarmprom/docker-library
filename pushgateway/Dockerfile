ARG DOCKERHUB=docker.io
FROM ${DOCKERHUB}/prom/pushgateway:v1.11.2 AS pushgateway

# rootfs
FROM scratch AS rootfs
ADD rootfs /
COPY --from=pushgateway /bin/pushgateway /usr/local/bin/pushgateway

# final image
FROM alpine
COPY --from=rootfs / /
EXPOSE 9091/tcp
