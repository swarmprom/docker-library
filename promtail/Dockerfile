FROM docker.io/grafana/promtail:3.6.3 AS promtail

FROM alpine
ADD rootfs /

RUN apk add --no-cache loki-promtail
# COPY --from=promtail /etc/promtail/config.yml /etc/promtail/config.yml

EXPOSE 9080/tcp
# VOLUME [ "/data/promtail" ]
