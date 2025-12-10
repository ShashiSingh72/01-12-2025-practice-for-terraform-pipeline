module "rg" {
  source = "../../modules/Resource_group"
  rgs    = var.rgs
}

module "stg" {
  depends_on = [module.rg]
  source     = "../../modules/Storage_account"
  stgs       = var.stgs
}
module "vnet" {
  depends_on = [module.rg]
  source     = "../../modules/Virtual_network"
  vnets      = var.vnets
  
}
module "subnet" {
  depends_on = [module.vnet , module.rg]
  source     = "../../modules/Subnet"
  subnets    = var.subnets
}

module "nic" {
  depends_on = [ module.rg, module.vnet,module.subnet]
  source = "../../modules/Network_interface_card"
  nics   = var.nics
}

module "avset" {
  depends_on = [ module.rg]
  source = "../../modules/Availability_set"
  avsets   = var.avsets
}

module "vms" {
  depends_on = [ module.rg, module.nic, module.avset]
  source = "../../modules/Virtual_machine"
  vms   = var.vms
}