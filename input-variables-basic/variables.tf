variable "business_unit" {
  description = "Business unit name"
  type = string
  default = "finance"
}

variable "environment_name" {
  description = "Environment Name"
  type = string
  default = "dev"
}

variable "resoure_group_name" {
  description = "Resource Group Name"
  type = string
  default = "terraform-rg"
}

variable "resoure_group_location" {
  description = "Resource Group Location"
  type = string
  default = "eastus"
}

variable "virtual_network_name" {
  description = "Virtual Network Name"
  type = string 
  default = "terraform-vnet"
}