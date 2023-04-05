targetScope = 'subscription'

param resourceGroupName string
param addressPrefix string = '10.1.0.0/16'
param subnetPrefix string = '10.1.0.0/24'
param adminUsername string = 'adminUser'
param vmName string = 'jumpbox-vm'
@secure()
param adminPassword string = newGuid()

param resourceGroupLocation string = deployment().location

module resource_group 'module.resource-group.bicep' = {
  name: 'resource-group-${resourceGroupName}'
  params: {
    resourceGroupName: resourceGroupName
    resourceGroupLocation: resourceGroupLocation
  }
  scope: subscription()
}

module vm 'module.vm.bicep' = {
  name: 'vm-${vmName}'
  params: {
    vmName: vmName
    adminUsername: adminUsername
    adminPassword: adminPassword
    location: resourceGroupLocation
    addressPrefix: addressPrefix
    subnetPrefix: subnetPrefix
  }
  scope: resourceGroup(resourceGroupName)
  dependsOn: [
    resource_group
  ]
}
