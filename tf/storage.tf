resource "google_storage_bucket" "nexus" {
  name          = var.bucket_name
  project       = var.project_id
  location      = var.region
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  force_destroy = false

  labels = local.common_labels

  depends_on = [google_project_service.required["storage.googleapis.com"]]

}
