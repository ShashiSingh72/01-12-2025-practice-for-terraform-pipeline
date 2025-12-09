resource "azurerm_network_security_group" "nsg" {
    for_each = var.nsgs
  name                = each.value.nsgname
  location            = each.value.location
  resource_group_name = each.value.rgname
  tags = each.value.tags

  dynamic "security_rule" {
    for_each = each.value.security_rule
    content {
    name                       = security_rule.value.name      # "test123"
    priority                   = security_rule.value.priority   # 100
    direction                  = security_rule.value.direction #"Inbound"
    access                     = security_rule.value.access    #"Allow"
    protocol                   = security_rule.value.protocol  #"Tcp"
    source_port_range          = security_rule.value.source_port_range #"*"
    destination_port_range     = security_rule.value.destination_port_range  #"*"
    source_address_prefix      = security_rule.value.source_address_prefix#"*"
    destination_address_prefix = security_rule.value.destination_address_prefix #"*"
  }
  }
}

variable "nsgs" {
  type = map(object({
    nsgname       = string
    location      = string
    rgname        = string
    tags          = map(string)
    security_rule = map(object({
      name                       = string
      priority                   = string
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })) 
  }))
  
}