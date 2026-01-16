FROM scratch

COPY --link --from=alpine / /
COPY --from=grafana / /
COPY --from=loki / /
COPY --from=opentelemetry-collector / /
COPY --from=prometheus / /
COPY --from=promtail / /
COPY --from=pyroscope / /
COPY --from=tempo / /

ARG DOCKER_OTEL_LGTM_VERSION=v0.14.0
ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/${DOCKER_OTEL_LGTM_VERSION}/docker/grafana-datasources.yaml /etc/grafana/provisioning/datasources/otel-lgtm.yaml
ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/${DOCKER_OTEL_LGTM_VERSION}/docker/grafana-dashboard-jvm-metrics.json /etc/otel-lgtm/dashboards/jvm-metrics.json
ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/${DOCKER_OTEL_LGTM_VERSION}/docker/grafana-dashboard-red-metrics-classic.json /etc/otel-lgtm/dashboards/red-metrics-classic.json
ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/${DOCKER_OTEL_LGTM_VERSION}/docker/grafana-dashboard-red-metrics-native.json /etc/otel-lgtm/dashboards/red-metrics-native.json

# grafana
EXPOSE 3000/tcp
# loki
EXPOSE 3100/tcp
# opentelemetry-collector
EXPOSE 4318/tcp
EXPOSE 4317/tcp
# prometheus
EXPOSE 9090/tcp
# promtail
EXPOSE 9080/tcp
# pyroscope
EXPOSE 4040/tcp
# tempo
EXPOSE 3200/tcp

ADD rootfs /
ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
VOLUME [ "/data"]
