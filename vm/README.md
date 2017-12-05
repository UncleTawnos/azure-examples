#VM example

## General idea
* Using `vm.sh` you can deploy two VMs and provision them with Cloud-Init
* Using `lb.sh` you can create a public load balancer 
* Using `vnet.sh` you can create a VNET that resides in a different resource group than VMs


## How to run
1. Update `cloud-init.yaml` with your public ssh key, then update `vm.sh` with your user and password. 
    Note that if the same user would be created by both `vm.sh` and `cloud-init`, the later takes precedence
    and overrides existing user
2. `./vnet.sh`
3. `./vm.sh`
4. `./lb.sh`