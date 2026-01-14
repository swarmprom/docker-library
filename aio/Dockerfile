FROM scratch
COPY --from=blackbox-exporter / /
COPY --from=node-exporter / /
COPY --from=pushgateway / /
COPY --from=cadvisor / /
COPY --from=prometheus / /
# COPY --from=grafana / /
ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
