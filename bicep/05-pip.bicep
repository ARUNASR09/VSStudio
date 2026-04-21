resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2025-01-01' = {
  name: 'pip-eus-dev-01'
  location: 'eastus'
  sku:{name:'Standard'}
  properties: {
    publicIPAllocationMethod: 'Static'

  }
}
