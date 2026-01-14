FROM ghcr.io/google/cadvisor:0.55 AS cadvisor

FROM base
ADD rootfs /

# https://github.com/google/cadvisor/blob/master/deploy/Dockerfile
RUN apk --no-cache add libc6-compat device-mapper findutils ndctl thin-provisioning-tools zfs && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
    rm -rf /var/cache/apk/*
COPY --from=cadvisor /usr/local/lib/libpfm.so* /usr/local/lib/
COPY --from=cadvisor /usr/bin/cadvisor /usr/local/bin/cadvisor
EXPOSE 8080
