resource "azurerm_virtual_network" "tf_local_vnet" {
  name                = "${var.business_unit}-${var.environment_name}-vnet"
  resource_group_name = azurerm_resource_group.tf_local_rg.name
  location            = azurerm_resource_group.tf_local_rg.location
  address_space       = ["10.0.0.0/16"]
  tags = {
    "environment" = "test"
    "testing_tag" = "test"
  }
}


