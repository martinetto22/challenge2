# Proyecto Terraform para AKS y ACR en Azure

Este proyecto de Terraform despliega un clúster de Kubernetes (AKS) en Azure y un registro de contenedores privado (ACR). Además, configura los permisos necesarios para que el clúster AKS pueda extraer imágenes del ACR, y copia charts de Helm desde un ACR de referencia a uno de instancia.

### Requisitos Previos
Antes de utilizar esta configuración, asegúrate de tener lo siguiente:
1. Terraform instalado.
2. Azure CLI instalado y autenticado (az login).
3. Sistema operativo Linux o compatible con Bash (el script de copia de charts está escrito en Bash).

### Estructura del Proyecto
El proyecto sigue una estructura modular para mantener el código limpio y organizado. Los módulos principales son:

- **AKS Cluster**: Módulo para crear un clúster de Kubernetes (AKS).
- **ACR Registry**: Módulo para crear un Azure Container Registry (ACR).
- **Helm Chart Copy**: Módulo para copiar charts de Helm entre registros ACR.

### Recursos que se Crean
1. **Grupo de Recursos**: Se crea un grupo de recursos en la ubicación especificada para contener los recursos de AKS y ACR.
2. **AKS Cluster**: Se despliega un clúster de AKS con los parámetros definidos en el módulo aks_cluster.
3. **ACR de Instancia**: Se despliega un registro ACR donde se almacenarán las imágenes y charts de Helm.
4. **Asignación de Rol**: Se asigna el rol AcrPull al clúster AKS para que pueda extraer imágenes del ACR.
5. **Copia de Charts de Helm**: Se copian los charts de Helm desde un ACR de referencia al ACR de instancia.

### Variables
Este proyecto utiliza las siguientes variables:

    subscription_id: ID de la suscripción de Azure.
    resource_group_name: Nombre del grupo de recursos donde se desplegarán los recursos.
    location: Región de Azure donde se desplegarán los recursos.
    aks_cluster_name: Nombre del clúster AKS.
    acr_registry_name: Nombre del registro ACR de instancia.
    reference_registry: URL del ACR de referencia desde donde se copiarán los charts de Helm.
    helm_charts: Lista de charts de Helm a copiar.
    chart_version: Versión de los charts de Helm a copiar.


## Uso
Clona el repositorio y navega al directorio del proyecto.

    git clone <repositorio>
    cd <directorio>

Modifica el fichero terraform.tfvars para adaptarlo a tus variables:

    subscription_id      = "c9e7611c-d508-4-f-aede-0bedfabc1560"
    resource_group_name  = "grupo-de-recursos"
    location             = "introducir-region"
    aks_cluster_name     = "cluster-aks-nombre"
    acr_registry_name    = "instancia-acr-nombre"
    reference_registry   = "reference.azurecr.io"
    helm_charts          = ["chart1", "chart2"]
    chart_version        = "1.0.0"
    num_nodes            = 3
    vm_size              = "Standard_DS2_v2"
    name_pool_nodes      = ""

### Inicializa el proyecto de Terraform:

    terraform init
Revisa el plan de ejecución:

    terraform plan
Aplica la configuración para crear los recursos:

    terraform apply
Confirma la ejecución cuando se te solicite. Después, los charts de Helm se copiarán desde el ACR de referencia al ACR de instancia.


## Módulos

### Módulo aks_cluster
Este módulo se encarga de crear el clúster AKS y asignar la identidad necesaria para acceder al ACR.

#### Parámetros de entrada:

    resource_group_name: Nombre del grupo de recursos.
    aks_cluster_name: Nombre del clúster AKS.
    location: Región donde se desplegará el clúster.

### Módulo acr_registry
Este módulo crea un Azure Container Registry (ACR) donde se almacenarán las imágenes y charts de Helm.

#### Parámetros de entrada:

    resource_group_name: Nombre del grupo de recursos.
    acr_registry_name: Nombre del ACR.
    location: Ubicación del ACR.

### Módulo helm_chart_copy
Este módulo copia los charts de Helm desde un ACR de referencia al ACR de instancia utilizando el CLI de Helm.

#### Parámetros de entrada:

    reference_registry: URL del ACR de referencia.
    instance_registry: URL del ACR de instancia.
    helm_charts: Lista de charts de Helm a copiar.
    chart_version: Versión de los charts.

### Notas
#### Dependencia de CLI:
El script de copia de charts requiere que las herramientas helm y az estén instaladas y configuradas correctamente en el entorno donde se ejecuta Terraform.

#### Falta de pruebas completas:
El código no ha sido probado, por lo que podría generar errores.

#### Limitaciones de local-exec:

- **No idempotente**: Terraform no puede gestionar bien los errores o estados de local-exec, lo que puede generar inconsistencias.
- **Dependencia del entorno**: Requiere un entorno específico con todas las herramientas instaladas, limitando la portabilidad.
- **Difícil de depurar**: Los errores son difíciles de monitorizar, lo que complica la resolución de problemas.
- **Escalabilidad**: Ejecutar localmente puede ser ineficiente para proyectos grandes.
  
### Mejoras a Considerar

- **Almacenamiento del Estado de Terraform**: Actualmente, no se está gestionando adecuadamente el almacenamiento del estado de Terraform. Esto puede causar problemas de consistencia y control del despliegue, especialmente en equipos colaborativos. Sería conveniente almacenar el estado en una solución remota como **Terraform Cloud** o un backend remoto como **Azure Storage**, para asegurar que el estado esté centralizado, accesible y correctamente versionado.

- **Manejo de Errores y Idempotencia**: El uso de `local-exec` introduce limitaciones en cuanto a la idempotencia y manejo de errores. Sería útil explorar alternativas que permitan a Terraform controlar mejor el estado de las operaciones.