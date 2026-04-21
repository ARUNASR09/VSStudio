
param location string
param vnet object

//  "_comment": 'left side is vnet file and right hand side substituted with parameters'

module devnet 'modules/vnet/vnet.bicep' = {
  name : 'dev-network'
  params: {
    name: vnet.name
    location: location
    addressprefix: vnet.addressprefix
    subnet:vnet.subnets
  }
}
