targetScope = 'resourceGroup'

resource sa 'Microsoft.Storage/storageAccounts@2021-02-01' = [for i in range(0,3):{
  name: 'sadeveus9999${i}'
  location: 'eastus'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]
