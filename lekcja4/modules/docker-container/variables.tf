variable "container_name" {
  description = "Nazwa kontenera Docker"
  type        = string
}

variable "image_name" {
  description = "Obraz Docker do pobrania"
  type        = string
}

variable "external_port" {
  description = "Port na hoście"
  type        = number
}

variable "internal_port" {
  description = "Port wewnątrz kontenera"
  type        = number
  default     = 80
}
