# Provider configuration
# AWS provider configuration
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "aws_key_administrators" {
  description = "AWS IAM role ARNs that can administer the KMS key"
  type        = string
  default     = "arn:aws:iam::012345678901:role/admin"
}

# Cluster configuration
variable "default_tags" {
  type = map(string)
  default = {
    "managed-by" = "terraform"
    "owner"      = "kevlar"
    "env"        = "dev"
  }
}

variable "cluster_name" {
  type    = string
  default = "kevlar"
}

variable "cluster_instance_type" {
  description = "AWS instance type for cluster nodes"
  type        = string
  default     = "t3.medium"
}

variable "min_cluster_size" {
  type    = number
  default = 1
}

variable "max_cluster_size" {
  type    = number
  default = 5
}

variable "desired_cluster_size" {
  type    = number
  default = 2
}

# Kubernetes provider configuration
variable "kubernetes_namespace" {
  type = string
}

# Vault configuration
variable "vault_kms_key_id" {
  type = string
}

variable "vault_kms_key_region" {
  type = string
}

variable "labels" {
  type    = string
  default = null
}

variable "annotations" {
  type    = map(string)
  default = null
}

variable "vault_cluster_name" {
  type = string
}

variable "vault_cluster_size" {
  type = number
}

variable "vault_cluster_annotations" {
  type = map(string)
}

variable "vault_image" {
  type = string
}

variable "vault_ingress_annotations" {
  type    = map(string)
  default = {}
}

variable "vault_ingress_hostname" {
  type = string
}

variable "vault_ingress_class_name" {
  type = string
}

variable "vault_storage_size" {
  type = string
}

variable "vault_storage_class" {
  type = string
}

variable "vault_log_level" {
  type = string
}

variable "vault_external_config" {
  type = any
}
