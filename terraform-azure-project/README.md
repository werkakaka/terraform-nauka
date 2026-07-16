# Terraform Azure Learning Project

Learning project provisioning a small Azure network with a public and
private subnet, NSGs, a NAT Gateway, a Linux VM, and an Azure Container
Registry (ACR) for Docker images.

## Architecture

- **VNet** (`10.0.0.0/16`) containing:
  - **Public subnet** (`10.0.1.0/24`) — hosts a Linux VM reachable via SSH.
  - **Private subnet** (`10.0.2.0/24`) — no direct inbound access from the
    internet; outbound internet access only via a NAT Gateway.
- **NSGs** attached to each subnet, controlling inbound/outbound traffic.
- **NAT Gateway** giving the private subnet outbound-only internet access.
- **Azure Container Registry (ACR)** to store Docker images pulled by the VM.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.7.0
- An Azure subscription
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli),
  logged in via `az login`

## Usage

```bash
# Copy the example variables file and fill in your own values
cp terraform.tfvars.example terraform.tfvars

# Initialize Terraform (downloads the azurerm provider)
terraform init

# Preview what will be created
terraform plan

# Create the infrastructure
terraform apply
```

## File structure

| File | Purpose |
|---|---|
| `versions.tf` | Required Terraform and provider versions |
| `providers.tf` | Provider configuration |
| `variables.tf` | Input variable declarations |
| `locals.tf` | Naming convention and common tags |
| `main.tf` | All Azure resources |
| `outputs.tf` | Values returned after apply |
| `terraform.tfvars.example` | Template for your own `terraform.tfvars` |

## Outputs

- `vm_public_ip` — public IP address to SSH into the VM
- `acr_login_server` — login URL for the Container Registry
- `resource_group_name` — name of the resource group
