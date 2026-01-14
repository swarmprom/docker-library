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
        "aio-exporter-only",
        "blackbox-exporter",
        "cadvisor",
        "grafana",
        "node-exporter",
        "opentelemetry-collector",
        "prometheus",
        "pushgateway"
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
      "blackbox-exporter" = "target:blackbox-exporter"
      "cadvisor" = "target:cadvisor"
      "node-exporter" = "target:node-exporter"
      "pushgateway" = "target:pushgateway"
      "prometheus" = "target:prometheus"
      "grafana" = "target:grafana"
    }
    args = {}
    tags = [
        dockerhub("aio", "latest"),
        ghcr("aio", "latest"),
    ]
}

target "aio-exporter-only" {
    inherits = [ "dockerfile" ]
    context = "aio-exporter-only"
    contexts = {
      "blackbox-exporter" = "target:blackbox-exporter"
      "cadvisor" = "target:cadvisor"
      "node-exporter" = "target:node-exporter"
    }
    args = {}
    tags = [
        dockerhub("aio-exporter-only", "latest"),
        ghcr("aio-exporter-only", "latest"),
    ]
}

target "blackbox-exporter" {
    inherits = [ "dockerfile" ]
    context = "blackbox-exporter"
    contexts = {
      "base" = "target:alpine"
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
      "base" = "target:alpine"
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
      "base" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("grafana", "latest"),
        ghcr("grafana", "latest"),
    ]
}

target "node-exporter" {
    inherits = [ "dockerfile" ]
    context = "node-exporter"
    contexts = {
      "base" = "target:alpine"
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
      "base" = "target:alpine"
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
      "base" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("prometheus", "latest"),
        ghcr("prometheus", "latest"),
    ]
}

target "pushgateway" {
    inherits = [ "dockerfile" ]
    context = "pushgateway"
    contexts = {
      "base" = "target:alpine"
    }
    args = {}
    tags = [
        dockerhub("pushgateway", "latest"),
        ghcr("pushgateway", "latest"),
    ]
}
