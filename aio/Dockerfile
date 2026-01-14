FROM scratch

COPY --from=blackbox-exporter / /
COPY --from=node-exporter / /
COPY --from=pushgateway / /
COPY --from=cadvisor / /
COPY --from=prometheus / /
COPY --from=grafana / /

# blackbox-exporter
EXPOSE 9115/tcp
# cadvisor
EXPOSE 8080/tcp
# grafana
EXPOSE 3000/tcp
# node-exporter
EXPOSE 9100/tcp
# prometheus
EXPOSE 9090/tcp
# pushgateway
EXPOSE 9091/tcp

ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
