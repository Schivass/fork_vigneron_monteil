terraform {
  backend "local" {
    path = "./.tfstate/terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }

    github = {
      source  = "integrations/github"
      version = "~> 6.3"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}