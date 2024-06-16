variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster will be deployed."
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for the EKS worker nodes."
  type        = list(string)
}

variable "control_plane_subnet_ids" {
  description = "Subnets for the EKS control plane."
  type        = list(string)
}

variable "cluster_endpoint_public_access" {
  description = "Whether to enable public access to the EKS cluster endpoint."
  type        = bool
  default     = true
}

variable "cluster_addons" {
  description = "Cluster addon configurations."
  type        = any
  default     = {}
}

variable "eks_managed_node_group_defaults" {
  description = "Default configurations for EKS managed node groups."
  type        = any
  default     = {}
}

variable "eks_managed_node_groups" {
  description = "Managed node groups configurations."
  type        = any
  default     = {}
}

variable "enable_cluster_creator_admin_permissions" {
  description = "Whether to grant cluster creator admin permissions."
  type        = bool
  default     = false
}

variable "access_entries" {
  description = "Access entries for the EKS cluster."
  type        = any
  default     = {}
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}
