param resourceSuffix string
param location string

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: 'cosmos-${resourceSuffix}'
  location: location
  kind: 'GlobalDocumentDB'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
  }
}
