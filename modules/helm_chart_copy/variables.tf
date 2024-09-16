variable "reference_registry" {
  description = "El registro ACR de referencia"
  type        = string
}

variable "instance_registry" {
  description = "El registro ACR de instancia"
  type        = string
}

variable "helm_charts" {
  description = "Lista de charts de Helm a copiar"
  type        = list(string)
}

variable "chart_version" {
  description = "Versión de los charts de Helm a copiar"
  type        = string
}
