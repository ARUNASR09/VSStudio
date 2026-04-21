
param location string
param vnet object
param storageAccountName string
param nsgrules object


//  "_comment": 'left side is vnet file and right hand side substituted with parameters'

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

  }
}
