variable "keptn_stages" {
  type = string
}

variable "keptn_projects" {
  type = string
}

variable "keptn_hostname" {
  type = string
}

variable "keptn_token" {
  type = string
  sensitive = true
}

variable "cluster_name" {}
variable "gke_region" {}