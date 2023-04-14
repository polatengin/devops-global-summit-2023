BeforeAll {
  Import-Module ../../BenchPress/BenchPress.Azure.psd1
}

Describe 'Verify KeyVault layer' {
  it 'Should contain the KeyVault' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "keyvault-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName "$rgName" -Name "$name"

    #assert
    $result | Should -BeSuccessful
  }

  it 'Should contain the KeyVault with Standard Sku' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "keyvault-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName "$rgName" -Name "$name"

    #assert
    $result.ResourceDetails.Sku | Should -Be "Standard"
  }

  it 'Should contain the KeyVault with soft delete enabled' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "keyvault-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName "$rgName" -Name "$name"

    #assert
    $result.ResourceDetails.EnableSoftDelete | Should -Be $true
  }

  it 'Should contain the KeyVault with purge protection disabled' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "keyvault-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName "$rgName" -Name "$name"

    #assert
    $result.ResourceDetails.EnablePurgeProtection | Should -Be $null
  }

  it 'Should contain the KeyVault with public network access enabled' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "keyvault-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName "$rgName" -Name "$name"

    #assert
    $result.ResourceDetails.PublicNetworkAccess | Should -Be "Enabled"
  }
}
