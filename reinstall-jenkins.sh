#!/bin/bash

# Set namespace and release name
NAMESPACE="jenkins"
RELEASE_NAME="jenkins"

echo "🧹 Uninstalling existing Jenkins release..."
helm uninstall $RELEASE_NAME -n $NAMESPACE

echo "🗑️ Deleting Jenkins namespace (optional cleanup)..."
kubectl delete namespace $NAMESPACE --wait

echo "🔄 Updating Helm repo..."
helm repo update

echo "🚀 Reinstalling Jenkins..."
helm install $RELEASE_NAME jenkins/jenkins -n $NAMESPACE --create-namespace

echo "✅ Jenkins reinstalled successfully!"

echo ""
echo "➡️  To get Jenkins admin password, run:"
echo "kubectl exec --namespace $NAMESPACE -it svc/$RELEASE_NAME -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo"
echo ""
echo "➡️  To port-forward Jenkins locally, run:"
echo "kubectl --namespace $NAMESPACE port-forward svc/$RELEASE_NAME 8080:8080"
