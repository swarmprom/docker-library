FROM otel/opentelemetry-collector-contrib:nightly AS opentelemetry-collector

FROM base
ADD rootfs /

ARG DOCKER_OTEL_LGTM_VERSION=v0.14.0
ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/${DOCKER_OTEL_LGTM_VERSION}/docker/otelcol-config.yaml /etc/otelcol/config.yaml
# ADD https://raw.githubusercontent.com/grafana/docker-otel-lgtm/refs/tags/${DOCKER_OTEL_LGTM_VERSION}/docker/otelcol-config-export-http.yaml /etc/otelcol/config-export-http.yaml

COPY --from=opentelemetry-collector /otelcol-contrib /usr/local/bin/otelcol-contrib
