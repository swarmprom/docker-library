FROM scratch

COPY --from=blackbox-exporter / /
COPY --from=node-exporter / /
COPY --from=cadvisor / /

# blackbox-exporter
EXPOSE 9115/tcp
# cadvisor
EXPOSE 8080/tcp
# node-exporter
EXPOSE 9100/tcp

ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
