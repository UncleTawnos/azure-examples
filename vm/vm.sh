#!/bin/bash -ex

APP_NAME="panel"

RESOURCE_GROUP="az-workshop-apps"
VNET_NAME="backend"
VNET_GROUP="az-workshop-net"
SUBNET="apps"

DNS_PREFIX="az-workshop"

VM_ADMIN_USERNAME="<USER>"
VM_ADMIN_PASSWORD="<PASSWORD>"
VM_ADMIN_AUTH_TYPE=password

for number in `seq 1 2`;
do
    NAME="${APP_NAME}${number}"
    PIP_NAME=${NAME}-pip
    NSG_NAME=${NAME}-nsg
    NIC_NAME=${NAME}-nic1
    OS_DISK_NAME=${NAME}-osdisk

    az group create -n ${RESOURCE_GROUP} -l "westeurope"

    az provider register --namespace Microsoft.Storage
    az provider register --namespace Microsoft.Compute

    az vm availability-set create -n ${APP_NAME} -g ${RESOURCE_GROUP}

    az network public-ip create --resource-group ${RESOURCE_GROUP} --name ${PIP_NAME} --allocation-method static --dns-name ${DNS_PREFIX}-${PIP_NAME}
    az network nsg create --resource-group ${RESOURCE_GROUP} --name ${NSG_NAME}

    subnetID=`az network vnet subnet show -g ${VNET_GROUP} --vnet-name ${VNET_NAME} \
     --name ${SUBNET}  --query id -otsv`

    az network nic create \
      --resource-group ${RESOURCE_GROUP} \
      --name ${NIC_NAME} \
      --subnet ${subnetID} \
      --network-security-group ${NSG_NAME} \
      --public-ip-address ${PIP_NAME}


    az vm create \
        --resource-group ${RESOURCE_GROUP} \
        --name ${NAME} \
        --authentication-type ${VM_ADMIN_AUTH_TYPE} \
        --admin-username ${VM_ADMIN_USERNAME} \
        --admin-password ${VM_ADMIN_PASSWORD} \
        --nics ${NIC_NAME} \
        --availability-set ${APP_NAME} \
        --size "Standard_DS2_v2" \
        --os-disk-name ${OS_DISK_NAME} \
        --custom-data cloud-init.yaml \
        --image "UbuntuLTS" \
        --storage-sku Premium_LRS


    az vm open-port \
        --resource-group ${RESOURCE_GROUP} \
        --name ${NAME} \
        --port 22 \
        --priority 101

    az vm open-port \
        --resource-group ${RESOURCE_GROUP} \
        --name ${NAME} \
        --port 80 \
        --priority 102

    az vm open-port \
        --resource-group ${RESOURCE_GROUP} \
        --name ${NAME} \
        --port 443 \
        --priority 103

done