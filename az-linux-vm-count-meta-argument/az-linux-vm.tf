resource "azurerm_linux_virtual_machine" "tf_local_linux_vm" {
  count = 2
  name                  = "terraform-linux-vm-${count.index}"
  resource_group_name   = azurerm_resource_group.tf_local_rg.name
  location              = azurerm_resource_group.tf_local_rg.location
  size                  = "Standard_B2s"
  admin_username        = "vmadmin"
  network_interface_ids = [element(azurerm_network_interface.tf_local_nic[*].id, count.index)]
  admin_ssh_key {
    username   = "vmadmin"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    name                 = "osdisk${count.index}"
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