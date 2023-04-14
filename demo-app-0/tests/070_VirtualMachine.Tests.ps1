BeforeAll {
  Import-Module ../../BenchPress/BenchPress.Azure.psd1
}

Describe 'Verify Virtual Machine layer' {
  it 'Should contain the virtual machine' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "vm-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName "$rgName" -VirtualMachineName "$name"

    #assert
    $result | Should -BeSuccessful
  }

  it 'Should contain the virtual machines with Standard_D1_v2 VmSize' {
    #arrange
    $rgName = "rg-$env:RESOURCE_SUFFIX"
    $name = "vm-$env:RESOURCE_SUFFIX"

    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName "$rgName" -VirtualMachineName "$name"

    #assert
    $result.ResourceDetails.HardwareProfile.VmSize | Should -Be "Standard_D1_v2"
  }
}
