targetScope = 'subscription'

param appName string = 'iac-demo'
param location string = 'westeurope'

var resourceGroupName = 'rg-${appName}'

resource rg 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: resourceGroupName
  location: location
}

var uniqueResourceGroupId = uniqueString(rg.id)

var naming object = {
  uami: 'uami-${uniqueResourceGroupId}'
  vault: 'kv-${uniqueResourceGroupId}'
}

// Create user-assigned managed identity inside the newly created resource group
module uami 'modules/uami.bicep' = {
    scope: rg
    params: {
        name: naming.uami
    }
}

module vault 'modules/key-vault.bicep' = {
  scope: rg
  params: {
    name: naming.vault
  }
}

module roleAssignment 'modules/role-assignment.bicep' = {
  scope: rg
  params: {
    naming:naming
  }
  dependsOn: [ uami, vault ]
}
