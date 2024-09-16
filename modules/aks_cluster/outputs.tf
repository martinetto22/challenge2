output "kubelet_identity_object_id" {
  description = "Object ID de la identidad del kubelet"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity.object_id
}
