terraform {
  backend "remote" {
    organization = "zambrana"

    workspaces {
      name = "DockerCon2021-Terraform2"
    }
  }
  required_version = "= 0.15.4"
  required_providers {
    azurerm = "=2.60.0"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "mainRG" {
  name = var.mainRGName
}

resource "azurerm_resource_group" "devVMRG" {
  name     = "${var.suffix}${var.devVMRGName}"
  location = var.location
  tags     = var.tags
}
