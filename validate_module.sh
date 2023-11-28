#!/bin/sh

echo "Odoo initialized with custom addons:  ${list_addons[@]}";
kubectl --namespace=test logs $POD > output.log;
if [ $(grep -c "CRITICAL\|ERROR\|Traceback\|AttributeError" output.log) -ne 0 ]
then
    cat output.log >&2;
    for addons in "${list_addons[@]}"
    do
      kubectl exec --namespace=test $POD -- /bin/sh -c "rm -r $addons" && echo "$addons deleted";
    done
    kubectl --namespace=test rollout restart deployment/odoo-test;
    exit 1
else
    cat output.log && exit 0
fi
