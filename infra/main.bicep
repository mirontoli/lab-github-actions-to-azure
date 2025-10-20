targetScope = 'subscription'

param appName string = 'iac-demo'
param location string = 'westeurope'

var resourceGroupName = 'rg-${appName}'

resource newRG 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: resourceGroupName
  location: location
}

// Create user-assigned managed identity inside the newly created resource group
module uami 'modules/uami.bicep' = {
    scope: newRG
    params: {
        location:newRG.location
        name: 'uami-demo-001'
    }
}
