FROM scratch

COPY --link --from=alpine / /
COPY --link --from=aio-otel-lgmt / /
COPY --link --from=blackbox-exporter / /
COPY --link --from=cadvisor / /
COPY --link --from=grafana / /
COPY --link --from=loki / /
COPY --link --from=node-exporter / /
COPY --link --from=opentelemetry-collector / /
COPY --link --from=prometheus / /
COPY --link --from=promtail / /
COPY --link --from=pushgateway / /
COPY --link --from=pyroscope / /
COPY --link --from=tempo / /

# blackbox-exporter
EXPOSE 9115/tcp
# cadvisor
EXPOSE 8080/tcp
# grafana
EXPOSE 3000/tcp
# loki
EXPOSE 3100/tcp
# node-exporter
EXPOSE 9100/tcp
# opentelemetry-collector
EXPOSE 4318/tcp
EXPOSE 4317/tcp
# prometheus
EXPOSE 9090/tcp
# promtail
EXPOSE 9080/tcp
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
