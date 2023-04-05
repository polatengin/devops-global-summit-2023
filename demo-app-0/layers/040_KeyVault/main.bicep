param resourceSuffix string
param location string

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'keyvault-${resourceSuffix}'
  location: location
  properties: {
    enableRbacAuthorization: true
    tenantId: tenant().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
  }
}
