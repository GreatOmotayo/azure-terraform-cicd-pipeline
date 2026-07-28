# Define output values to display important information about the deployed resources.
# Outputs can be used for reference, automation, and integration with other systems.
output "resource_group_name" {
  description = "The name of the Azure Resource Group created."
  value       = azurerm_resource_group.main.name
}

output "app_service_plan_name" {
  description = "The name of the Azure App Service Plan created."
  value       = azurerm_service_plan.main.name
}

output "app_service_default_hostname" {
  description = "The default hostname of the Azure Linux Web App created."
  value       = azurerm_linux_web_app.main.default_hostname
}

output "app_service_plan_sku" {
    description = "The SKU of the Azure App Service Plan created."
    value       = azurerm_service_plan.main.sku_name
}

output "acr_login_server" {
    description = "The login server of the Azure Container Registry created."
    value       = azurerm_container_registry.main.login_server
}

output "acr" {
    description = "The name of the Azure Container Registry created."
    value       = azurerm_container_registry.main.name
}

# trigger test
