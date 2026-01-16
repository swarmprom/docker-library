ARG GHCR=ghcr.io
FROM ${GHCR}/google/cadvisor:0.56 AS cadvisor

# rootfs
FROM scratch AS rootfs
ADD rootfs /
COPY --from=cadvisor /usr/local/lib/libpfm.so* /usr/local/lib/
COPY --from=cadvisor /usr/bin/cadvisor /usr/local/bin/cadvisor

# final image
FROM alpine
# https://github.com/google/cadvisor/blob/master/deploy/Dockerfile
RUN apk --no-cache add libc6-compat device-mapper findutils ndctl thin-provisioning-tools zfs && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
    rm -rf /var/cache/apk/*
COPY --from=rootfs / /
EXPOSE 8080/tcp
