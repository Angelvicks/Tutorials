#!/bin/bash
run_build_job() {
    NAMESPACE_DEV=$1
    APP_DEV=$2
    DEPLOYMENT_DEV=$3

    echo "Copy addons file in Odoo pod"
    POD=$(kubectl --namespace=$NAMESPACE_DEV get pod -l app=$APP_DEV -o jsonpath="{.items[0].metadata.name}")
    for module in odoo-modules/addons/*; do
        kubectl cp  "$module" "$NAMESPACE_DEV/$POD:/mnt/extra-addons/"
    done

    kubectl exec --namespace=$NAMESPACE_DEV "$POD" -- bash -c 'if ! grep -q "addons_path" /etc/odoo/odoo.conf; then echo "addons_path=/mnt/extra-addons" >> /etc/odoo/odoo.conf; fi'

    echo "Restart pod"
    kubectl --namespace=$NAMESPACE_DEV rollout restart "deployment/$DEPLOYMENT_DEV"

    echo "Odoo restarted"
    # kubectl --namespace=$NAMESPACE_DEV logs "$POD"
}