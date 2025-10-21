targetScope = 'resourceGroup'
param location string = resourceGroup().location
param name string


resource vault 'Microsoft.KeyVault/vaults@2025-05-01' = {
  location: location
  name: name
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: true
  }
}
