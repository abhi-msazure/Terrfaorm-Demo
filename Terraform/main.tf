provider "azurerem" {
version = "=2.4.0"
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "Terraform_rg"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "TerraformStorageAccount"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "dev"
  }
}
