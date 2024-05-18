resource "helm_release" "argo" {
  name = "argocd-apps"

  repository    = "https://argoproj.github.io/argo-helm"
  chart         = "argocd-apps"
  version       = "2.0.0"
  namespace     = "infra-tools"
  recreate_pods = true
  replace       = true

  values = [file("files/values.yaml")]

}
