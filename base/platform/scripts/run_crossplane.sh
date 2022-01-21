#/bin/ash

set -e

/kubectl apply -k /keptn/crossplane/.
/kubectl wait --for=condition=Ready cluster/${KEPTN_STAGE}-fosdem-cluster --timeout=600s
/kubectl wait --for=condition=Ready nodepool/${KEPTN_STAGE}-fosdem-nodepool --timeout=600s