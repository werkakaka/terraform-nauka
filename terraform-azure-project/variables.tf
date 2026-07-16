variable "project_name" {
  description = "Short project name (no spaces, lowercase), used as a prefix for the names of all Azure resources such as VNet, NSG, VM (example: 'mojprojekt' -> 'mojprojekt-dev-vnet')"
  type        = string
  default     = "mojprojekt"
}

variable "environment" {
  description = "Deployment environment: dev, staging, or prod. Used in resource naming and tagging."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "location" {
  description = "Azure region where all resources will be created"
  type        = string
  default     = "polandcentral"
}

variable "vnet_address_space" {
  description = "CIDR address space for the whole Virtual Network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_public_prefix" {
  description = "CIDR prefix for the public subnet (resources reachable from the internet, e.g. the VM's NIC with a public IP)"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_private_prefix" {
  description = "CIDR prefix for the private subnet (resources with no direct public IP, outbound internet only via NAT Gateway)"
  type        = string
  default     = "10.0.2.0/24"
}

variable "vm_admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
  default     = "azureadmin"
}

variable "vm_size" {
  description = "Azure VM size (SKU), e.g. Standard_B1s for a cheap dev/test machine"
  type        = string
  default     = "Standard_B1s"
}

variable "vm_admin_password" {
  description = "Admin password for the virtual machine. Must be at least 12 characters, with uppercase, lowercase, digit, and special character."
  type        = string
  sensitive   = true
}
