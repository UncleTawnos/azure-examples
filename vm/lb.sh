#!/bin/bash -x

DNS_PREFIX="az-workshop"

APP="panel"
RESOURCE_GROUP="az-workshop-apps"

    ip="lb-${APP}-pip"
    az network public-ip create --resource-group ${RESOURCE_GROUP} --name ${ip} --allocation-method static --dns-name ${DNS_PREFIX}-${ip}

    az network lb create \
        --resource-group ${RESOURCE_GROUP} \
        --name lb-${APP} \
        --frontend-ip-name lb-${APP}-frontpool \
        --backend-pool-name lb-${APP}-backpool \
        --public-ip-address ${ip}

    az network lb probe create \
        --resource-group ${RESOURCE_GROUP} \
        --lb-name lb-${APP} \
        --name APP-ready-80 \
        --protocol tcp \
        --port 80

    az network lb rule create \
        --resource-group ${RESOURCE_GROUP} \
        --lb-name lb-${APP} \
        --name lb-${APP}-rule-port80 \
        --protocol tcp \
        --frontend-port 80 \
        --backend-port 80 \
        --frontend-ip-name lb-${APP}-frontpool \
        --backend-pool-name lb-${APP}-backpool \
        --probe-name APP-ready-80

    az network lb rule create \
        --resource-group ${RESOURCE_GROUP} \
        --lb-name lb-${APP} \
        --name lb-${APP}-rule-port443 \
        --protocol tcp \
        --frontend-port 443 \
        --backend-port 443 \
        --frontend-ip-name lb-${APP}-frontpool \
        --backend-pool-name lb-${APP}-backpool \
        --probe-name APP-ready-80

    az network nic ip-config address-pool add \
        --resource-group ${RESOURCE_GROUP} \
        --nic-name ${APP}1-nic1 \
        --ip-config-name ipconfig1 \
        --lb-name lb-${APP} \
        --address-pool lb-${APP}-backpool

    az network nic ip-config address-pool add \
        --resource-group ${RESOURCE_GROUP} \
        --nic-name ${APP}2-nic1 \
        --ip-config-name ipconfig1 \
        --lb-name lb-${APP} \
        --address-pool lb-${APP}-backpool
