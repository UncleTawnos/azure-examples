resource "azurerm_resource_group" "default" {
  name     = "${var.resource_group}"
  location = "${var.region}"

  tags {
    deployment  = "terraform"
    environment = "${var.environment}"
    type        = "${var.type}"
    creator     = "${var.current_user}"
  }
}
