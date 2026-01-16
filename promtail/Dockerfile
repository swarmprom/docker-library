ARG DOCKERHUB=docker.io
ARG GO_VERSION=1.25
ARG LOKI_VERSION=3.6.3

FROM ${DOCKERHUB}/golang:${GO_VERSION}-alpine AS build
RUN apk add --no-cache bash git make gcc musl-dev
ARG LOKI_VERSION
ADD https://github.com/grafana/loki.git#v${LOKI_VERSION} /src/loki
WORKDIR /src/loki
RUN make clean && make BUILD_IN_CONTAINER=false PROMTAIL_JOURNAL_ENABLED=false IMAGE_TAG=v${LOKI_VERSION} promtail

# rootfs
FROM scratch AS rootfs
ADD rootfs /
COPY --from=build /src/loki/clients/cmd/promtail/promtail /usr/local/bin/promtail

# final image
FROM alpine
COPY --from=rootfs / /
EXPOSE 9080/tcp
VOLUME [ "/data/promtail" ]
