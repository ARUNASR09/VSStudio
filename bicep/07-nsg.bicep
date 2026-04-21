var nsgName           = 'nsg-az104-shared-eus-01'
var any               = '*'

var ruleSshName       = 'in-allow-rdp-admin'
var ruleSshPriority   = 400
var SshPort           = '22'

var svcTagInternet    = 'Internet'
var httpDestIp        = '10.0.0.4'
var httpPort          = '80'
var ruleHttpName      = 'in-allow-http-from-internet-to-10-0-0-4'
var ruleHttpPriority  = 410

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2025-01-01' = {
  name: nsgName
  location: resourceGroup().location
  properties: {
    securityRules: [
      {
        name: ruleHttpName
        properties: {
          description: ruleHttpName
          protocol: 'Tcp'
          sourcePortRange: any
          destinationPortRange: httpPort
          sourceAddressPrefix: svcTagInternet
          destinationAddressPrefix: httpDestIp
          access: 'Allow'
          priority: ruleHttpPriority
          direction: 'Inbound'
        }
      }
      
      {
        name: ruleSshName
        properties: {
          description: ruleSshName
          protocol: 'tcp'
          sourcePortRange: any
          destinationPortRange: SshPort
          sourceAddressPrefix: any
          destinationAddressPrefix: any
          access: 'Allow'
          priority: ruleSshPriority
          direction: 'Inbound'
       
        }
      }
    ]
    
  }
}
