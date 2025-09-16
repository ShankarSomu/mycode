terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "simplegoservice" {
  name = "registry.gitlab.com/alta3/simplegoservice"
}

resource "docker_container" "simplegoservice_container" {
  name  = var.container_name
  image = docker_image.simplegoservice.name

  ports {
    internal = var.internal_port
    external = var.external_port
  }
}

