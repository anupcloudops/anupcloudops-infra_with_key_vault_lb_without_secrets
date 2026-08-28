resource "azurerm_application_gateway" "appgw" {
  for_each = var.appgw

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rgname

  sku {
     name     = "Standard_v2"
  tier     = "Standard_v2"
  capacity = 2
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = data.azurerm_subnet.datasub[each.key].id
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = data.azurerm_public_ip.datapip[each.key].id
  }

  frontend_port {
    name = "frontend-port"
    port = 80
  }

  backend_address_pool {
    name = "backend-pool"
   ip_addresses = [
  var.nic_private_ips["vm1"],
  var.nic_private_ips["vm2"]
]
  }

  backend_http_settings {
    name                  = "http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing-rule"
    priority                   = 100
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "http-settings"
  }
}