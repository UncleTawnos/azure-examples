variable "subscription_id" {
  default = "XXXXXX"
}

variable "environment" {
  default = "prod"
}

variable "type" {
  default = "myvm"
}

variable "region" {
  default = "westeurope"
}

variable "resource_group" {
  default = "myvm"
}

variable "resource_name_prefix" {
  default = "myvm"
}

# type username e.g sfyda
variable "creator" {}

# thise users are only used to add initial root account to machine
# really sorry for this but terraform does not support nested arrays
# https://github.com/hashicorp/terraform/issues/2114
variable "users" {
  type="map"
  default = {
    mzamlynska.name = "my-user"
    mzamlynska.key = "ssh-rsa XXXXXX"
    mzamlynska.authorized_keys_path = "/home/my-user/.ssh/authorized_keys"

  }
}

variable "myvm" {
  description = "Defines VM"
  type        = "map"

  default = {
    name             = "myvm"
    count            = 2
    size             = "Standard_B2s"
  }
}

variable "subnet_id" {
  default = "/subscriptions/XXXXXXXX/resourceGroups/primary-networking/providers/Microsoft.Network/virtualNetworks/XXXXX/subnets/YYYYY"
}
