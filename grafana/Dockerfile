FROM docker.io/grafana/grafana:12.3 AS grafana

FROM base
ADD rootfs /

# https://github.com/grafana/grafana/blob/main/Dockerfile
# Install dependencies
RUN if grep -i -q alpine /etc/issue; then \
    apk add --no-cache ca-certificates bash curl tzdata musl-utils && \
    apk info -vv | sort; \
    elif grep -i -q ubuntu /etc/issue; then \
    DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y ca-certificates curl tzdata musl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*; \
    else \
    echo 'ERROR: Unsupported base image' && /bin/false; \
    fi

# glibc support for alpine x86_64 only
# docker run --rm --env STDOUT=1 sgerrand/glibc-builder 2.40 /usr/glibc-compat > glibc-bin-2.40.tar.gz
ARG GLIBC_VERSION=2.40

RUN if grep -i -q alpine /etc/issue && [ `arch` = "x86_64" ]; then \
    wget -qO- "https://dl.grafana.com/glibc/glibc-bin-$GLIBC_VERSION.tar.gz" | tar zxf - -C / \
    usr/glibc-compat/lib/ld-linux-x86-64.so.2 \
    usr/glibc-compat/lib/libc.so.6 \
    usr/glibc-compat/lib/libdl.so.2 \
    usr/glibc-compat/lib/libm.so.6 \
    usr/glibc-compat/lib/libpthread.so.0 \
    usr/glibc-compat/lib/librt.so.1 \
    usr/glibc-compat/lib/libresolv.so.2 && \
    mkdir /lib64 && \
    ln -s /usr/glibc-compat/lib/ld-linux-x86-64.so.2 /lib64; \
    fi

COPY --from=grafana /usr/share/grafana /usr/share/grafana
COPY --from=grafana /run.sh /etc/s6-overlay/s6-rc.d/grafana/run

EXPOSE 3000/tcp
