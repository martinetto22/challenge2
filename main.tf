terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.x"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = module.acr_registry.acr_id
  role_definition_name = "AcrPull"
  principal_id         = module.aks_cluster.kubelet_identity_object_id

  depends_on = [
    module.acr_registry,
    module.aks_cluster
  ]
}

module "aks_cluster" {
  source = "./modules/aks_cluster"

  resource_group_name = azurerm_resource_group.rg.name
  aks_cluster_name    = var.aks_cluster_name
  location            = var.location
  num_nodes           = var.num_nodes
  vm_size             = var.vm_size
  name_pool_nodes     = var.name_pool_nodes
}

module "acr_registry" {
  source = "./modules/acr_registry"

  resource_group_name = azurerm_resource_group.rg.name
  acr_registry_name   = var.acr_registry_name
  location            = var.location
}

module "helm_chart_copy" {
  source = "./modules/helm_chart_copy"

  reference_registry = var.reference_registry
  instance_registry  = module.acr_registry.acr_login_server
  helm_charts        = var.helm_charts
  chart_version      = var.chart_version
}
