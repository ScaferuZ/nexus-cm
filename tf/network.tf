resource "google_compute_network" "nexus" {
  name                    = "${local.name_prefix}-vpc"
  auto_create_subnetworks = false

  depends_on = [google_project_service.required["compute.googleapis.com"]]
}

resource "google_compute_subnetwork" "nexus" {
  name          = "${local.name_prefix}-subnet"
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.nexus.id
  region        = var.region

  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = "10.20.0.0/16"
  }

  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = "10.30.0.0/20"
  }
}
