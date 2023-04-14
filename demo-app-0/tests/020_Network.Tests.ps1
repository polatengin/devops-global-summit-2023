BeforeAll {
  Import-Module ../../BenchPress/BenchPress.Azure.psd1
}

Describe 'Verify Network Layer' {
  it 'Should contain the Storage Account' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "nwstrg$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPStorageAccount -Name "$name" -ResourceGroupName "$rgName"

    #assert
    $result | Should -BeSuccessful
  }

  it 'Should contain the Storage Account in Standard_LRS Sku' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "nwstrg$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPStorageAccount -Name "$name" -ResourceGroupName "$rgName"

    #assert
    $result.ResourceDetails.Sku.Name | Should -Be "Standard_LRS"
  }

  it 'Should contain the Storage Account in Hot Access Tier' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "nwstrg$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPStorageAccount -Name "$name" -ResourceGroupName "$rgName"

    #assert
    $result.ResourceDetails.AccessTier | Should -Be "Hot"
  }

  it 'Should contain the Storage Account https traffic only' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "nwstrg$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPStorageAccount -Name "$name" -ResourceGroupName "$rgName"

    #assert
    $result.ResourceDetails.EnableHttpsTrafficOnly | Should -Be $true
  }

  it 'Should contain the Storage Account minimum tls version TLS1.2' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "nwstrg$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPStorageAccount -Name "$name" -ResourceGroupName "$rgName"

    #assert
    $result.ResourceDetails.MinimumTlsVersion | Should -Be "TLS1_2"
  }
}
