ARG DOCKERHUB=docker.io
ARG S6_VERSION=v3.2.1.0
ARG ALPINE_VERSION=3.23

FROM ${DOCKERHUB}/socheatsok78/s6-overlay:${S6_VERSION} AS s6-overlay
FROM ${DOCKERHUB}/socheatsok78/s6-overlay:${S6_VERSION}-symlinks AS s6-overlay-symlinks

# rootfs
FROM scratch AS rootfs
ADD rootfs /

# final image
FROM ${DOCKERHUB}/alpine:${ALPINE_VERSION}

ADD rootfs /
RUN chmod +x /init-shim

# # https://github.com/grafana/grafana/blob/main/Dockerfile
RUN apk add --no-cache ca-certificates bash curl tzdata musl-utils && \
    rm -rf /var/cache/apk/*

# https://github.com/google/cadvisor/blob/master/deploy/Dockerfile
RUN apk --no-cache add libc6-compat device-mapper findutils ndctl thin-provisioning-tools zfs && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
    rm -rf /var/cache/apk/*

# Overlay the s6-overlay files to the root filesystem
# The order of this is up to you, but generally, you want to copy the main s6-overlay first,
# followed by symlinks and syslogd if needed.
COPY --link --from=s6-overlay / /
COPY --link --from=s6-overlay-symlinks / /
ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
