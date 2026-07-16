output "vm_public_ip" {
  description = "Public IP address of the VM - use this to SSH into it"
  value       = azurerm_public_ip.vm.ip_address
}

output "acr_login_server" {
  description = "Login server URL of the Azure Container Registry"
  value       = azurerm_container_registry.main.login_server
}

output "resource_group_name" {
  description = "Name of the resource group containing all resources"
  value       = azurerm_resource_group.main.name
}
