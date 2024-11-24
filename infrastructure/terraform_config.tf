terraform {
  backend "local" {
    path = "./.tfstate/terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    # not needed but we discuss with other teams and we checked the previous repo of week-3 and 
    # we thought it was good to have this for later if we have to add features
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