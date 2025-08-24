variable "cluster_name" {
  description = "Nome do cluster AKS."
  type        = string
}

variable "location" {
  description = "Região da Azure onde o cluster será criado."
  type        = string
}

variable "resource_group_name" {
  description = "Nome do grupo de recursos para o cluster."
  type        = string
}

variable "dns_prefix" {
  description = "Prefixo DNS para o FQDN do cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "Versão do Kubernetes a ser utilizada."
  type        = string
  default     = "1.29.2"
}

variable "node_count" {
  description = "Número de nós no pool padrão."
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "Tamanho da VM para os nós."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "vnet_subnet_id" {
  description = "ID da sub-rede para integrar o cluster AKS (usando Azure CNI)."
  type        = string
}