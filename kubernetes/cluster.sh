#!/bin/bash -ex

UNIQ=`=`pwgen 6 1`
RESOUCE_GROUP="demo-k8s"
CLUSTER_NAME="demo-k8s"
DNS_PREFIX="${UNIQ}-demo-k8s"

az provider register --namespace Microsoft.Network
az provider register --namespace Microsoft.Compute
az provider register --namespace Microsoft.Storage

az group create --name ${RESOUCE_GROUP} --location westeurope

az acs create --orchestrator-type Kubernetes \
    --dns-prefix ${DNS_PREFIX} \
    --master-count 1 \
    --agent-count 3 \
    --agent-vm-size Standard_D2_v2 \
    --name ${CLUSTER_NAME} \
    --resource-group ${RESOUCE_GROUP}

az acs kubernetes install-cli
az acs kubernetes get-credentials  --name ${CLUSTER_NAME} --resource-group ${RESOUCE_GROUP}
