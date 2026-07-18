variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "region" {
  description = "GCP region for regional resources"
  type        = string
  default     = "asia-southeast1"
}

variable "zone" {
  description = "GCP zone for the zonal GKE cluster"
  type        = string
  default     = "asia-southeast1-b"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "nexus-gke"
}

variable "bucket_name" {
  description = "Nexus artifact bucket"
  type        = string
}

variable "node_machine_type" {
  description = "Machine type used by the nexus node pool"
  type        = string
  default     = "n1-standard-1"
}

variable "node_count" {
  description = "number of nodes"
  type        = number
  default     = 1

  validation {
    condition     = var.node_count >= 1
    error_message = "the node count must be at least one"
  }
}

variable "preemptible_nodes" {
  description = "Whether the GKE node pool use preemptible VMs or not"
  type        = bool
  default     = true
}
