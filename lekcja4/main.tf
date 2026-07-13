terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

module "nginx_web" {
  source         = "./modules/docker-container"
  container_name = "nginx-web"
  image_name     = "nginx:latest"
  external_port  = 8080
}

module "nginx_backup" {
  source         = "./modules/docker-container"
  container_name = "nginx-backup"
  image_name     = "nginx:latest"
  external_port  = 8081
}
