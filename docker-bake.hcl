variable "GITHUB_REPOSITORY_OWNER" {
  default = "swarmlibs"
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
        "tempo",
    ]
}

target "alpine" {
    inherits = [ "dockerfile" ]
    context = "alpine"
    args = {}
    tags = [
        dockerhub("alpine", "latest"),
        ghcr("alpine", "latest"),
    ]
}

target "aio" {
    inherits = [ "dockerfile" ]
    context = "aio"
    contexts = {
      "aio-exporters" = "target:aio-exporters"
      "aio-otel-lgmt" = "target:aio-otel-lgmt"
      "pushgateway" = "target:pushgateway"
    }
    args = {}
    tags = [
        dockerhub("aio", "latest"),
        ghcr("aio", "latest"),
    ]
}

target "aio-exporters" {
    inherits = [ "dockerfile" ]
    context = "aio-exporters"
    contexts = {
      "blackbox-exporter" = "target:blackbox-exporter"
      "cadvisor" = "target:cadvisor"
      "node-exporter" = "target:node-exporter"
    }
    args = {}
    tags = [
        dockerhub("aio-exporters", "latest"),
        ghcr("aio-exporters", "latest"),
    ]
}

target "aio-otel-lgmt" {
    inherits = [ "dockerfile" ]
    context = "aio-otel-lgmt"
    contexts = {
      "grafana" = "target:grafana"
      "loki" = "target:loki"
      "opentelemetry-collector" = "target:opentelemetry-collector"
      "prometheus" = "target:prometheus"
      "promtail" = "target:promtail"
      "pyroscope" = "target:pyroscope"
      "tempo" = "target:tempo"
    }
    args = {}
    tags = [
        dockerhub("aio-otel-lgmt", "latest"),
        ghcr("aio-otel-lgmt", "latest"),
    ]
}

target "blackbox-exporter" {
    inherits = [ "dockerfile" ]
    context = "blackbox-exporter"
    contexts = {
      "alpine" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("blackbox-exporter", "latest"),
        ghcr("blackbox-exporter", "latest"),
    ]
}

target "cadvisor" {
    inherits = [ "dockerfile" ]
    context = "cadvisor"
    contexts = {
      "alpine" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("cadvisor", "latest"),
        ghcr("cadvisor", "latest"),
    ]
}

target "grafana" {
    inherits = [ "dockerfile" ]
    context = "grafana"
    contexts = {
      "alpine" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("grafana", "latest"),
        ghcr("grafana", "latest"),
    ]
}

target "loki" {
    inherits = [ "dockerfile" ]
    context = "loki"
    contexts = {
      "alpine" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("loki", "latest"),
        ghcr("loki", "latest"),
    ]
}

target "node-exporter" {
    inherits = [ "dockerfile" ]
    context = "node-exporter"
    contexts = {
      "alpine" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("node-exporter", "latest"),
        ghcr("node-exporter", "latest"),
    ]
}

target "opentelemetry-collector" {
    inherits = [ "dockerfile" ]
    context = "opentelemetry-collector"
    contexts = {
      "alpine" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("opentelemetry-collector", "latest"),
        ghcr("opentelemetry-collector", "latest"),
    ]
}

target "prometheus" {
    inherits = [ "dockerfile" ]
    context = "prometheus"
    contexts = {
      "alpine" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("prometheus", "latest"),
        ghcr("prometheus", "latest"),
    ]
}

target "promtail" {
    inherits = [ "dockerfile" ]
    context = "promtail"
    contexts = {
      "alpine" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("promtail", "latest"),
        ghcr("promtail", "latest"),
    ]
}

target "pushgateway" {
    inherits = [ "dockerfile" ]
    context = "pushgateway"
    contexts = {
      "alpine" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("pushgateway", "latest"),
        ghcr("pushgateway", "latest"),
    ]
}

target "pyroscope" {
    inherits = [ "dockerfile" ]
    context = "pyroscope"
    contexts = {
      "alpine" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("pyroscope", "latest"),
        ghcr("pyroscope", "latest"),
    ]
}

target "pyroscope-alloy-ebpf" {
    inherits = [ "dockerfile" ]
    context = "pyroscope-alloy-ebpf"
    contexts = {
      "alpine" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("pyroscope-alloy-ebpf", "latest"),
        ghcr("pyroscope-alloy-ebpf", "latest"),
    ]
}

target "tempo" {
    inherits = [ "dockerfile" ]
    context = "tempo"
    contexts = {
      "alpine" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("tempo", "latest"),
        ghcr("tempo", "latest"),
    ]
}
