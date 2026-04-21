@description('Virtual network Name')
param name string

@description('location')
param location string

@description('Addressprefixes for the vnet')
param addressprefix array

@description('subnet names to be created')
param subnet array

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2025-01-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: addressprefix
    }
    subnets: [
      for s in subnet: {
        name: s.name
        properties: {
          addressPrefix: s.prefix
        }
      }
    ]
  }
}

output subnetIds array =[
  for s in subnet:{
    name: s.name
    id:resourceId('Microsoft.Network/virtualNetworks/subnets',name,s.name)
  }
]
