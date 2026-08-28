resource "azurerm_virtual_network_peering" "peering" {

  for_each = var.vnet_peering

  name = each.value.name

  resource_group_name  = each.value.rgname
  virtual_network_name = each.value.vnetname

  remote_virtual_network_id = data.azurerm_virtual_network.remote[each.key].id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}