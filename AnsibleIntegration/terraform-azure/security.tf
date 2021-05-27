resource "azurerm_network_security_group" "genericNSG" {
  name                = "${var.suffix}-${var.sgName}"
  location            = data.azurerm_resource_group.mainRG.location
  resource_group_name = data.azurerm_resource_group.mainRG.name

  security_rule {
    name                       = "SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = var.sourceIPs
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  tags = var.tags
}
