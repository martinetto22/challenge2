variable "aks_cluster_name" {
  description = "Nombre del clúster AKS"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "num_nodes"{
  description = "Número de nodos que queremos en el cluster"
  type        = number
}

variable "vm_size" {
  description = "Tamaño de las máquinas virtuales"
  type        = string
}

variable "name_pool_nodes"{
  description = "Nombre para el pool de nodos"
  type  = string
}