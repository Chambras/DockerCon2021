plugin "azurerm" {
    enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

config {
  disabled_by_default = false
}