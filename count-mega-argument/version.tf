# Terraform configuration block 

terraform {
  required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.69.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.8.1"
    }
  }
}

# Providers block 

provider "azurerm" {
  features {}
}

resource "random_string" "tf_local_random" {
  length  = 6
  special = false
  upper   = false
  numeric = true
}