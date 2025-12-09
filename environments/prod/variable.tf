variable "rgs" {
  type = map(object({
    rgname     = string
    location   = string
    managed_by = string
    tags       = map(string)
  }))

}

variable "stgs" {
  type = map(object({
    stgname                          = string
    location                         = string
    rgname                           = string
    account_tier                     = string
    account_replication_type         = string
    cross_tenant_replication_enabled = optional(bool)
    access_tier                      = optional(string)
    https_traffic_only_enabled       = optional(bool)
    min_tls_version                  = optional(string)
    allow_nested_items_to_be_public  = optional(bool)
    shared_access_key_enabled        = optional(bool)
    default_to_oauth_authentication  = optional(bool)
    nfsv3_enabled                    = optional(bool)
    tags                             = map(string)

    network_rules = map(object({
      default_action = string
      ip_rules       = list(string)
    }))

  }))
}


variable "vnets" {
  type = map(object({
    vnetname                       = string
    location                       = string
    rgname                         = string
    address_space                  = optional(list(string))
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    private_endpoint_vnet_policies = optional(string)

    ip_address_pool = optional(map(object({
      id                     = string
      number_of_ip_addresses = number
    })))

    ddos_protection_plan = optional(map(object({
      id     = string
      enable = string
    })))

    encryption = optional(object({
      enforcement = string
    }))


    tags = map(string)
  }))
}
variable "subnets" {
  type = map(object({
    subnetname       = string
    rgname           = string
    vnetname         = string
    address_prefixes = list(string)
    delegations = optional(list(object({
      name = string
    })))
  }))
}
variable "nics" {
  type = map(object({
    nicname    = string
    location   = string
    rgname     = string
    subnetname = string
    vnetname   = string
    ip_configuration = map(object({
      name                          = string
      private_ip_address_allocation = string
    }))
  }))
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