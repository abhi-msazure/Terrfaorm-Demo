terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfdemo" {
  name     = "tfdemo"
  location = "West US"
}

resource "azurerm_storage_account" "tfdemosa" {
  name                     = "tfdemosa${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.tfdemo.name
  location                 = azurerm_resource_group.tfdemo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = false

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_container" "tfdemoscon" {
  name                  = "tfdemoscon"
  storage_account_name  = azurerm_storage_account.tfdemosa.name
  container_access_type = "private"
}
