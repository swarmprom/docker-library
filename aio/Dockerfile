FROM scratch

COPY --link --from=base / /
COPY --link --from=alloy / /
# COPY --link --from=aio-otel-lgmt / /
COPY --link --from=blackbox-exporter / /
COPY --link --from=grafana / /
COPY --link --from=loki / /
# COPY --link --from=node-exporter / /
COPY --link --from=opentelemetry-collector / /
COPY --link --from=prometheus / /
COPY --link --from=pushgateway / /
COPY --link --from=pyroscope / /
COPY --link --from=tempo / /

ARG DOCKER_OTEL_LGTM_VERSION=v0.14.0
ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/${DOCKER_OTEL_LGTM_VERSION}/docker/grafana-datasources.yaml /etc/grafana/provisioning/datasources/otel-lgtm.yaml

# blackbox-exporter
EXPOSE 9115/tcp
# grafana
EXPOSE 3000/tcp
# loki
EXPOSE 3100/tcp
# opentelemetry-collector
EXPOSE 4318/tcp
EXPOSE 4317/tcp
# prometheus
EXPOSE 9090/tcp
# pushgateway
EXPOSE 9091/tcp
# pyroscope
EXPOSE 4040/tcp
# tempo
EXPOSE 3200/tcp

ADD rootfs /
ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
VOLUME [ "/data"]
