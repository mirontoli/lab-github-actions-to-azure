
targetScope = 'resourceGroup'

// Create user-assigned managed identity inside the newly created resource group
@description('Azure Region')
param location string = resourceGroup().location

@description('Name of the User Assigned Managed Identity')
param name string

resource uami 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: name
  location: location
}
