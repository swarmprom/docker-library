FROM base
# FROM gcr.io/cadvisor/cadvisor:v0.52.1
ADD rootfs /
CMD ["--v=0", "--docker_only", "--housekeeping_interval=15s", "--max_housekeeping_interval=1m", "--update_machine_info_interval=15s"]
