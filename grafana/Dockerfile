ARG TARGETARCH
ARG DOCKERHUB=docker.io

FROM ${DOCKERHUB}/grafana/grafana:12.3 AS grafana

FROM scratch AS grafana-overlay-amd64
COPY --from=grafana /lib64 /lib64
COPY --from=grafana /usr/glibc-compat /usr/glibc-compat

FROM scratch AS grafana-overlay-arm64
# No additional libraries needed for arm64

FROM grafana-overlay-${TARGETARCH} AS grafana-overlay

FROM alpine
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

COPY --from=grafana-overlay / /
COPY --from=grafana /usr/share/grafana /usr/share/grafana
COPY --from=grafana /run.sh /usr/local/bin/grafana-run

EXPOSE 3000/tcp
VOLUME [ "/data/grafana" ]
