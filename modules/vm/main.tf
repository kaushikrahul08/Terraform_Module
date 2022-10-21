provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "vnetrg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
    name                = "${var.vnet_name}"
    location            = var.location
    resource_group_name = azurerm_resource_group.vnetrg.name
    address_space       = ["${var.address_space}"]
    tags = var.tags
}

resource "azurerm_subnet" "subnet" {
    #for_each             = var.subnets
    name                 = var.subnet_name
    resource_group_name  = azurerm_resource_group.vnetrg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["${var.address_prefixes}"]
}

resource "azurerm_network_interface" "net_int" {
  #for_each            = var.location
  name                = var.nic_name
  location            = azurerm_resource_group.vnetrg.location
  resource_group_name = azurerm_resource_group.vnetrg.name

  ip_configuration {
    name                          = "configuration1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.example.id
  }
}


resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  resource_group_name   = azurerm_resource_group.vnetrg.name
  location              = azurerm_resource_group.vnetrg.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.net_int.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }

  os_disk {
    caching              = var.disk_caching
    storage_account_type = var.sa_type
  }

  source_image_reference {
    publisher = var.src_img_pub
    offer     = var.src_img_offer
    sku       = var.src_img_sku
    version   = var.src_img_ver
  }

  tags = var.tags
}