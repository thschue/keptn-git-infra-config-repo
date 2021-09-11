variable "gke_region" {}
variable "gke_project" {}
variable "cluster_name" {}
variable "cluster_version" {}

variable "worker_instance_type" {
  type = string
}

variable "min_workers" {
  type = number
}

variable "max_workers" {
  type = number
}

variable "desired_workers" {
  type = number
}

variable "use_preemptibles" {
  type = bool
}