resource "azurerm_virtual_network" "tf_local_vnet" {
  name                = "terraform-vnet"
  resource_group_name = azurerm_resource_group.tf_local_rg.name
  location            = azurerm_resource_group.tf_local_rg.location
  address_space       = ["10.0.0.0/16"]
  tags = {
    "environment" = "test"
    "testing_tag" = "test"
  }
}

resource "azurerm_subnet" "tf_local_subnet-01" {
  name                 = "subnet-01"
  resource_group_name  = azurerm_resource_group.tf_local_rg.name
  virtual_network_name = azurerm_virtual_network.tf_local_vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "tf_local_pip_01" {
  depends_on          = [azurerm_virtual_network.tf_local_vnet, azurerm_subnet.tf_local_subnet-01]
  name                = "terraform-pip-01"
  resource_group_name = azurerm_resource_group.tf_local_rg.name
  location            = azurerm_resource_group.tf_local_rg.location
  allocation_method   = "Static"
  domain_name_label   = "app-vm-01-${random_string.tf_local_random.id}"
}

resource "azurerm_network_interface" "tf_local_nic" {
  name                = "terraform-nic-01"
  resource_group_name = azurerm_resource_group.tf_local_rg.name
  location            = azurerm_resource_group.tf_local_rg.location

  ip_configuration {
    name                          = "terraform-nic-01-ip-config"
    subnet_id                     = azurerm_subnet.tf_local_subnet-01.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.4"
    public_ip_address_id          = azurerm_public_ip.tf_local_pip_01.id
  }

}

resource "azurerm_network_security_group" "tf_local_nsg_01" {
  name                = "terraform-vm-nsg-01"
  resource_group_name = azurerm_resource_group.tf_local_rg.name
  location            = azurerm_resource_group.tf_local_rg.location
  security_rule {
    name                       = "allowall"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "tf_local_nsg_association" {
  network_interface_id      = azurerm_network_interface.tf_local_nic.id
  network_security_group_id = azurerm_network_security_group.tf_local_nsg_01.id
}