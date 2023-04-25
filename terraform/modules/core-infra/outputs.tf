output "primary_vpc_name" {
  value = google_compute_network.primary_vpc.name
}

output "primary_subnet_name" {
  value = google_compute_subnetwork.primary_subnet.name
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary_cluster.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary_cluster.endpoint
  description = "GKE Cluster Host"
}

output "client_certificate" {
  value = google_container_cluster.primary_cluster.master_auth.0.client_certificate
}

output "client_key" {
  value = google_container_cluster.primary_cluster.master_auth.0.client_key
}

output "cluster_ca_certificate" {
  value = google_container_cluster.primary_cluster.master_auth.0.cluster_ca_certificate
}