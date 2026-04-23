resource "azurerm_resource_group" "tf_local_rg-01" {
  name     = "terraform-rg-01"
  location = "central india"
}

resource "azurerm_resource_group" "tf_local_rg-02" {
  name     = "terraform-rg-02"
  location = "south india"
  provider = azurerm.second-azurerm
}