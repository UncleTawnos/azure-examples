resource "azurerm_network_interface" "myvm_nic" {
  depends_on = ["azurerm_network_security_group.myvm_public_nsg"]
  count                     = "${var.myvm["count"]}"
  name                      = "${var.myvm["name"]}-nic-${count.index}"
  location                  = "${var.region}"
  resource_group_name       = "${var.resource_group}"
  network_security_group_id = "${azurerm_network_security_group.myvm_public_nsg.id}"

  ip_configuration {
    name                          = "${var.myvm["name"]}-config-nic-${count.index}"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
  }

  tags {
    deployment  = "terraform"
    environment = "${var.environment}"
    type        = "${var.type}"
    creator     = "${var.creator}"
  }
}
