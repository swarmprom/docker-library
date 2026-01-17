FROM scratch

COPY --link --from=base / /
COPY --link --from=blackbox-exporter / /
COPY --link --from=node-exporter / /

# blackbox-exporter
EXPOSE 9115/tcp
# node-exporter
EXPOSE 9100/tcp

ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
