rgs = {
  "rg1" = {
    rgname     = "mydev-rg"
    location   = "centralindia"
    managed_by = "terraform"
    tags = {
      team = "dev"
    }
  }
  "rg2" = {
    rgname     = mydev-rg
    location   = centralindia
    managed_by = "terraform"
    tags = {
      team = "dev"
    }
  }
}

stgs = {
  "stg1" = {
    stgname                          = "mydevstg2234"
    location                         = "centralindia"
    rgname                           = "mydev-rg"
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
      environment = "devterraform"
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
    vnetname                       = "mydev-vnet"
    location                       = "centralindia"
    rgname                         = "mydev-rg"
    address_space                  = ["10.0.0.0/16"]
    dns_servers                    = ["10.0.0.4", "10.0.0.5"]
    private_endpoint_vnet_policies = "Disabled"
    # VNet tags
    "tags" = {
    evvironment = "devterraform" }

    # Encryption
    "encryption" = {
      enforcement = "AllowUnencrypted"
    }
  }
}
subnets = {
  "subnet1" = {
    subnetname       = "mydev-subnet"
    rgname           = "mydev-rg"
    vnetname         = "mydev-vnet"
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
    nicname    = "mydev-nic"
    location   = "centralindia"
    rgname     = "mydev-rg"
    subnetname = "mydev-subnet"
    vnetname   = "mydev-vnet"

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
    nsgname  = "mydev-nsg01"
    location = "centralindia"
    rgname   = "mydev-rg"
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
      environment = "dev"
    }
  }
}

avsets = {
  "avset1" = {
    AvailabilitySetname = "AvailabilitySet1"
    location            = "centralindia"
    rgname              = "mydev-rg"
  }
}

vms = {
  "vms1" = {
    vmname              = "mydev-vm01"
    rgname              = "mydev-rg"
    location            = "centralindia"
    size                = "Standard_F2"
    admin_username      = "username"
    admin_password      = "Password@12345"
    AvailabilitySetname = "AvailabilitySet1"
    nicname             = "mydev-nic"

    os_disk = {
      "disk1" = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    }

    source_image_reference = {
      "source_image_reference" = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
      }

    }
  }
}

