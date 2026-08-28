# data "azurerm_virtual_network" "local" {

#   for_each = var.vnet_peering

#   name                = each.value.vnetname
#   resource_group_name = each.value.rgname
# }

data "azurerm_virtual_network" "remote" {

  for_each = var.vnet_peering

  name                = each.value.remote_vnetname
  resource_group_name = each.value.remote_rgname
}