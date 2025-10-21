targetScope = 'resourceGroup'

var rg = resourceGroup()

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
