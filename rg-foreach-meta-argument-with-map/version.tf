# Terraform configuration block 

terraform {
  required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.69.0"
    }
  }
}

# Providers block 

provider "azurerm" {
  features {}
}