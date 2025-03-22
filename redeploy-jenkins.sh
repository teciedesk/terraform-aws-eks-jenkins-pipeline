#!/bin/bash

# Step 1: Uninstall existing Jenkins release
echo "Uninstalling existing Jenkins release..."
helm uninstall jenkins -n jenkins

# Step 2: Delete Jenkins namespace (cleanup)
echo "Deleting Jenkins namespace..."
kubectl delete ns jenkins

# Step 3: Recreate Jenkins namespace
echo "Recreating Jenkins namespace..."
kubectl create ns jenkins

# Step 4: Reinstall Jenkins with values.yaml and explicit LoadBalancer override
echo "Reinstalling Jenkins with LoadBalancer service type..."
helm upgrade --install jenkins jenkins/jenkins \
  -n jenkins \
  -f values.yaml \
  --set controller.service.type=LoadBalancer

# Step 5: Wait and verify
echo "Waiting for service to be provisioned..."
sleep 30

echo "Checking service status:"
kubectl get svc -n jenkins

echo "Done! 🎉 Jenkins should now have LoadBalancer external IP!"

