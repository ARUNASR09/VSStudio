
param Name string 
param location string 
param VMSize string
param Adminuser string = 'azureadmin'
param Adminpwd string
param VMCount int

param subnetId string

var varvmindex = [for vm in range(0,VMCount):vm]
var varvmNames = [for i in varvmindex:'vm-${Name}-${i}']
var varNicNames = [for i in varvmindex:'nic-${Name}-${i}']

resource networkInterface 'Microsoft.Network/networkInterfaces@2025-01-01' = [
  for (NicName,i) in varNicNames:{
  
  name: NicName
  location: location
  properties: {
    ipConfigurations: [{
        name: 'ipconfig-01'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: { id : subnetId}
        }
      }]
  }

}
]


resource Vmcompute 'Microsoft.Compute/virtualMachines@2025-04-01' = [
  for (VMName,i) in varvmNames:{
  name: VMName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: VMSize
    }
    osProfile: {
      computerName: VMName
      adminUsername: Adminuser
      adminPassword: Adminpwd
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter-g2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk:{
          storageAccountType:'Standard_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface[i].id
        }
      ]
    }
 
  }
}
]
