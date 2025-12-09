terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }

}
provider "azurerm" {
  features {}

  subscription_id = "249a05f7-c643-4c2a-a2b0-0c1dc39022b7"
}
