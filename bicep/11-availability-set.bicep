
resource nic1 'Microsoft.Network/networkInterfaces@2025-01-01' existing = {
  name: 'nic-eus-dev-01'
}

resource sa1 'Microsoft.Storage/storageAccounts@2025-06-01' existing = {
  name: 'sadeveus9999'
}

var blob = sa1.properties.primaryEndpoints.blob

resource availset1 'Microsoft.Compute/availabilitySets@2025-04-01' = {
  name: 'as_eus_dev_web_01'
  location: resourceGroup().location
  sku:{
    name : 'Aligned'
  }
  properties: {
    platformFaultDomainCount : 2
    platformUpdateDomainCount : 5
   
  }
}



resource ubuntuVM 'Microsoft.Compute/virtualMachines@2025-04-01' = {
 name: 'vm-eus-dev-web-01'
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DC1s_v3'
    }
    availabilitySet: {
      id: availset1.id
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
