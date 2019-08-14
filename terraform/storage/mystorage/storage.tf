resource "azurerm_storage_account" "mystorage" {
  name                = "mystorage"
  resource_group_name = "${var.resource_group}"
  location                 = "${var.region}"
  account_tier             = "Standard"
  account_replication_type = "LRS"


  tags {
    deployment  = "terraform"
    environment = "${var.environment}"
    type        = "${var.type}"
    creator     = "${var.current_user}"
  }
}

resource "azurerm_storage_queue" "myqueue" {
  name                 = "myqueue"
  resource_group_name  = "${var.resource_group}"
  storage_account_name = "${azurerm_storage_account.mystorage.name}"
}

