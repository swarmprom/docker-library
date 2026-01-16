ARG DOCKERHUB=docker.io
FROM ${DOCKERHUB}/grafana/alloy:latest
ADD rootfs /
CMD ["run", "/etc/alloy/config.alloy", "--server.http.listen-addr=0.0.0.0:12345", "--storage.path=/var/lib/alloy/data"]
