data "azurerm_storage_account" "mainSA" {
  name                = var.mainSA
  resource_group_name = data.azurerm_resource_group.mainRG.name
}
