terraform {
  backend "remote" {
    organization = "zambrana"

    workspaces {
      name = "DockerCon2021-Terraform"
    }
  }
  required_version = "= 0.15.3"
  required_providers {
    azurerm = "=2.57.0"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mainRGName" {
  name     = "${var.suffix}${var.mainRGName}"
  location = var.location
  tags     = var.tags
}
