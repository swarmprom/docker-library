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
        "aio-otel-lgmt",
        "ubuntu",
        "images",
    ]
}

variable "BASE_TARGET_CONTEXT" { default = "ubuntu" }
target "aio" {
    inherits = [ "dockerfile" ]
    context = "aio"
    contexts = {
      base = "target:${BASE_TARGET_CONTEXT}"
      alloy = "target:alloy-rootfs"
      # aio-otel-lgmt = "target:aio-otel-lgmt-rootfs"
      # blackbox-exporter = "target:blackbox-exporter-rootfs"
      # docker-collector = "target:docker-collector-rootfs"
      grafana = "target:grafana-rootfs"
      loki = "target:loki-rootfs"
      # node-exporter = "target:node-exporter-rootfs"
      # opentelemetry-collector = "target:opentelemetry-collector-rootfs"
      prometheus = "target:prometheus-rootfs"
      # pushgateway = "target:pushgateway-rootfs"
      pyroscope = "target:pyroscope-rootfs"
      tempo = "target:tempo-rootfs"
    }
    args = {}
    tags = [
        // dockerhub("aio", "latest"),
        ghcr("aio", "latest"),
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

target "ubuntu" {
    inherits = [ "dockerfile" ]
    context = "ubuntu"
    args = {}
    tags = [
        # dockerhub("ubuntu", "latest"),
        ghcr("ubuntu", "latest"),
    ]
}

target "images" {
  matrix = {
    "name" = [
      "alloy",
      "blackbox-exporter",
      "docker-collector",
      "grafana",
      "loki",
      "node-exporter",
      "opentelemetry-collector",
      "prometheus",
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
      "alloy",
      "blackbox-exporter",
      "docker-collector",
      "grafana",
      "loki",
      "node-exporter",
      "opentelemetry-collector",
      "prometheus",
      "pushgateway",
      "pyroscope",
      "pyroscope-alloy-ebpf",
      "tempo",
      "ubuntu",
    ]
  }
  name = "${name}-rootfs"
  context = name
  target = "rootfs"
  inherits = [ "dockerfile" ]
}
