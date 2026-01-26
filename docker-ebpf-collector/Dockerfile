ARG DOCKERHUB=docker.io
FROM ${DOCKERHUB}/grafana/alloy:latest
ADD rootfs /
CMD ["run", "/etc/docker-ebpf-collector/config.alloy", "--server.http.listen-addr=0.0.0.0:12346", "--storage.path=/data/docker-ebpf-collector"]
