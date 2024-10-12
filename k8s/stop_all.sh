#!/bin/bash

# Delete Kubernetes resources
kubectl delete -f adminer-deployment.yaml
kubectl delete -f adminer-service.yaml
kubectl delete -f mysql-cm0-configmap.yaml
kubectl delete -f mysql-deployment.yaml
kubectl delete -f mysql-service.yaml
kubectl delete -f petclinic-deployment.yaml
kubectl delete -f petclinic-service.yaml

echo "All Kubernetes resources have been deleted."

