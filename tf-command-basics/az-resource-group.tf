# Terraform settings block

terraform {
  required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.69.0"
    }
  }
}

# Provider configuration block

provider "azurerm" {
  features {}
}

# Resource configuration block 

resource "azurerm_resource_group" "tf_local_rg" {
  name     = "terraform-rg"
  location = "central india"
}
