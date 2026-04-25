resource "azurerm_resource_group" "tf_local_rg" {
  for_each = toset(["eastus", "eastus2", "westus"])
  name     = "${each.key}-rg"
  location = each.key
}