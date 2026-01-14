FROM scratch

COPY --link --from=aio-exporters / /
COPY --link --from=aio-otel-lgmt / /
COPY --link --from=pushgateway / /

# blackbox-exporter
EXPOSE 9115/tcp
# cadvisor
EXPOSE 8080/tcp
# grafana
EXPOSE 3000/tcp
VOLUME [ "/data/grafana" ]
# loki
EXPOSE 3100/tcp
VOLUME [ "/data/loki" ]
# node-exporter
EXPOSE 9100/tcp
# opentelemetry-collector
EXPOSE 4318/tcp
EXPOSE 4317/tcp
# prometheus
EXPOSE 9090/tcp
VOLUME [ "/data/prometheus" ]
# pushgateway
EXPOSE 9091/tcp
# pyroscope
EXPOSE 4040/tcp
VOLUME [ "/data/pyroscope" ]
# tempo
EXPOSE 3200/tcp
VOLUME [ "/data/tempo"]

ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
