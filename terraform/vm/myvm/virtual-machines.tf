resource "azurerm_virtual_machine" "myvm" {
  depends_on                       = ["azurerm_resource_group.default"]
  count                            = "${var.myvm["count"]}"
  name                             = "${var.myvm["name"]}-${count.index}"
  location                         = "${var.region}"
  resource_group_name              = "${azurerm_resource_group.default.name}"
  network_interface_ids            = ["${element(azurerm_network_interface.myvm_nic.*.id, count.index)}"]
  vm_size                          = "${var.myvm["size"]}"
  delete_data_disks_on_termination = false
  delete_os_disk_on_termination    = true

  storage_os_disk {
    name              = "${var.resource_name_prefix}-os-disk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.myvm["name"]}-${count.index}"
    admin_username = "${lookup(var.users, "${var.creator}.name")}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "${lookup(var.users, "${var.creator}.authorized_keys_path")}"
      key_data = "${lookup(var.users, "${var.creator}.key")}"
    }
  }

  tags {
    deployment  = "terraform"
    environment = "${var.environment}"
    type        = "${var.type}"
    creator     = "${var.creator}"
  }
}
