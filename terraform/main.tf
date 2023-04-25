terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.27.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }

  required_version = ">= 0.14"
}

module "core-infra" {
  source        = "./modules/core-infra"
  project_id    = var.project_id
  region        = var.region
  zone          = var.zone
  gke_num_nodes = var.gke_num_nodes
}