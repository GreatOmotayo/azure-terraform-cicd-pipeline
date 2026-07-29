terraform {
    required_version = ">= 1.5.0"

    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.90"
        }

        random = {
            source  = "hashicorp/random"
            version = "~> 3.6"
        }
    }

    # Configure the AzureRM backend to store the Terraform state remotely,
    # enabling secure, centralized state management and team collaboration.
    backend "azurerm" {}
}

# Configure the Azure Resource Manager (AzureRM) provider to manage Azure resources.
provider "azurerm" {
    use_oidc = true
    features {}
}# trigger test
