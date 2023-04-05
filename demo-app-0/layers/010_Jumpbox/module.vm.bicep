@description('Username for the Virtual Machine.')
param adminUsername string

@description('Password for the Virtual Machine.')
@minLength(12)
@secure()
param adminPassword string

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Name of the virtual machine.')
param vmName string = 'simple-vm'

param addressPrefix string = '10.0.0.0/16'
param subnetPrefix string = '10.0.0.0/24'

var storageAccountName = 'jumpboxbootdiags${substring(uniqueString(resourceGroup().id), 0, 8)}'
var nicName = '${vmName}-nic'
var subnetName = 'Subnet'
var virtualNetworkName = '${vmName}-vnet'
var networkSecurityGroupName = '${vmName}-nsg'

resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}

resource securityGroup 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-3389'
        properties: {
          priority: 1000
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '3389'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
          networkSecurityGroup: {
            id: securityGroup.id
          }
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, subnetName)
          }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D1_v2'
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_ZRS'
        }
      }
      dataDisks: [
        {
          diskSizeGB: 1023
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: stg.properties.primaryEndpoints.blob
      }
    }
  }
}

resource vmAutoShutdownExtension 'Microsoft.DevTestLab/schedules@2018-09-15' = {
  // name of this resource should be EXACTLY "shutdown-computevm-<vmName>"
  // DO NOT CHANGE THIS NAME 🤦‍♂️
  // https://stackoverflow.com/questions/70740224/getting-error-the-schedule-should-be-created-while-creating-vm-shutdown-schedu
  name: 'shutdown-computevm-${vmName}'
  location: location
  properties: {
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    dailyRecurrence: {
      time: '1900'
    }
    timeZoneId: 'Pacific Standard Time'
    notificationSettings: {
      status: 'Disabled'
      timeInMinutes: 15
    }
    targetResourceId: vm.id
  }
}

resource bastionPublicIp 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'vm-bastion-pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource bastionNSG 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: 'vm-bastion-nsg'
  location:location
  properties:{
    securityRules:[
      {
        name: 'AllowGatewayManagerInbound'
        properties:{
          protocol:'Tcp'
          direction:'Inbound'
          access:'Allow'
          sourceAddressPrefix: 'GatewayManager'
          destinationPortRanges:[
            '443'
          ]
          priority: 110
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
        }
      }
      {
        name: 'AllowAzureLoadBalancerInbound'
        properties:{
          protocol:'Tcp'
          direction:'Inbound'
          access:'Allow'
          sourceAddressPrefix: 'AzureLoadBalancer'
          destinationPortRanges:[
            '443'
          ]
          priority: 120
          destinationAddressPrefix: '*'
          sourcePortRange: '*'
        }
      }
      {
        name: 'AllowBastionHostCommunication'
        properties:{
          protocol:'*'
          direction:'Inbound'
          access:'Allow'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationPortRanges:[
            '8080'
            '5701'
          ]
          priority: 130
          destinationAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
        }
      }
      {
        name: 'AllowSshRdpOutbound'
        properties:{
          protocol:'Tcp'
          direction:'Outbound'
          access:'Allow'
          sourceAddressPrefix: '*'
          destinationPortRanges:[
            '22'
            '3389'
          ]
          priority: 100
          destinationAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
        }
      }
      {
        name: 'AllowAzureCloudOutbound'
        properties:{
          protocol:'Tcp'
          direction:'Outbound'
          access:'Allow'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: 'AzureCloud'
          destinationPortRange: '443'
          priority: 110
        }
      }
      {
        name: 'AllowBastionCommunication'
        properties:{
          protocol:'Tcp'
          direction:'Outbound'
          access:'Allow'
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          destinationAddressPrefix: 'VirtualNetwork'
          destinationPortRange: '*'
          priority: 120
        }
      }
      {
        name: 'AllowGetSessionInformation'
        properties:{
          protocol:'*'
          direction:'Outbound'
          access:'Allow'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: 'Internet'
          destinationPortRange: '80'
          priority: 130
        }
      }
    ]
  }
}
