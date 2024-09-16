output "acr_id" {
  description = "ID del ACR de instancia"
  value       = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  description = "Servidor de inicio de sesión del ACR de instancia"
  value       = azurerm_container_registry.acr.login_server
}
