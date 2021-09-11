data "google_client_config" "provider" {}

resource "google_container_cluster" "gke-cluster" {
  name     = var.cluster_name
  location = var.gke_region
  min_master_version = var.cluster_version

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "gke-nodes-containerd" {
  name       = "containerd-node-pool"
  location   = var.gke_region
  cluster    = google_container_cluster.gke-cluster.name
  node_count = var.desired_workers

  autoscaling {
    min_node_count = var.min_workers
    max_node_count = var.max_workers
  }

  node_config {
    preemptible  = var.use_preemptibles
    machine_type = var.worker_instance_type
    image_type = "COS_CONTAINERD"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  management {
    auto_upgrade = false
  }
}

output "gke_endpoint" {
  value = "https://${google_container_cluster.gke-cluster.endpoint}"
}

output "gke_token" {
  value = data.google_client_config.provider.access_token
}

output "gke_ca_data" {
  value = google_container_cluster.gke-cluster.master_auth[0].cluster_ca_certificate
}
