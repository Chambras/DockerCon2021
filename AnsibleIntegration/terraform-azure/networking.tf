## Use existing subnet
data "azurerm_subnet" "public" {
  name                 = var.publicSubnetName
  virtual_network_name = var.mainVNetName
  resource_group_name  = data.azurerm_resource_group.mainRG.name
}
