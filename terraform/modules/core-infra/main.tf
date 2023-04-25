variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "region" {
  description = "Your region"
  type        = string
}

variable "zone" {
  description = "Your zone"
  type        = string
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.27.0"
    }
  }

  required_version = ">= 0.14"
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# VPC
resource "google_compute_network" "primary_vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "primary_subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.primary_vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

# GKE cluster
resource "google_container_cluster" "primary_cluster" {
  name     = "${var.project_id}-gke"
  location = var.zone

  #   enable_autopilot = true

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.primary_vpc.name
  subnetwork = google_compute_subnetwork.primary_subnet.name

}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary_cluster.name
  location   = var.zone
  cluster    = google_container_cluster.primary_cluster.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = "e2-small"
    disk_size_gb = 10
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

provider "kubernetes" {
  load_config_file = "false"

  host     = google_container_cluster.primary_cluster.endpoint
  username = var.gke_username
  password = var.gke_password

  client_certificate     = google_container_cluster.primary_cluster.master_auth.0.client_certificate
  client_key             = google_container_cluster.primary_cluster.master_auth.0.client_key
  cluster_ca_certificate = google_container_cluster.primary_cluster.master_auth.0.cluster_ca_certificate
}



