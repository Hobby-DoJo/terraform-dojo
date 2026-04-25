resource "azurerm_resource_group" "tf_local_rg" {
  name     = "${var.business_unit}-${var.environment_name}-${var.resoure_group_name}"
  location = var.resoure_group_location
}