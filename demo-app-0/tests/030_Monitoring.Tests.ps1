BeforeAll {
  Import-Module ../../BenchPress/BenchPress.Azure.psd1
}

Describe 'Verify Monitoring layer' {
  it 'Should contain the Log Analytics Workspace' {
    #arrange
    $rgName = "$env:RESOURCE_GROUP_NAME"
    $name = "logAnalyticsWorkspace-$env:RESOURCE_SUFFIX"

    #act
    $resource = Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName "$rgName" -Name "$name"

    #assert
    $resource | Should -BeSuccessful
  }

  it 'Should contain the Log Analytics Workspace with Sku PerGB2018' {
    #arrange
    $rgName = "$env:RESOURCE_GROUP_NAME"
    $name = "logAnalyticsWorkspace-$env:RESOURCE_SUFFIX"

    #act
    $resource = Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName "$rgName" -Name "$name"

    #assert
    $resource.ResourceDetails.Sku | Should -Be "PerGB2018"
  }

  it 'Should contain the Log Analytics Workspace with retentionInDays 30' {
    #arrange
    $rgName = "$env:RESOURCE_GROUP_NAME"
    $name = "logAnalyticsWorkspace-$env:RESOURCE_SUFFIX"

    #act
    $resource = Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName "$rgName" -Name "$name"

    #assert
    $resource.ResourceDetails.retentionInDays | Should -Be "30"
  }
}
