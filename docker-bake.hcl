variable "DOCKERHUB" { default = "docker.io" }
variable "GHCR" { default = "ghcr.io" }

variable "GITHUB_REPOSITORY_OWNER" {
  default = "swarmprom"
}

function "dockerhub" {
  params = [name, version]
  result = "docker.io/${GITHUB_REPOSITORY_OWNER}/${name}:${version}"
}

function "ghcr" {
  params = [name, version]
  result = "ghcr.io/${GITHUB_REPOSITORY_OWNER}/${name}:${version}"
}

target "docker-metadata-action" {}
target "github-metadata-action" {}

target "dockerfile" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
    ]
    args = {
      DOCKERHUB = DOCKERHUB
      GHCR = GHCR
    }
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
}

group "default" {
  targets = [
        "aio",
        "aio-exporters",
        "aio-otel-lgmt",
        "images",
    ]
}

target "alpine" {
    inherits = [ "dockerfile" ]
    context = "alpine"
    args = {}
    tags = [
        // dockerhub("alpine", "latest"),
        ghcr("alpine", "latest"),
    ]
}

variable "BASE_TARGET_CONTEXT" { default = "ubuntu" }
target "aio" {
    inherits = [ "dockerfile" ]
    context = "aio"
    contexts = {
      aio-otel-lgmt = "target:aio-otel-lgmt-rootfs"
      base = "target:${BASE_TARGET_CONTEXT}"
      blackbox-exporter = "target:blackbox-exporter-rootfs"
      cadvisor = "target:cadvisor-rootfs"
      grafana = "target:grafana-rootfs"
      loki = "target:loki-rootfs"
      node-exporter = "target:node-exporter-rootfs"
      opentelemetry-collector = "target:opentelemetry-collector-rootfs"
      prometheus = "target:prometheus-rootfs"
      promtail = "target:promtail-rootfs"
      pushgateway = "target:pushgateway-rootfs"
      pyroscope = "target:pyroscope-rootfs"
      tempo = "target:tempo-rootfs"
    }
    args = {}
    tags = [
        // dockerhub("aio", "latest"),
        ghcr("aio", "latest"),
    ]
}

target "aio-exporters" {
    inherits = [ "dockerfile" ]
    context = "aio-exporters"
    contexts = {
      base = "target:${BASE_TARGET_CONTEXT}"
      blackbox-exporter = "target:blackbox-exporter-rootfs"
      cadvisor = "target:cadvisor-rootfs"
      node-exporter = "target:node-exporter-rootfs"
    }
    args = {}
    tags = [
        // dockerhub("aio-exporters", "latest"),
        ghcr("aio-exporters", "latest"),
    ]
}

target "aio-otel-lgmt" {
    inherits = [ "dockerfile" ]
    context = "aio-otel-lgmt"
    contexts = {
      base = "target:${BASE_TARGET_CONTEXT}"
      grafana = "target:grafana-rootfs"
      loki = "target:loki-rootfs"
      opentelemetry-collector = "target:opentelemetry-collector-rootfs"
      prometheus = "target:prometheus-rootfs"
      promtail = "target:promtail-rootfs"
      pyroscope = "target:pyroscope-rootfs"
      tempo = "target:tempo-rootfs"
    }
    args = {}
    tags = [
        // dockerhub("aio-otel-lgmt", "latest"),
        ghcr("aio-otel-lgmt", "latest"),
    ]
}

target "alpine" {
    inherits = [ "dockerfile" ]
    context = "alpine"
    args = {}
    tags = [
        # dockerhub("alpine", "latest"),
        ghcr("alpine", "latest"),
    ]
}

target "images" {
  matrix = {
    "name" = [
      "blackbox-exporter",
      "cadvisor",
      "grafana",
      "loki",
      "node-exporter",
      "opentelemetry-collector",
      "prometheus",
      "promtail",
      "pushgateway",
      "pyroscope",
      "pyroscope-alloy-ebpf",
      "tempo",
    ]
  }
  name = "${name}"
  context = name
  inherits = [ "dockerfile" ]
  contexts = {
    base = "target:${BASE_TARGET_CONTEXT}"
  }
  tags = [
      // dockerhub(name, "latest"),
      ghcr(name, "latest"),
  ]
}

target "rootfs" {
  matrix = {
    "name" = [
      "aio-otel-lgmt",
      "alpine",
      "blackbox-exporter",
      "cadvisor",
      "grafana",
      "loki",
      "node-exporter",
      "opentelemetry-collector",
      "prometheus",
      "promtail",
      "pushgateway",
      "pyroscope",
      "pyroscope-alloy-ebpf",
      "tempo",
    ]
  }
  name = "${name}-rootfs"
  context = name
  target = "rootfs"
  inherits = [ "dockerfile" ]
}
