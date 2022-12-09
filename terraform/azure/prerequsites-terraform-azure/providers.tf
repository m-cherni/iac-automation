terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.34.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true

  tenant_id = xxxxxxx
  subscription_id = xxxxxx
  client_id = xxxxxx
  secret_id = xxxxxx
}