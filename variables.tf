variable "subscription_id" {
  description = "ID de suscripción de Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "aks_cluster_name" {
  description = "Nombre del clúster AKS"
  type        = string
}

variable "acr_registry_name" {
  description = "Nombre del ACR de instancia"
  type        = string
}

variable "reference_registry" {
  description = "URL del ACR de referencia"
  type        = string
}

variable "helm_charts" {
  description = "Lista de charts de Helm a copiar"
  type        = list(string)
}

variable "chart_version" {
  description = "Versión de los charts de Helm"
  type        = string
}

variable "num_nodes"{
  description = "Número de nodos en el cluster"
  type        = number
}

variable "vm_size"{
  description = "Tamaño de las máquinas virtuales"
  type        = string
}

variable "name_pool_nodes"{
  description = "Nombre pool de nodos"
  type        = string
}

variable "organization_name"{
  description = "Nombre de la organización (Terraform Cloud)"
  type = string
}

variable "workspace_name"{
  description = "Nombre del Workspace (Terraform Cloud)"
  type = string
}