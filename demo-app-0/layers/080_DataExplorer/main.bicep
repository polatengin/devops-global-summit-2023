param resourceSuffix string
param location string

resource adxCluster 'Microsoft.Kusto/Clusters@2022-11-11' = {
  name: 'adx-${resourceSuffix}'
  location: location
  sku: {
    capacity: 1
    name: 'Dev(No SLA)_Standard_D11_v2'
    tier: 'Basic'
  }
  identity: {
    type: 'None'
  }
  properties: {
    enableAutoStop: false
  }
}

resource database 'Microsoft.Kusto/clusters/databases@2022-11-11' = {
  name: 'database-${resourceSuffix}'
  parent: adxCluster
  location: location
  kind: 'ReadWrite'
  properties: {
    hotCachePeriod: 'P30D'
    softDeletePeriod: 'P30D'
  }
}
