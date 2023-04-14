BeforeAll {
  Import-Module ../../BenchPress/BenchPress.Azure.psd1
}

Describe 'Verify Web App layer' {
  it 'Should contain the service plan' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "plan-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName "$rgName" -AppServicePlanName "$name"

    #assert
    $result | Should -BeSuccessful
  }

  it 'Should contain the service plan with spot instances disabled' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "plan-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName "$rgName" -AppServicePlanName "$name"

    #assert
    $result.ResourceDetails.IsSpot | Should -Be $false
  }

  it 'Should contain the service plan with reserved instances disabled' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "plan-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName "$rgName" -AppServicePlanName "$name"

    #assert
    $result.ResourceDetails.Reserved | Should -Be $false
  }

  it 'Should contain the service plan with dynamic tier' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "plan-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName "$rgName" -AppServicePlanName "$name"

    #assert
    $result.ResourceDetails.Sku.Tier | Should -Be "Dynamic"
  }

  it 'Should contain the service plan with Y1 size' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "plan-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName "$rgName" -AppServicePlanName "$name"

    #assert
    $result.ResourceDetails.Sku.Size | Should -Be "Y1"
  }

  it 'Should contain the service plan with functionapp kind' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "plan-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName "$rgName" -AppServicePlanName "$name"

    #assert
    $result.ResourceDetails.Kind | Should -Be "functionapp"
  }

  it 'Should contain the resource' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "functionapp-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName "$rgName" -WebAppName "$name"

    #assert
    $result | Should -BeSuccessful
  }

  it 'Should contain the resource with httpsonly enabled' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "functionapp-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName "$rgName" -WebAppName "$name"

    #assert
    $result.ResourceDetails.HttpsOnly | Should -Be $true
  }
}
