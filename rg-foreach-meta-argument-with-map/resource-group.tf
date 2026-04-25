resource "azurerm_resource_group" "tf_local_rg" {
  for_each = {
    dc1app  = "eastus"
    dc2app  = "eastus2"
    dc3app  = "westus"
  }
  name     = "${each.key}-rg"
  location = "${each.value}"
}