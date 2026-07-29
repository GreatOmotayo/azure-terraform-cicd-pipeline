# This Terraform configuration file defines the main infrastructure resources for the project.
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location

  # tags for project identification, environment tracking, and Terraform management.
  tags = {
    Project     = var.project_name
    Environment = var.environment
    managed_by  = "Terraform"
  }
}

# App Service - the compute resources that hosts the app
resource "azurerm_service_plan" "main" {
    name                = "asp-${var.project_name}-${var.environment}"
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
    os_type             = "Linux"
    sku_name            = var.app_service_sku
}

#Azure Container Registry (ACR) - a private registry for storing and managing container images.
resource "azurerm_container_registry" "main" {
    name                     = "acr${replace(var.project_name, "-", "")}${var.environment}${random_string.suffix.result}"
    resource_group_name      = azurerm_resource_group.main.name
    location                 = azurerm_resource_group.main.location
    sku                      = "Basic"
    admin_enabled            = false  

    tags = {
        environment = var.environment
        project     = var.project_name  
        managed_by  = "Terraform"
    }   
}

# Create an Azure Linux App Service for application hosting.
resource "azurerm_linux_web_app" "main" {
    name                = "app-${var.project_name}-${var.environment}-${random_string.suffix.result}"
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
    service_plan_id     = azurerm_service_plan.main.id

    identity {
        type = "SystemAssigned"
    }

    site_config {
        always_on = true
        container_registry_use_managed_identity = true

        # application_stack {
        #     docker_registry_url = "https://${azurerm_container_registry.main.login_server}"
        #     docker_image_name = "cicd-demo-app"
        #     docker_image_tag  = var.image_tag
        # }

        application_stack {
            docker_image     = "${azurerm_container_registry.main.login_server}/cicd-demo-app"
            docker_image_tag = var.image_tag
        }
    }

    app_settings = {
        WEBSITES_PORT = "8080"
    }

    tags = {
        environment = var.environment
        project     = var.project_name  
        managed_by  = "Terraform"
    }
}

# Grants the App Service access to the ACR, allowing it to pull container images securely.
resource "azurerm_role_assignment" "acr_pull" {
    scope                = azurerm_container_registry.main.id
    role_definition_name = "AcrPull"
    principal_id         = azurerm_linux_web_app.main.identity[0].principal_id
}


# Random string resource to generate a unique suffix for the web app name, ensuring uniqueness across deployments.
resource "random_string" "suffix" {
    length  = 6
    special = false
    upper   = false
}
# trigger test
# trigger test
# trigger debug run
# trigger debug run
