BeforeAll {
  Import-Module ../../BenchPress/BenchPress.Azure.psd1
}

Describe 'Verify Resource Group' {
  it 'Should contain the Resource Group' {
    #arrange
    $rgName = "$env:RESOURCE_GROUP_NAME"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName "$rgName"

    #assert
    $result | Should -BeSuccessful
  }

  it 'Should contain the Resource Group in the correct location' {
    #arrange
    $rgName = "$env:RESOURCE_GROUP_NAME"
    $location = "$env:LOCATION_NAME"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName "$rgName"

    #assert
    $result | Should -BeInLocation $location
  }

  it 'Should contain the Resource Group in Succeeded Provisioning State' {
    #arrange
    $rgName = "$env:RESOURCE_GROUP_NAME"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName "$rgName"

    #assert
    $result.ResourceDetails.ProvisioningState | Should -Be "Succeeded"
  }

  it 'Should the Resource Group has Tags' {
    #arrange
    $rgName = "$env:RESOURCE_GROUP_NAME"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName "$rgName"

    #assert
    $result.ResourceDetails.Tags | Should -Not -Be $null
  }

  it 'Should the Resource Group has correct Tag assigned' {
    #arrange
    $rgName = "$env:RESOURCE_GROUP_NAME"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName "$rgName"

    #assert
    $result.ResourceDetails.Tags["app"] | Should -Be "devops-global-summit"
  }

  it 'Should the Resource Group has correct Tag assigned' {
    #arrange
    $rgName = "$env:RESOURCE_GROUP_NAME"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName "$rgName"

    #assert
    $result.ResourceDetails.Tags["year"] | Should -Be "2023"
  }
}

AfterAll {
}
