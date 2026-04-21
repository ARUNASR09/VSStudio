param name string
param location string
param nsgrules array
param subnetattach array

//  "_comment": 'left side is vnet file and right hand side substituted with parameters'

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2025-01-01' = {
  name: name
  location: location
  properties: {
    securityRules: [
      for n in nsgrules:   n
    ]
    
  }

}

resource subnetassoc 'Microsoft.Network/virtualNetworks/subnets@2025-01-01'  = [
  for s in subnetattach:  {
    name: '${s.vnet_name}/${s.snet_name}'
    properties: {
          addressPrefix: s.prefix
          networkSecurityGroup : {
            id: networkSecurityGroup.id
          }
        }
    }
  
]
