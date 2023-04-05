param resourceSuffix string
param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: 'storage${resourceSuffix}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  name: '${storageAccount.name}/default/input'
  properties: {
    publicAccess: 'None'
  }
}

resource dataFactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: 'datafactory-${resourceSuffix}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

resource linkedService 'Microsoft.DataFactory/factories/linkedservices@2018-06-01' = {
  parent: dataFactory
  name: 'linkedService-${resourceSuffix}'
  properties: {
    type: 'AzureBlobStorage'
    typeProperties: {
      connectionString: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};AccountKey=${storageAccount.listKeys().keys[0].value}'
    }
  }
}
