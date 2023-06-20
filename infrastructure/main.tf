# create an EKS cluster
module "cluster" {
  source = "./modules/cluster"

  region = var.aws_region

  cluster_name          = var.cluster_name
  cluster_instance_type = var.cluster_instance_type

  min_cluster_size     = var.min_cluster_size
  max_cluster_size     = var.max_cluster_size
  desired_cluster_size = var.desired_cluster_size

  aws_key_administrators = var.aws_key_administrators

  default_tags = var.default_tags
}

# Configure Kubernetes provider
provider "kubernetes" {
  host                   = module.cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.cluster.cluster_ca_cert)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.cluster.cluster_name]
    command     = "aws"
  }
}

# Configure Helm provider
provider "helm" {
  kubernetes {
    host                   = module.cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(module.cluster.cluster_ca_cert)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.cluster.cluster_name]
      command     = "aws"
    }
  }
}

# Create a load balancer controller for the cluster
module "lb" {
  source = "./modules/lb"

  # Kubernetes
  kubernetes_namespace = var.kubernetes_namespace

  # EKS
  cluster_name = module.cluster.cluster_name
  oidc_provider_arn = module.cluster.oidc_provider_arn

  # Networking
  vpc_id = module.cluster.vpc_id

  # Labels
  labels      = { "app" = var.labels }
  annotations = var.default_tags
}

# Deploy Vault to the cluster
# module "vault" {
#   source = "./modules/vault"

#   # Kubernetes
#   kubernetes_namespace        = var.kubernetes_namespace
#   kubernetes_service_account  = var.kubernetes_service_account

#   # KMS
#   vault_kms_key_id      = module.cluster.kms_key_id
#   vault_kms_key_region  = module.cluster.region

#   # if you want to enable s3 storage
#   # vaults_oss_bucket      = var.vault_oss_bucket
#   # vaults_oss_endpoint    = var.vault_oss_endpoint
#   # vaults_oss_prefix      = var.labels

#   labels      = { "app" = var.labels }
#   annotations = var.default_tags

#   vault_cluster_name        = module.cluster.cluster_name # todo does this mean the pods?
#   vault_cluster_size        = var.vault_cluster_size
#   vault_cluster_annotations = var.vault_cluster_annotations
#   vault_image               = var.vault_image
#   vault_ingress_hostname    = var.vault_ingress_hostname
#   vault_ingress_class_name  = var.vault_ingress_class_name
#   vault_ingress_annotations = var.vault_ingress_annotations
#   vault_log_level           = var.vault_log_level
#   vault_storage_size        = var.vault_storage_size
#   vault_storage_class       = var.vault_storage_class
#   vault_external_config     = var.vault_external_config

#   depends_on = [module.cluster]
# }
