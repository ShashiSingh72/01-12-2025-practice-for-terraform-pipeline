module "rg" {
  source = "../modules/rg"
  rgs    = var.rgs
}

module "stg" {
  depends_on = [module.rg]
  source     = "../modules/stg"
  stgs       = var.stgs
}
module "vnet" {
  depends_on = [module.rg]
  source     = "../modules/vnet"
  vnets      = var.vnets
  
}
module "subnet" {
  depends_on = [module.vnet , module.rg]
  source     = "../modules/subnet"
  subnets    = var.subnets
}

module "nic" {
  depends_on = [ module.rg, module.vnet,module.subnet]
  source = "../modules/nic"
  nics   = var.nics
}