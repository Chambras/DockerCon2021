resource "azurerm_storage_account" "mainSA" {
  name                     = lower("${var.suffix}${var.storageAccountName}")
  resource_group_name      = azurerm_resource_group.mainRGName.name
  location                 = azurerm_resource_group.mainRGName.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = var.tags
}
