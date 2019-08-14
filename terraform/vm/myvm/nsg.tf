resource "azurerm_network_security_group" "myvm_public_nsg" {
    name                = "${var.resource_name_prefix}-public-nsg"
    location            = "${var.region}"
    resource_group_name = "${azurerm_resource_group.default.name}"

    tags {
        deployment  = "terraform"
        environment = "${var.environment}"
        type        = "${var.type}"
        creator     = "${var.creator}"
    }
}