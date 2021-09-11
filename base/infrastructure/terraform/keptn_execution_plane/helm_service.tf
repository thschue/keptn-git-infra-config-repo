resource "helm_release" "keptn-helm-service" {
  name       = "helm-service"
  repository = "https://storage.googleapis.com/keptn-installer"
  chart                      = "helm-service"
  version                    = "0.9.0"
  wait                       = true
  namespace                  = "keptn"
  create_namespace           = true
  atomic                     = true

  set {
    name  = "distributor.stageFilter"
    value = var.keptn_stages
  }
  set {
    name  = "distributor.projectFilter"
    value = var.keptn_projects
  }
  set {
    name  = "remoteControlPlane.enabled"
    value = true
  }
  set {
    name  = "remoteControlPlane.api.hostname"
    value = var.keptn_hostname
  }
  set {
    name  = "remoteControlPlane.api.token"
    value = var.keptn_token
  }
}