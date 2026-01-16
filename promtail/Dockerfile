ARG GO_VERSION=1.25
ARG IMAGE_TAG=v3.6.3
ARG DOCKERHUB=docker.io

FROM ${DOCKERHUB}/golang:${GO_VERSION}-alpine AS build
RUN apk add --no-cache bash git make gcc musl-dev
ARG IMAGE_TAG
ADD https://github.com/grafana/loki.git#${IMAGE_TAG} /src/loki
WORKDIR /src/loki
RUN make clean && make BUILD_IN_CONTAINER=false PROMTAIL_JOURNAL_ENABLED=false IMAGE_TAG=${IMAGE_TAG} promtail

FROM alpine
ADD rootfs /

COPY --from=build /src/loki/clients/cmd/promtail/promtail /usr/local/bin/promtail
EXPOSE 9080/tcp
VOLUME [ "/data/promtail" ]
