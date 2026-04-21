resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2025-01-01' existing = {
  name: 'pip-eus-dev-01'
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2025-01-01' existing = {
  name: 'vnet-eus-dev-01'
}

resource subnet1 'Microsoft.Network/virtualNetworks/subnets@2025-01-01' existing = {
  name: 'snet-eus-dev-web-01'
  parent: virtualNetwork
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2025-01-01' = {
  name: 'nic-eus-dev-01'
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig-web-01'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnet1.id
          }
          publicIPAddress: {
              id:publicIPAddress.id
           }
        }
      }
    ]
  }
}
