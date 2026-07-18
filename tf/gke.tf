resource "google_container_cluster" "nexus" {
  project  = var.project_id
  name     = var.cluster_name
  location = var.zone

  network    = google_compute_network.nexus.id
  subnetwork = google_compute_subnetwork.nexus.id

  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  release_channel {
    channel = "REGULAR"
  }

  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false

  resource_labels = local.common_labels

  depends_on = [google_project_service.required["container.googleapis.com"]]

}

resource "google_container_node_pool" "nexus" {
  project    = var.project_id
  name       = "nexus-pool"
  location   = var.zone
  cluster    = google_container_cluster.nexus.name
  node_count = var.node_count

  node_config {
    machine_type = var.node_machine_type
    preemptible  = var.preemptible_nodes

    disk_type    = "pd-balanced"
    disk_size_gb = 30

    service_account = google_service_account.gke_nodes.email

    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform", ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    labels = local.common_labels

    metadata = { disable-legacy-endpoints = "true" }

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  depends_on = [google_project_iam_member.gke_node_default]
}
