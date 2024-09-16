locals {
  reference_registry_name = replace(var.reference_registry, ".azurecr.io", "")
  instance_registry_name  = replace(var.instance_registry, ".azurecr.io", "")
}

resource "null_resource" "copy_helm_charts" {
  triggers = {
    always_run = timestamp()
  }

  # Uso local-exec por motivos de tiempo, aunque sé que debería ser la última opción.
  provisioner "local-exec" {
    command = <<EOT
# Autenticarse en ambos registros ACR
az acr login --name ${local.reference_registry_name}
az acr login --name ${local.instance_registry_name}

# Bucle a través de cada chart para copiarlo
for chart in ${join(" ", var.helm_charts)}; do
  echo "Copiando chart $chart"
  helm pull oci://${var.reference_registry}/$chart --version ${var.chart_version}
  helm push $chart-${var.chart_version}.tgz oci://${var.instance_registry}
done
EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
