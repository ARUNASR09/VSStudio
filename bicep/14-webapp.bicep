resource asp1 'Microsoft.Web/serverfarms@2025-03-01' = {
  name: 'asp-cus-dev-01'
  location: 'centralus'
  kind : 'linux'
  sku: {
    name: 'F1'
    capacity: 1
  }
  properties:{
     reserved:true
  }
}

resource webApplication 'Microsoft.Web/sites@2025-03-01' = {
  name: 'app-web-cus-dev-01'
  location: resourceGroup().location
  kind:'app,linux'
  properties: {
     serverFarmId: asp1.id
     siteConfig:{
      linuxFxVersion:'PHP|8.4'
    }
  }
}

