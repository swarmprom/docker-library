FROM scratch
COPY --from=blackbox-exporter / /
COPY --from=node-exporter / /
COPY --from=cadvisor / /
ENTRYPOINT [ "/init-shim" ]
CMD [ "sleep", "infinity" ]
