resource "helm_release" "argo" {
  name = "argocd"

  repository    = "https://argoproj.github.io/argo-helm"
  chart         = "argo-cd"
  version       = "v6.7.8"
  namespace     = "infra-tools"
  recreate_pods = true
  replace       = true

  values = [file("files/values.yaml")]

}
