
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

resource Datadisk 'Microsoft.Compute/disks@2025-01-02' = {
 name: 'datadisk-vm-eus-dev-web-01'
  location: resourceGroup().location
  sku :{
    name:'Standard_LRS'
  }
  properties: {
    creationData:{createOption:'Empty'}
    diskSizeGB:16
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
      dataDisks:[{
        createOption:'Attach'
        lun: 0
        managedDisk:{
          id: Datadisk.id
        }
      }]
        
      
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


resource linuxVMExtensions 'Microsoft.Compute/virtualMachines/extensions@2025-04-01' = {
  parent: ubuntuVM
  name: 'ext-linux-nginx'
  location: resourceGroup().location
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    typeHandlerVersion: '2.1'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: [
        'https://sadeveus9999.blob.core.windows.net/scripts/setup-nginx.sh?sp=r&st=2026-01-22T19:07:24Z&se=2026-01-23T03:22:24Z&spr=https&sv=2024-11-04&sr=b&sig=JoAoxQeHTdfNeU4IfTC3jSkyTCgW8MYONY0rPkC0RfM%3D'
      ]
    }
    protectedSettings: {
      commandToExecute: 'bash setup-nginx.sh'
    }
  }
}
