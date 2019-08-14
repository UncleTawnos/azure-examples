resource "azurerm_resource_group" "primary-networking" {
    name     = "${var.resource_group}"
    location = "${var.location}"

    tags {
        deployment = "terraform",
        environment = "${var.environment}",
        type = "${var.type}",
        creator = "${var.creator}",
    }
}
