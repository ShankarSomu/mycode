# Filename: Main.tf
// Author : Shankar Somasundaram
/* Description: this file has the sample code 
to create the docker */

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:1.19.6"
  keep_locally = true    // keep image after "destroy"
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  network_mode = "bridge"
  name  = "tutorial"
  ports {
    internal = 80
    external = 2224
  }
}

