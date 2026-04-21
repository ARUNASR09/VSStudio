var nsgName           = 'nsg-az104-shared-eus-01'

resource nsg1 'Microsoft.Network/networkSecurityGroups@2025-01-01' existing = {
  name: nsgName
}

resource vnet1 'Microsoft.Network/virtualNetworks@2025-01-01' existing = {
  name: 'vnet-eus-dev-01'
}

resource subnetweb 'Microsoft.Network/virtualNetworks/subnets@2025-01-01'  = {
        name: 'snet-eus-dev-web-01'
        parent: vnet1
        properties: {
          addressPrefix: '10.0.0.0/24'
          networkSecurityGroup : {
            id: nsg1.id
          }
        }
      }
resource subnetdb 'Microsoft.Network/virtualNetworks/subnets@2025-01-01'  = {
        name: 'snet-eus-dev-db-01'
        parent: vnet1
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup : {
            id: nsg1.id
          }
        }
      }

