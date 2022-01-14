#/bin/ash
/kubectl apply -k /keptn/crossplane/.
/kubectl wait --for=condition=synced cluster/$(STAGE)-cluster --timeout=600s
/kubectl wait --for=condition=synced nodegroup/$(STAGE)-nodegroup --timeout=600s