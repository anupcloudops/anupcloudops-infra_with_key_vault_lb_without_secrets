resource "azurerm_network_security_group" "nsg" {
    for_each = var.nsgs
    name = each.value.name
    location = each.value.location
    resource_group_name = each.value.rgname

   dynamic "security_rule" {
    for_each = each.value.rule 
   content {
    
    name = security_rule.value.name
    direction = security_rule.value.direction
    access = security_rule.value.access
    priority = security_rule.value.priority
    protocol = security_rule.value.protocol
    source_address_prefix = security_rule.value.source_address_prefix
    destination_address_prefix = security_rule.value.destination_address_prefix
    source_port_range = security_rule.value.source_port_range
    destination_port_range = security_rule.value.destination_port_range
    }
}
}