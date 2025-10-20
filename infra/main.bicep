targetScope = 'subscription'

param appName string = 'iac-demo'
param location string = 'westeurope'

var resourceGroupName = 'rg-${appName}'

resource newRG 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: resourceGroupName
  location: location
}
