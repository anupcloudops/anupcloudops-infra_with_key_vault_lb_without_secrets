data "azurerm_network_interface" "datanic"{
    for_each = var.vms
    name = each.value.nicname
    resource_group_name = each.value.rgname
}
data "azurerm_key_vault" "kv" {

  name                = var.keyvault_name
  resource_group_name = var.keyvault_resource_group
}


data "azurerm_key_vault_secret" "username" {

  for_each = var.vms

  name         = each.value.username_secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}


data "azurerm_key_vault_secret" "password" {

  for_each = var.vms

  name         = each.value.password_secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}