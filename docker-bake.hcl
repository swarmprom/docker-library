variable "DOCKERHUB" { default = "docker.io" }
variable "GHCR" { default = "ghcr.io" }

variable "GITHUB_REPOSITORY_OWNER" {
  default = "swarmprom"
}

// library/ubuntu
variable "UBUNTU_VERSION" {default = "noble" }
// socheatsok78/s6-overlay
variable "S6_VERSION" { default = "v3.2.3.2" }

// 
variable "ALLOY_VERSION" { default = "1.17.1" }
variable "GRAFANA_VERSION" { default = "12.3" }
variable "LOKI_VERSION" { default = "3.6.3" }
variable "PROMETHEUS_VERSION" { default = "3.9.1" }
variable "PYROSCOPE_VERSION" { default = "1.17.1" }
variable "TEMPO_VERSION" { default = "2.9.0" }
variable "version_map" {
  default = {
    "alloy" = ALLOY_VERSION
    "grafana" = GRAFANA_VERSION
    "loki" = LOKI_VERSION
    "prometheus" = PROMETHEUS_VERSION
    "pyroscope" = PYROSCOPE_VERSION
    "tempo" = TEMPO_VERSION
  }
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
      S6_VERSION = S6_VERSION
    }
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
}

group "default" {
  targets = [
        "ubuntu",
        "images",
    ]
}

variable "BASE_TARGET_CONTEXT" { default = "ubuntu" }

target "ubuntu" {
    inherits = [ "dockerfile" ]
    context = "ubuntu"
    args = {
      UBUNTU_VERSION = UBUNTU_VERSION
    }
    tags = [
        dockerhub("ubuntu", UBUNTU_VERSION),
        ghcr("ubuntu", UBUNTU_VERSION),
    ]
}

target "images" {
  matrix = {
    "name" = [
      "alloy",
      "grafana",
      "loki",
      "prometheus",
      "pyroscope",
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
      dockerhub(name, version_map[name]),
      ghcr(name, version_map[name]),
  ]
}

target "rootfs" {
  matrix = {
    "name" = [
      "alloy",
      "grafana",
      "loki",
      "prometheus",
      "pyroscope",
      "tempo",
      "ubuntu",
    ]
  }
  name = "${name}-rootfs"
  context = name
  target = "rootfs"
  inherits = [ "dockerfile" ]
}
