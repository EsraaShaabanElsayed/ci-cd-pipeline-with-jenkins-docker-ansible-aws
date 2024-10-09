#!/bin/bash

# Deploy Kubernetes resources
kubectl apply -f mysql-cm0-configmap.yaml
kubectl apply -f mysql-claim1-persistentvolumeclaim.yaml
kubectl apply -f mysql-deployment.yaml
kubectl apply -f mysql-service.yaml
kubectl apply -f adminer-deployment.yaml
kubectl apply -f adminer-service.yaml
kubectl apply -f petclinic-deployment.yaml
kubectl apply -f petclinic-service.yaml

echo "All Kubernetes resources have been deployed."

