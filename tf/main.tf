data "google_project" "current" {
  project_id = var.project_id
}

locals {
  name_prefix = "nexus"

  common_labels = {
    application = "nexus"
    managed_by  = "terraform"
  }
}
