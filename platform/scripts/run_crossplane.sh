#/bin/ash

set -e

/kubectl create namespace argo-rollouts | true
/kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

/kubectl apply -k /keptn/crossplane/.
/kubectl wait --for=condition=Ready cluster/${KEPTN_STAGE}-fosdem-cluster --timeout=600s
/kubectl wait --for=condition=Ready nodepool/${KEPTN_STAGE}-fosdem-nodepool --timeout=600s