resource "azurerm_resource_group" "rgblock" {
    for_each = { for k , v in var.rgs : k=>v if upper(v.location) == "CENTRAL INDIA" }
    name = each.value.name
    location =  each.value.location
    lifecycle {
      prevent_destroy = true
    }
}

resource "azurerm_resource_group" "rgblock1" {
    for_each = { for k , v in var.rgs : k=>v if upper(v.location) != "CENTRAL INDIA" }
    name = each.value.name
    location =  each.value.location
    lifecycle {
      prevent_destroy = false
    }
}