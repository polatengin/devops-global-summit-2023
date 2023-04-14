BeforeAll {
  Import-Module ../../BenchPress/BenchPress.Azure.psd1
}

Describe 'Verify Data Factory layer' {
  it 'Should contain the resource' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "datafactory-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPDataFactory -Name "$name" -ResourceGroupName "$rgName"

    #assert
    $result | Should -BeSuccessful
  }

  it 'Should contain the data lake storage with disabled public network access' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "datafactory-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPDataFactory -Name "$name" -ResourceGroupName "$rgName"

    #assert
    $result.ResourceDetails.PublicNetworkAccess | Should -Be $null
  }
}
