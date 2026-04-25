resource "azurerm_virtual_network" "tf_local_vnet" {
/*   lifecycle {
  prevent_destroy = true
  } */
  name                = "terraform-vnet-lifecycle"
  resource_group_name = azurerm_resource_group.tf_local_rg.name
  location            = azurerm_resource_group.tf_local_rg.location
  address_space       = ["10.0.0.0/16"]
  tags = {
    "environment" = "test"
    "testing_tag" = "test"
  }
}

resource "azurerm_subnet" "tf_local_subnet-01" {
    lifecycle {
    create_before_destroy = true
  }
  name                 = "subnet-01"
  resource_group_name  = azurerm_resource_group.tf_local_rg.name
  virtual_network_name = azurerm_virtual_network.tf_local_vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "tf_local_pip_01" {
    lifecycle {
    create_before_destroy = true
  }
  name                = "terraform-pip-01"
  resource_group_name = azurerm_resource_group.tf_local_rg.name
  location            = azurerm_resource_group.tf_local_rg.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "tf_local_nic" {
    lifecycle {
    create_before_destroy = true
  }
  name                = "terraform-nic-02"
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
