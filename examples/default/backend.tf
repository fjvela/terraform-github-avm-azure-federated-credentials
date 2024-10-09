
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.4.0"
    }

    github = {
      source  = "integrations/github"
      version = "6.3.0"
    }
  }
}
module "naming" {
  source = "Azure/naming/azurerm"
}

provider "azurerm" {
  subscription_id = var.azure_subscription_id

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "github" {
  owner = var.github_organization_name
}

data "azurerm_subscription" "current" {}
