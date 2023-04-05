BeforeAll {
  Import-Module "../BenchPress/BenchPress.Azure.psd1"
}

Describe 'Resource Group Tests' {
  it 'Should contain a resource group with the given name' {
    #arrange
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

    #assert
    $result | Should -BeSuccessful
  }
}

Describe 'Service Plan Tests' {
  it 'Should contain a service plan with the given name' {
    #arrange
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"
    $svcPlanName = "benchpress-hosting-plan-${env:ENVIRONMENT_SUFFIX}"

    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $svcPlanName

    #assert
    $result | Should -BeSuccessful
  }
}

Describe 'Action Group Tests' {
  it 'Should contain an email action group with the given name' {
    #arrange
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"
    $agName = "benchpress-email-action-group-${env:ENVIRONMENT_SUFFIX}"

    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $agName

    #assert
    $result | Should -BeSuccessful
  }
}

Describe 'Web Apps Tests' {
  it 'Should contain a web app with the given name' {
    #arrange
    $webAppName = "benchpress-web-${env:ENVIRONMENT_SUFFIX}"
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"

    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $result | Should -BeSuccessful
  }

  it 'Should have the web app availability state as normal' {
    #arrange
    $webAppName = "benchpress-web-${env:ENVIRONMENT_SUFFIX}"
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"

    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $result.ResourceDetails.AvailabilityState | Should -Be "Normal"
  }

  it 'Should have the web app works https only' {
    #arrange
    $webAppName = "benchpress-web-${env:ENVIRONMENT_SUFFIX}"
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"

    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $result.ResourceDetails.HttpsOnly | Should -Be $true
  }

  it 'Should contain configuration in the web app' {
    #arrange
    $webAppName = "benchpress-web-${env:ENVIRONMENT_SUFFIX}"
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"

    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $result.ResourceDetails.SiteConfig.AppSettings | Should -Be -Not $null
  }

  it 'Should running' {
    #arrange
    $webAppName = "benchpress-web-${env:ENVIRONMENT_SUFFIX}"
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"

    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $result.ResourceDetails.State | Should -Be "Running"
  }
}

Describe 'Deployed App Tests' {
  it 'Should return 200' {
    #arrange
    $webAppName = "benchpress-web-${env:ENVIRONMENT_SUFFIX}"

    #act
    $result = Invoke-WebRequest -Uri "https://${webAppName}.azurewebsites.net"

    #assert
    $result.StatusCode | Should -Be 200
  }

  it 'Should have content' {
    #arrange
    $webAppName = "benchpress-web-${env:ENVIRONMENT_SUFFIX}"

    #act
    $result = Invoke-WebRequest -Uri "https://${webAppName}.azurewebsites.net"

    #assert
    $result.Content | Should -Be -Not $null
  }
}

AfterAll {
  Get-Module BenchPress.Azure | Remove-Module
}
