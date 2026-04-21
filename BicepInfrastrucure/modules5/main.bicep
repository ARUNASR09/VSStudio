
param location string
param vnet object
param storageAccountName string
param nsgrules object
param windowsconfig object
param windowspassword string

var subnetattachs = [
 {
    vnet_name: vnet.name
    snet_name: vnet.subnets[0].name
    prefix: vnet.subnets[0].prefix
  }
  {
    vnet_name: vnet.name
    snet_name: vnet.subnets[1].name
    prefix: vnet.subnets[1].prefix
  }
]


//  "_comment": 'left side is module variables and right hand side substituted with parameters'

module devnet 'vnet/vnet.bicep' = {
  name : 'dev-network'
  params: {
    name: vnet.name
    location: location
    addressprefix: vnet.addressprefix
    subnet:vnet.subnets
  }
}

module sa 'storage/storage.bicep' = {
  name : 'sadevname'
  params: {
    name: storageAccountName
    location: location

  }
}

module ntwknsg 'nsg/nsg.bicep' = {
  name : 'nsg_dev_eus_01'
  params: {
    name: nsgrules.name
    location: location
    nsgrules:nsgrules.rules
    subnetattach:subnetattachs

  }
  dependsOn:[devnet]
}

module vmwinconfig 'Compute/windowsVm.bicep' = {
   name : 'windows-vm' 
   params: {
    Name: windowsconfig.Name
    location: location
    VMSize:windowsconfig.VMSize
    Adminuser:windowsconfig.Adminuser
    Adminpwd:windowspassword
    VMCount:windowsconfig.VMCount
    subnetId:devnet.outputs.subnetIds[0].id

  }
  dependsOn:[ntwknsg]
}
