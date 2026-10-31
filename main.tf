resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each            = var.vms-linux
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_ssh_key {
    username   = each.value.admin_username
    public_key = each.value.admin_ssh_key
  }
  network_interface_ids = [
    data.azurerm_network_interface.nic[each.key].id
  ]

  disable_password_authentication = true

  os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }



  tags = {
    Environment = "Preprod"
    ManagedBy   = "Terraform"
    Project     = "Studio"
  }
}

