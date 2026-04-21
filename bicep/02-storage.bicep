targetScope = 'resourceGroup'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'sadeveus9999'
  location: 'eastus'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
