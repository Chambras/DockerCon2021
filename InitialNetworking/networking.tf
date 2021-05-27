## Create Network
resource "azurerm_virtual_network" "genericVNet" {
  name                = "${var.suffix}${var.vnetName}"
  location            = azurerm_resource_group.mainRGName.location
  resource_group_name = azurerm_resource_group.mainRGName.name
  address_space       = [local.base_cidr_block]

  tags = var.tags
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.mainRGName.name
  virtual_network_name = azurerm_virtual_network.genericVNet.name
  address_prefixes     = ["10.70.2.0/24"]
}
