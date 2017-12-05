#!/bin/bash -x

az provider register --namespace Microsoft.Network
RESOURCE_GROUP="az-workshop-net"
VNET_NAME="backend"

az group create -n ${RESOURCE_GROUP} -l "westeurope"

az network vnet create --resource-group ${RESOURCE_GROUP} \
 --name ${VNET_NAME} --address-prefix 192.168.0.0/16 \
 --subnet-name apps --subnet-prefix 192.168.1.0/24


az network vnet subnet create  --address-prefix 192.168.2.0/24 \
        --name db --resource-group ${RESOURCE_GROUP} --vnet-name ${VNET_NAME}


