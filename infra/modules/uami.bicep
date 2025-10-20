// Create user-assigned managed identity inside the newly created resource group
@description('Azure Region')
param location string = 'westeurope'

@description('Name of the User Assigned Managed Identity')
param name string = 'uami-demo-001'

resource uami 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: name
  location: location
}
