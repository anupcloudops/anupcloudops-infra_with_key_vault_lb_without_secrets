data "azurerm_subnet" "datasub"{
    for_each = var.nics
    name = each.value.subname
    resource_group_name = each.value.rgname
    virtual_network_name = each.value.vnet
}
data "azurerm_public_ip" "datapip" {
     for_each = {
    for k, v in var.nics : k => v
    if v.pipname != null
  }
    name = each.value.pipname
   resource_group_name = each.value.rgname
}