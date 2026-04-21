param name string
param location string
param nsgrules array

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2025-01-01' = {
  name: name
  location: location
  properties: {
    securityRules: [
      for n in nsgrules:   n
      
    ]
    
  }
}
