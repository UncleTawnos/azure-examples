resource "azurerm_virtual_network" "mynet" {
  name                = "mynet"
  location            = "${azurerm_resource_group.primary-networking.location}"
  resource_group_name = "${azurerm_resource_group.primary-networking.name}"
  address_space       = ["10.1.0.0/16"]
  dns_servers         = ["10.1.0.20", "10.1.0.21", "10.1.0.22"]

  subnet {
    name           = "default"
    address_prefix = "10.1.0.0/28"
  }

  subnet {
    name           = "management"
    address_prefix = "10.1.0.16/28"
  }

  subnet {
    name           = "logs"
    address_prefix = "10.1.0.32/28"
  }
  subnet {
    name           = "devops"
    address_prefix = "10.1.0.48/28"
  }
  subnet {
    name           = "db-master"
    address_prefix = "10.1.0.96/28"
  }
  subnet {
    name           = "db-slave"
    address_prefix = "10.1.0.192/28"
  }
  subnet {
    name           = "tools"
    address_prefix = "10.1.0.112/28"
  }
  subnet {
    name           = "apps"
    address_prefix = "10.1.0.128/26"
  }



  tags {
    deployment = "terraform",
    environment = "${var.environment}",
    type = "${var.type}",
    creator = "${var.deployer}",
  }
}