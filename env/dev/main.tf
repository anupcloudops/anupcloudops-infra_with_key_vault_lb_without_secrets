module "rg" {
  source = "../../module/01_rg"
  rgs    = var.rgs
}
module "vnet" {
  depends_on = [module.rg]
  source     = "../../module/02_vnet"
  vnets      = var.vnets
}
module "subnet" {
  depends_on = [module.vnet]
  source     = "../../module/03_subnet"
  subnets    = var.tubnets
}
module "pip" {
  depends_on = [module.subnet]
  source     = "../../module/04_pip"
  pips       = var.pips
}
module "nic" {
  depends_on = [module.subnet, module.pip]
  source     = "../../module/05_nic"
  nics       = var.nics
}
module "nsg" {
  depends_on = [module.rg]
  source     = "../../module/06_nsg"
  nsgs       = var.nsgs
}
module "association" {
  depends_on  = [module.nic, module.nsg]
  source      = "../../module/07_association"
  association = var.association
}
module "vm" {

  depends_on = [ module.nic , module.keyvault]

  source = "../../module/08_vm"
  vms = var.vms

  keyvault_name = var.keyvault["kv1"].name

  keyvault_resource_group = var.keyvault["kv1"].resource_group_name
}
# module "bastion" {
#   depends_on = [module.subnet , module.pip]
#   source     = "../../module/09_bastion"
#   bastion = var.bastion
# }
# module "lb" {
#   depends_on = [module.nic , module.pip , module.vm]
#   source     = "../../module/11_lb"
#   lb = var.lb
#   nic_ids = module.nic.nic_ids
#   nic_ip_configuration_names = module.nic.nic_ip_configuration_names
# }

# module "appgw" {
#   depends_on = [module.nic , module.pip,module.vm]
#   source     = "../../module/12_app_gw"
#   appgw = var.appgw
#    nic_private_ips = module.nic.nic_private_ips
# }
# module "vnet_peering" {
#   depends_on = [module.vnet]
#   source     = "../../module/17_vnet_peering"
#   vnet_peering= var.vnet_peering
# }
module "keyvault" {

  depends_on = [module.rg]

  source = "../../module/13_key_vault"

  keyvault       = var.keyvault
  vm_credentials = var.vm_credentials
}