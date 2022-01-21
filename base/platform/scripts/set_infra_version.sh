#/bin/ash

set -e

/kubectl create cm infra-version --from-literal=infraVersion=${INFRAVERSION} --dry-run -oyaml | /kubectl apply -f -