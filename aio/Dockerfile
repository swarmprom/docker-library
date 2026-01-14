FROM scratch

COPY --link --from=blackbox-exporter / /
COPY --link --from=node-exporter / /
COPY --link --from=pushgateway / /
COPY --link --from=cadvisor / /
COPY --link --from=prometheus / /
COPY --link --from=grafana / /

# blackbox-exporter
EXPOSE 9115/tcp
# cadvisor
EXPOSE 8080/tcp
# grafana
EXPOSE 3000/tcp
VOLUME [ "/data/grafana" ]
# node-exporter
EXPOSE 9100/tcp
# prometheus
EXPOSE 9090/tcp
VOLUME [ "/data/prometheus" ]
# pushgateway
EXPOSE 9091/tcp


ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
