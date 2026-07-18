resource "google_service_account" "gke_nodes" {
  project      = var.project_id
  account_id   = "nexus-gke-nodes"
  display_name = "Nexus GKE node service account"

  depends_on = [google_project_service.required["iam.googleapis.com"]]
}

resource "google_project_iam_member" "gke_node_default" {
  project = var.project_id
  role    = "roles/container.defaultNodeServiceAccount"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_service_account" "nexus" {
  project      = var.project_id
  account_id   = "nexus-gcs"
  display_name = "Nexus GCS service account"

  depends_on = [google_project_service.required["iam.googleapis.com"]]
}

resource "google_storage_bucket_iam_memebr" "nexus_storage_admin" {
  bucket = google_storage_bucket.nexus.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.nexus.email}"
}

resource "google_service_account_iam_member" "nexus_workload_identity" {
  service_account_id = google_service_account.nexus.name
  role               = "roles/iam.workloadIdentityUser"

  member = "serviceAccount:${var.project_id}.svc.id.goog[nexus/nexus]"
}
