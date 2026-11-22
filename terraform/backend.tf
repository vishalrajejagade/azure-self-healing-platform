terraform {

  backend "azurerm" {

    resource_group_name  = "rg-self-healing-demo"

    storage_account_name = "tfstatevishal001"

    container_name       = "tfstate"

    key                  = "prod.terraform.tfstate"
  }
}