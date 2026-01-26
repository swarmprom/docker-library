ARG DOCKERHUB=docker.io
FROM ${DOCKERHUB}/grafana/alloy:latest
ADD rootfs /
CMD ["run", "/etc/pyroscope-alloy-ebpf/config.alloy", "--server.http.listen-addr=0.0.0.0:12346", "--storage.path=/data/pyroscope-alloy-ebpf"]
