terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

locals {
  containers = {
    "ironman" = {
      internal_port = 9876
      external_port = 5432
    },
    "captain_america" = {
      internal_port = 8888
      external_port = 4444
    }
  }
}


resource "docker_image" "simplegoservice" {
  name = "registry.gitlab.com/alta3/simplegoservice"
}


resource "docker_container" "simplegoservice_container" {
  for_each = local.containers
  name  = each.key
  image = docker_image.simplegoservice.name

  ports {
    internal = each.value.internal_port
    external = each.value.external_port
  }
}

output "container_names" {
  value = [for c in docker_container.simplegoservice_container : c.name]
}

