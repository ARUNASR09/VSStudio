

resource nic1 'Microsoft.Network/networkInterfaces@2025-01-01' existing = {
  name: 'nic-eus-dev-01'
}

resource sa1 'Microsoft.Storage/storageAccounts@2025-06-01' = {
  name: 'sadeveus9999'
  location: 'eastus'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

var blob = sa1.properties.primaryEndpoints.blob


resource ubuntuVM 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: 'vm-eus-dev-web-01'
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DC1s_v3'
    }
    osProfile: {
      computerName: 'vm-eus-dev-web-01'
      adminUsername: 'linuxadmin'
      adminPassword: '@Admin123'
    }

    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        name: 'name'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic1.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: blob
      }
    }
  }
}
