FROM otel/opentelemetry-collector-contrib:nightly AS opentelemetry-collector

FROM base
ADD rootfs /

COPY --from=opentelemetry-collector /otelcol-contrib /usr/local/bin/otelcol-contrib

ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/v0.14.0/docker/otelcol-config.yaml /etc/otelcol/config.yaml
# ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/v0.14.0/docker/otelcol-config-export-http.yaml /etc/otelcol/config-export-http.yaml
