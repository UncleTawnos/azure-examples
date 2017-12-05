#Kubernetes example

## General ideas
* cluster is built using Azure ACS via AZ cli (`cluster.sh`)
* after running the script, you will have `kubectl` cli installed
* when deploying templates, always use `apply` (`kubectl apply -f nginx-ssl-secret.yml`),
don't use `create` as it mess up with further updates.
* `nginx-ssl-secret.yml` contains self-signed SSL cert encoded in Base64


## How to run
1. `./cluster.sh`
2. `./configmap.sh`
3. `kubectl apply -f nginx-ssl-secret.yml`
4. `kubectl apply -f frontend.yml`