targetScope = 'subscription'

param resourceGroupName string
param resourceGroupLocation string

resource new_rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
  tags: {
    app: 'devops-global-summit'
    year: '2023'
  }
}

output resourceGroupName string = new_rg.name
