variable "location" {
  default = "East US"
}

variable "resource_group_name" {
  default = "abdel-resource-group"
}

variable "aks_cluster_name" {
  default = "abdel-aks-cluster"
}

variable "node_count" {
  default = 2
}

variable "vm_size" {
  default = "Standard_DS2_v2"
}