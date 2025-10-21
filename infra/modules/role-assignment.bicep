targetScope = 'resourceGroup'

param naming object


resource uami 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31'  existing = {
  name: naming.uami
}

resource vault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: naming.vault
}

resource secretsOfficerRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: 'b86a8fe4-44ce-4948-aee5-eccb2c155cd7' // Key Vault Secrets Officer
  scope: vault
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(vault.id, uami.id, secretsOfficerRoleDefinition.id)
  scope: vault
  properties: {
    roleDefinitionId: secretsOfficerRoleDefinition.id
    principalId: uami.properties.principalId
    principalType: 'ServicePrincipal'
  }
}
