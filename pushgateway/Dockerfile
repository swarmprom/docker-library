ARG DOCKERHUB=docker.io
FROM ${DOCKERHUB}/prom/pushgateway:v1.11.2 AS pushgateway

FROM alpine
ADD rootfs /

COPY --from=pushgateway /bin/pushgateway /usr/local/bin/pushgateway
EXPOSE 9091/tcp
