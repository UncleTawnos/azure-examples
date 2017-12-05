#!/bin/bash -ex

RESOUCE_GROUP="test-network-k8s"
CLUSTER_NAME="test-network-k8s"
DNS_PREFIX="test-network-k8s"

az provider register --namespace Microsoft.Network
az provider register --namespace Microsoft.Compute
az provider register --namespace Microsoft.Storage

az group create --name ${RESOUCE_GROUP} --location westeurope

az acs create --orchestrator-type Kubernetes \
    --dns-prefix ${DNS_PREFIX} \
    --master-count 3 \
    --agent-count 4 \
    --agent-vm-size Standard_D2_v2 \
    --name ${CLUSTER_NAME} \
    --resource-group ${RESOUCE_GROUP}

az acs kubernetes install-cli
az acs kubernetes get-credentials  --name ${CLUSTER_NAME} --resource-group ${RESOUCE_GROUP}