FROM scratch

COPY --link --from=alpine / /
COPY --link --from=blackbox-exporter / /
COPY --link --from=node-exporter / /
COPY --link --from=cadvisor / /

# blackbox-exporter
EXPOSE 9115/tcp
# cadvisor
EXPOSE 8080/tcp
# node-exporter
EXPOSE 9100/tcp

ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
