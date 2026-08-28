resource "azurerm_key_vault" "key_vault" {

  for_each = var.keyvault

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  tenant_id = data.azurerm_client_config.current.tenant_id

  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled

  sku_name = each.value.sku_name

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
      "Backup",
      "Restore",
    ]

    storage_permissions = [
      "Get",
      "Set",
      "List",
    ]
  }
}



resource "azurerm_key_vault_secret" "vm_username" {

   for_each = nonsensitive(toset(keys(var.vm_credentials)))

  name         = "${each.key}-username"
  value        = var.vm_credentials[each.key].username
  key_vault_id = azurerm_key_vault.key_vault["kv1"].id
}


resource "azurerm_key_vault_secret" "vm_password" {

   for_each = nonsensitive(toset(keys(var.vm_credentials)))

  name         = "${each.key}-password"
  value        = var.vm_credentials[each.key].password
  key_vault_id = azurerm_key_vault.key_vault["kv1"].id
}