resource "azurerm_linux_virtual_machine" "testvm" {

  for_each = var.vms

  name                = each.value.name
  resource_group_name = each.value.rgname
  location            = each.value.location
  size                = each.value.size

  admin_username = data.azurerm_key_vault_secret.username[each.key].value
  admin_password = data.azurerm_key_vault_secret.password[each.key].value

  network_interface_ids = [
    data.azurerm_network_interface.datanic[each.key].id
  ]

  disable_password_authentication = each.value.disable_password_authentication

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

  custom_data = filebase64("${path.module}/script.sh")
}