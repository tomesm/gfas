output "primary_vpc_name" {
  value = module.core-infra.primary_vpc_name
}

output "primary_subnet_name" {
  value = module.core-infra.primary_subnet_name
}

output "kubernetes_cluster_name" {
  value       = module.core-infra.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = module.core-infra.kubernetes_cluster_host
  description = "GKE Cluster Host"
}



# output "region" {
#   value       = var.region
#   description = "GCloud Region"
# }

# output "project_id" {
#   value       = var.project_id
#   description = "GCloud Project ID"
# }

# output "kubernetes_cluster_name" {
#   value       = google_container_cluster.primary.name
#   description = "GKE Cluster Name"
# }

# output "kubernetes_cluster_host" {
#   value       = google_container_cluster.primary.endpoint
#   description = "GKE Cluster Host"
# }


# output "tile38_server_external_ip" {
#   description = "External IP address of the tile38-server service"
#   value       = kubernetes_service.tile38_server.load_balancer_ingress[0].ip
# }

# output "tile38_server_external_port" {
#   description = "External port of the tile38-server service"
#   value       = kubernetes_service.tile38_server.spec[0].port[0].port
# }

# output "grafana_service_external_ip" {
#   description = "External IP address of the Grafana service"
#   value       = kubernetes_service.grafana_service.load_balancer_ingress[0].ip
# }

# output "grafana_service_external_port" {
#   description = "External port of the Grafana service"
#   value       = kubernetes_service.grafana_service.spec[0].port[0].port
# }


# output "grafana_ip" {
#   depends_on = [null_resource.output_grafana_ip]
#   value      = "run `kubectl get svc -n monitoring grafana -o jsonpath='{.status.loadBalancer.ingress[0].ip}'` to get the external IP of Grafana service"
# }

# output "tile38_ip" {
#   # depends_on = [null_resource.output_grafana_ip]
#   value      = "run `kubectl get svc tile38-server -o jsonpath='{.status.loadBalancer.ingress[0].ip}'` to get the external IP of Grafana service"
# }





