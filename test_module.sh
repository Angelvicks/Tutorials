#!/bin/sh
echo "Take the pod name"
# Get the Odoo pod name
POD=$(kubectl --namespace=test get pod -l app=odoo-test -o jsonpath="{.items[0].metadata.name}");

echo "Run the test on employee"
# Run the tests
kubectl exec --namespace=test $POD -- bash -c 'if ! grep -q "test-enable" /etc/odoo/odoo.conf; then echo "test-enable = True" >> /etc/odoo/odoo.conf; fi'
#kubectl exec --namespace=$2 $POD -- bash -c 'if ! grep -q "db_port" /etc/odoo/odoo.conf; then echo "db_port = 30008 \n db_host = postgres-svc-test \n db_user = odoo \n db_password = odoo" >> /etc/odoo/odoo.conf; fi'

echo "Start the unit-test on employees module"
kubectl exec --namespace=test -i $POD -- bash -c 'odoo --init  employees --test-enable --log-level=test --db_host postgres-svc-test --db_port 5432 --db_user odoo --db_password odoo --database odoo --dev "all" --stop-after-init --no-http'

#kubectl exec --namespace=$NAMESPACE_DEV -i $POD -- bash -c 'odoo -i /mnt/extra-addons/my-modules/tests/test.py --test-enable --log-level=test --db_url=postgresql://odoo:password@host:10008/odoo' > errors.log --dev all

#kubectl exec --namespace=$2 $POD -- bash -c './usr/bin/odoo -i  om_hospital --test-enable' 
