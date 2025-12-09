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
