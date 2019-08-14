variable "subscription_id" {
  default = "XXXXXXX"
}

variable "environment" {
  default = "production"
}

variable "type" {
  default = "storage"
}

variable "region" {
  default = "westeurope"
}

variable "resource_group" {
  default = "storage"
}

variable "resource_name_prefix" {
  default = "azure-example-12303"
}

# type username e.g sfyda
variable "current_user" {
  default = "my-name"
}
