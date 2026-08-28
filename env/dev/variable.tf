variable "rgs" {
  type = map(object({
    name       = string
    location   = string
    tags       = optional(map(string))
    managed_by = optional(string)
  }))
}
variable "vnets" {}
variable "tubnets" {}
variable "pips" {}
variable "nics" {}
variable "nsgs" {}
variable "association" {}
variable "vms" {}
variable "bastion" {}
variable "appgw" {}
variable "lb" {}
variable "vnet_peering" {}
variable "keyvault" {}

variable "vm_credentials" {
   type      = any
     sensitive = true
}

