#!/bin/bash
#kubectl delete configmap frontend-nginx-conf
kubectl create configmap frontend-nginx-conf --from-file=frontend.conf


