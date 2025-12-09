rgs = {
  "rg1" = {
    rgname     = "mytest-rg"
    location   = "centralindia"
    managed_by = "terraform"
    tags = {
      team = "test"
    }
  }
}

stgs = {
  "stg1" = {
    stgname                          = "myteststg2234"
    location                         = "centralindia"
    rgname                           = "mytest-rg"
    account_tier                     = "Standard"
    account_replication_type         = "LRS"
    cross_tenant_replication_enabled = false
    access_tier                      = "Hot"
    https_traffic_only_enabled       = true
    min_tls_version                  = "TLS1_2"
    allow_nested_items_to_be_public  = false
    shared_access_key_enabled        = true
    default_to_oauth_authentication  = false
    nfsv3_enabled                    = false

    tags = {
      environment = "testterraform"
    }

    network_rules = {
      rule1 = {
        default_action = "Deny"
        ip_rules       = ["100.0.0.1"]
      }
    }


  }
}
vnets = {
  "vnet1" = {
    vnetname                       = "mytest-vnet"
    location                       = "centralindia"
    rgname                         = "mytest-rg"
    address_space                  = ["10.0.0.0/16"]
    dns_servers                    = ["10.0.0.4", "10.0.0.5"]
    private_endpoint_vnet_policies = "Disabled"
    # VNet tags
    "tags" = {
    evvironment = "testterraform" }

    # Encryption
    "encryption" = {
      enforcement = "AllowUnencrypted"
    }
  }
}
subnets = {
  "subnet1" = {
    subnetname       = "mytest-subnet"
    rgname           = "mytest-rg"
    vnetname         = "mytest-vnet"
    address_prefixes = ["10.0.1.0/24"]

    "delegation" = {
      name = "delegation"

      "service_delegation" = {
        name    = "Microsoft.ContainerInstance/containerGroups"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
      }
    }
  }
}
nics = {
  "nic1" = {
    nicname    = "mytest-nic"
    location   = "centralindia"
    rgname     = "mytest-rg"
    subnetname = "mytest-subnet"
    vnetname   = "mytest-vnet"

    "ip_configuration" = {
      "config1" = {
        name                          = "congif1"
        private_ip_address_allocation = "Dynamic"
      }

    }
  }
}

nsgs = {
  "nsg1" = {
    nsgname  = "mytest-nsg01"
    location = "centralindia"
    rgname   = "mytest-rg"
    security_rule = {
      "sesurity_rule1" = {
        name                       = "rule1"
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }

    }
    tags = {
      environment = "test"
    }
  }
}
