resource "azurerm_container_registry" "acr" {
  name                = var.acr_registry_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true
}