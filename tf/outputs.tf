output "project_id" {
  description = "GCP project containing the Nexus infrastructure"
  value       = var.project_id
}

output "project_number" {
  description = "Numeric GCP project identifier"
  value       = data.google_project.current
}

output "cluster_name" {
  description = "Numeric GCP project identifier"
  value       = google_container_cluster.nexus.name
}

output "cluster_zone" {
  description = "Zone containing the GKE cluster"
  value       = google_container_cluster.nexus.location
}

output "bucket_name" {
  description = "GCS bucket used by nexus"
  value       = google_storage_bucket.nexus.name
}

output "nexus_google_service_account" {
  description = "Google service account used by the nexus pod"
  value       = google_service_account.nexus.email
}

output "nexus_kubernetes_service_account" {
  description = "Kubernetes ServiceAccount authorized through Workload Identity"
  value       = "nexus/nexus"
}

output "get_credentials_command" {
  description = "Command used to add the GKE cluster to the local kubeconfig"
  value = join(" ", [
    "gcloud container clusters get-credentials",
    google_container_cluster.nexus.name,
    "--zone",
    google_container_cluster.nexus.location,
    "--project",
    var.project_id,
  ])
}

output "nexus_workload_identity_annotation" {
  description = "Annotation required on the Nexus Kubernetes ServiceAccount"
  value       = google_service_account.nexus.email
}
