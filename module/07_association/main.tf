resource "azurerm_network_interface_security_group_association" "association" {
    for_each = var.association
    network_interface_id = data.azurerm_network_interface.datanic[each.key].id
    network_security_group_id = data.azurerm_network_security_group.datansg[each.key].id
}