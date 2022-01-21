#/bin/ash

set -e

/kubectl apply -k /keptn/crossplane/.
/kubectl wait --for=condition=Ready cluster/${KEPTN_STAGE}-cluster --timeout=600s
/kubectl wait --for=condition=Ready nodepool/${KEPTN_STAGE}-nodepool --timeout=600s