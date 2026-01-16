ARG DOCKERHUB=docker.io
ARG S6_VERSION=v3.2.1.0

FROM ${DOCKERHUB}/socheatsok78/s6-overlay:${S6_VERSION} AS s6-overlay
FROM ${DOCKERHUB}/socheatsok78/s6-overlay:${S6_VERSION}-symlinks AS s6-overlay-symlinks

# This is your final image
FROM ${DOCKERHUB}/alpine:latest

ADD rootfs /
RUN chmod +x /init-shim && \
    apk add --no-cache bash ca-certificates curl musl-utils uuidgen tzdata && \
    rm -rf /var/cache/apk/*

# Overlay the s6-overlay files to the root filesystem
# The order of this is up to you, but generally, you want to copy the main s6-overlay first,
# followed by symlinks and syslogd if needed.
COPY --link --from=s6-overlay / /
COPY --link --from=s6-overlay-symlinks / /
ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
