terraform {
  required_version = ">= 1.3.0"
  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">4.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.3.0"
    }
  }
}

data "azurerm_subscription" "current" {}
