resource "azurerm_resource_group" "tf_local_rg" {
  name     = "terraform-rg-${count.index}"
  location = "central india"
  count = 3
}