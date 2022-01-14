#/bin/ash
/kubectl apply -k /keptn/crossplane/.
/kubectl wait --for=condition=synced cluster/${STAGE}-cluster --timeout=600s
/kubectl wait --for=condition=synced nodepool/${KEPTN_STAGE}-nodepool --timeout=600s