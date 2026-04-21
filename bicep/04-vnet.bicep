targetScope = 'resourceGroup'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2025-01-01' = {
  name: 'vnet-eus-dev-01'
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'snet-eus-dev-web-01'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'snet-eus-dev-db-01'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

