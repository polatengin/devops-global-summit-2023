param resourceSuffix string
param location string

resource vnet 'Microsoft.Network/virtualNetworks@2022-09-01' = {
  name: 'vnet-${resourceSuffix}'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
  }
}

resource virtualNetworkSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: 'vnetsubnet-${resourceSuffix}'
  parent: vnet
  properties: {
    addressPrefix: '10.1.0.0/16'
  }
}

resource networkWatcherStorage 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: 'nwstrg${resourceSuffix}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: false
    supportsHttpsTrafficOnly: true
  }
}

resource blob 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  name: 'default'
  parent: networkWatcherStorage
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  name: 'input'
  parent: blob
  properties: {
    publicAccess: 'None'
  }
}

resource table 'Microsoft.Storage/storageAccounts/tableServices@2021-09-01' = {
  name: 'default'
  parent: networkWatcherStorage
}

resource tableContainer 'Microsoft.Storage/storageAccounts/tableServices/tables@2021-09-01' = {
  name: 'input'
  parent: table
}
