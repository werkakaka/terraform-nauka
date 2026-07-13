output "container_url" {
  description = "Adres pod którym dostępny jest kontener"
  value       = "http://localhost:${var.external_port}"
}

output "container_id" {
  description = "ID utworzonego kontenera"
  value       = docker_container.moj_nginx.id
}
