variable "container_name" {
  description = "Nazwa kontenera Docker"
  type        = string
  default     = "moj-nginx-terraform"
}

variable "external_port" {
  description = "Port na hoście, przez który wystawiamy kontener"
  type        = number
  default     = 8080
}

variable "image_name" {
  description = "Obraz Docker do pobrania"
  type        = string
  default     = "nginx:latest"
}
