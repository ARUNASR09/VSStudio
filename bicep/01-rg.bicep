targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: 'rg-az104-cus-dev'
  location: 'centralus'
}
