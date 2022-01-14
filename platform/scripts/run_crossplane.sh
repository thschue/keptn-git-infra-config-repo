#/bin/ash
/kubectl apply -k /keptn/crossplane/.
/kubectl wait --for=condition=ready cluster/${KEPTN_STAGE}-cluster --timeout=600s
/kubectl wait --for=condition=ready nodepool/${KEPTN_STAGE}-nodepool --timeout=600s