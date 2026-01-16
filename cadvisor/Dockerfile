ARG GHCR=ghcr.io
FROM ${GHCR}/google/cadvisor:0.56 AS cadvisor

# rootfs
FROM scratch AS rootfs
ADD rootfs /
COPY --from=cadvisor /usr/local/lib/libpfm.so* /usr/local/lib/
COPY --from=cadvisor /usr/bin/cadvisor /usr/local/bin/cadvisor

# final image
FROM alpine
COPY --from=rootfs / /
EXPOSE 8080/tcp
