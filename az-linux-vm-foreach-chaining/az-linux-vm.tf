resource "azurerm_linux_virtual_machine" "tf_local_linux_vm" {
  for_each              = azurerm_public_ip.tf_local_pip_01
  name                  = "terraform-linux-vm-${each.key}"
  resource_group_name   = azurerm_resource_group.tf_local_rg.name
  location              = azurerm_resource_group.tf_local_rg.location
  size                  = "Standard_B2s"
  admin_username        = "vmadmin"
  network_interface_ids = [azurerm_network_interface.tf_local_nic[each.key].id]
  admin_ssh_key {
    username   = "vmadmin"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    name                 = "osdisk${each.key}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app-scripts/app1-cloud-init.txt")
}