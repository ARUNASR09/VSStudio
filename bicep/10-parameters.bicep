@description('Virtual Machine Name')
param vmName string

@description('Admin User Name for the VM')
param vmAdminName string

@description('Admin User Name for the VM')
@secure()
param vmAdminPwd string

resource nic1 'Microsoft.Network/networkInterfaces@2025-01-01' existing = {
  name: 'nic-eus-dev-01'
}

resource sa1 'Microsoft.Storage/storageAccounts@2025-06-01' existing = {
  name: 'sadeveus9999'
}

var blob = sa1.properties.primaryEndpoints.blob


resource ubuntuVM 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: vmName
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DC1s_v3'
    }
    osProfile: {
      computerName: vmName
      adminUsername: vmAdminName
      adminPassword: vmAdminPwd
    }

    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        name: 'osdisk-vm-eus-dev-web-01'
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
