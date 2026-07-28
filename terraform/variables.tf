variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "azure-cicd-terraform-pipeline"
}


variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "centralus"
}


variable "environment" {
  description = "The environment for the deployment (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "app_service_sku" {
    description = "The SKU for the Azure App Service Plan."
    type        = string
    default     = "B1"
}

variable "image_tag" {
    description = "The tag of the Docker image to be deployed - passed in by the pipeline as the Git commit SHA"
    type        = string
    default     = "latest"
}