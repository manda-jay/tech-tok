terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "ebook-tutorial"
        storage_account_name = "ebooktfstate"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
        #access_key = 
    }

}
provider "azurerm" {
  features {}
}
