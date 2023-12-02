terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.5.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version= ">=2.1.0"
    }

  }
}

provider "azurerm" {
  features {}
}

porvider "helm" {
    kubernetes { config_path = "../.kube/config" }
}

