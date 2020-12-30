output "gke_project_id" {
  description = "Name of GKE project"
  value       = module.project.project_id
}

output "gke_endpoint" {
  value = google_container_cluster.primary.endpoint
  // ?
  sensitive = true
}

output "gke_ca_certificate" {
  value     = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
  sensitive = true
}
