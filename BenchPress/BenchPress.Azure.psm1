# file Modules/BenchPress.Azure/Classes/AuthenticationData.psm1
class AuthenticationData {
  [string]$SubscriptionId

  AuthenticationData([string]$SubscriptionId) {
    $this.SubscriptionId = $SubscriptionId
  }
}
# file Modules/BenchPress.Azure/Classes/AuthenticationResult.psm1

class AuthenticationResult {
  [boolean]$Success
  [AuthenticationData]$AuthenticationData
}
# file Modules/BenchPress.Azure/Classes/ConfirmResult.psm1

class ConfirmResult {
  [boolean]$Success = $false
  [System.Object]$ResourceDetails
  [string]$AuthenticationData

  ConfirmResult([System.Object]$Resource, [AuthenticationData]$AuthenticationData) {
    $this.Success = -not $null -eq $Resource
    $this.ResourceDetails = $Resource
    $this.AuthenticationData = $AuthenticationData
  }

  ConfirmResult([AuthenticationData]$AuthenticationData) {
    $this.AuthenticationData = $AuthenticationData
  }
}
# file Modules/BenchPress.Azure/Classes/ResourceType.psm1
enum ResourceType{
  ActionGroup
  AksCluster
  ApiManagement
  ApiManagementApi
  ApiManagementDiagnostic
  ApiManagementLogger
  ApiManagementPolicy
  AppInsights
  AppServicePlan
  ContainerApp
  CosmosDBAccount
  CosmosDBGremlinDatabase
  CosmosDBMongoDBDatabase
  CosmosDBSqlDatabase
  ContainerRegistry
  DataFactory
  DataFactoryLinkedService
  EventHub
  EventHubConsumerGroup
  EventHubNamespace
  KeyVault
  OperationalInsightsWorkspace
  ResourceGroup
  RoleAssignment
  SqlDatabase
  SqlServer
  StorageAccount
  StorageContainer
  StreamAnalyticsCluster
  StreamAnalyticsFunction
  StreamAnalyticsInput
  StreamAnalyticsJob
  StreamAnalyticsOutput
  StreamAnalyticsTransformation
  SynapseSparkPool
  SynapseSqlPool
  SynapseWorkspace
  VirtualMachine
  WebApp
}
# file Modules/BenchPress.Azure/Public/Confirm-ActionGroup.ps1

function Confirm-ActionGroup {
  <#
    .SYNOPSIS
      Confirms that an Action Group exists.

    .DESCRIPTION
      The Confirm-AzBPActionGroup cmdlet gets an action group using the specified Action Group and Resource Group name.

    .PARAMETER ActionGroupName
      The name of the Azure Action Group

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPActionGroup -ActionGroupName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ActionGroupName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzActionGroup -ResourceGroupName $ResourceGroupName -Name $ActionGroupName

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-AksCluster.ps1

function Confirm-AksCluster {
  <#
    .SYNOPSIS
      Confirms that an AKS Cluster exists.

    .DESCRIPTION
      The Confirm-AzBPAksCluster cmdlet gets an AKS cluster using the specified AKS Cluster and Resource Group name.

    .PARAMETER AKSName
      The name of the AKS Cluster

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPAksCluster -AKSName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$AksName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzAksCluster -ResourceGroupName $ResourceGroupName -Name $AksName

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-ApiManagement.ps1

function Confirm-ApiManagement {
  <#
    .SYNOPSIS
      Confirms that an API Management Service exists.

    .DESCRIPTION
      The Confirm-AzBPApiManagement cmdlet gets an API Management Service using the specified API Management Service
      and Resource Group names.

    .PARAMETER ResourceGroupName
      Specifies the name of the resource group under in which this cmdlet gets the API Management service.

    .PARAMETER Name
      Specifies the name of API Management service.

    .EXAMPLE
      Confirm-AzBPApiManagement -ResourceGroupName "rgbenchpresstest" -Name "benchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Process {
    $Resource = Get-AzApiManagement -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-ApiManagementApi.ps1

function Confirm-ApiManagementApi {
  <#
    .SYNOPSIS
      Confirms that an API Management API exists.

    .DESCRIPTION
      The Confirm-AzBPApiManagementApi cmdlet gets an API Management API using the specified API, API Management
      Service, and Resource Group names.

    .PARAMETER ResourceGroupName
      Specifies the name of the resource group under which an API Management service is deployed.

    .PARAMETER ServiceName
      Specifies the name of the deployed API Management service.

    .PARAMETER Name
      Specifies the name of the API to get.

    .EXAMPLE
      Confirm-AzBPApiManagementApi -ResourceGroupName "rgbenchpresstest" -ServiceName "servicetest" -Name "benchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$ServiceName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Process {
    $Resource = New-AzApiManagementContext -ResourceGroupName $ResourceGroupName -ServiceName $ServiceName
      | Get-AzApiManagementApi -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-ApiManagementDiagnostic.ps1

function Confirm-ApiManagementDiagnostic {
  <#
    .SYNOPSIS
      Confirms that an API Management Diagnostic exists.

    .DESCRIPTION
      The Confirm-AzBPApiManagementDiagnostic cmdlet gets an API Management Diagnostic using the specified API
      Diagnostic, API, API Management Service, and Resource Group names.

    .PARAMETER ResourceGroupName
      Specifies the name of the resource group under which an API Management service is deployed.

    .PARAMETER ServiceName
      Specifies the name of the deployed API Management service.

    .PARAMETER Name
      Identifier of existing diagnostic. This will return product-scope policy. This parameters is required.

    .EXAMPLE
      Confirm-AzBPApiManagementDiagnostic -ResourceGroupName "rgbenchpresstest" -ServiceName "servicetest" `
        -Name "benchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$ServiceName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Process {
    $Resource = New-AzApiManagementContext -ResourceGroupName $ResourceGroupName -ServiceName $ServiceName
      | Get-AzApiManagementDiagnostic -DiagnosticId $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-ApiManagementLogger.ps1

function Confirm-ApiManagementLogger {
  <#
    .SYNOPSIS
      Confirms that an API Management Logger exists.

    .DESCRIPTION
      The Confirm-AzBPApiManagementLogger cmdlet gets an API Management Logger using the specified Logger, API
      Management Service, and Resource Group names.

    .PARAMETER ResourceGroupName
      Specifies the name of the resource group under which an API Management service is deployed.

    .PARAMETER ServiceName
      Specifies the name of the deployed API Management service.

    .PARAMETER Name
      Specifies the ID of the specific logger to get.

    .EXAMPLE
      Confirm-AzBPApiManagementLogger -ResourceGroupName "rgbenchpresstest" -ServiceName "servicetest" `
        -Name "benchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$ServiceName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Process {
    # Unlike the other Get-AzApiManagement* cmdlets Get-AzApiManagementLogger does not accept piping of the context
    $Context = New-AzApiManagementContext -ResourceGroupName $ResourceGroupName -ServiceName $ServiceName
    $Resource = Get-AzApiManagementLogger -Context $Context -LoggerId $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-ApiManagementPolicy.ps1

function Confirm-ApiManagementPolicy {
  <#
    .SYNOPSIS
      Confirms that an API Management Policy exists.

    .DESCRIPTION
      The Confirm-AzBPApiManagementPolicy cmdlet gets an API Management Policy using the specified API, API Management
      Service, and Resource Group names.

    .PARAMETER ResourceGroupName
      Specifies the name of the resource group under which an API Management service is deployed.

    .PARAMETER ServiceName
      Specifies the name of the deployed API Management service.

    .PARAMETER ApiId
      Specifies the identifier of the existing API. This cmdlet returns the API-scope policy.

    .EXAMPLE
      Confirm-AzBPApiManagementPolicy -ResourceGroupName "rgbenchpresstest" -ServiceName "servicetest" `
        -ApiId "benchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$ServiceName,

    [Parameter(Mandatory=$true)]
    [string]$ApiId
  )
  Process {
    $policy = New-AzApiManagementContext -ResourceGroupName $ResourceGroupName -ServiceName $ServiceName
      | Get-AzApiManagementPolicy -ApiId $ApiId

    # Get-AzApiManagementPolicy returns the XML for a policy, not a resource
    if ([string]::IsNullOrWhiteSpace($policy)) {
      $policy = $null
    }

    [ConfirmResult]::new($policy, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-AppInsights.ps1

function Confirm-AppInsights {
  <#
    .SYNOPSIS
      Confirms that an Application Insights exists.

    .DESCRIPTION
      The Confirm-AzBPAppInsights cmdlet gets an Application Insights using the specified Application Insights name
      and Resource Group name.

    .PARAMETER Name
      The name of the Application Insights

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPAppInsights -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '',
  Justification='App Insights is a name of an Azure resource and is not a plural noun')]
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzApplicationInsights -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-AppServicePlan.ps1

function Confirm-AppServicePlan {
  <#
    .SYNOPSIS
      Confirms that an App Service Plan exists.

    .DESCRIPTION
      The Confirm-AzBPAppServicePlan cmdlet gets an App Service Plan using the specified App Service Plan and
      Resource Group name.

    .PARAMETER AppServicePlanName
      The name of the App Service Plan

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPAppServicePlan -AppServicePlanName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$AppServicePlanName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlanName

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-BicepFile.ps1

function Confirm-BicepFile {
  <#
    .SYNOPSIS
      Confirm-AzBPBicepFile will confirm that the bicep files provided pass the checks executed by `bicep build`.

    .DESCRIPTION
      Confirm-AzBPBicepFile executes `bicep build` and returns an object that has an array field Errors. Each element
      of this array is an object that contains the bicep file path that had errors and a collection of
      System.Object.ErrorRecord that correspond to the file at that path:

      {Errors: [
          {Path: [string], ErrorResults: [ErrorRecord[]]}, {Path: [string], ErrorResults: [ErrorRecord[]]}, ...
        ]}

      Any errors will also be output to stdout for capture by CI/CD pipelines.

    .PARAMETER BicepPath
      This is the path to the bicep file that will be confirmed.
      BicepPath is a mandatory parameter.
      The property name is optional if the path is provided as the first argument to Confirm-AzBPBicepFile.

    .EXAMPLE
      Pipe path into Confirm-AzBPBicepFile

      "./examples/actionGroupErrors.bicep" | Confirm-AzBPBicepFile

      Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
      Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
      Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
      0

      Errors
      -----------
      {@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection`1[System.Management.Automation.PSObject]...

    .EXAMPLE
      Pipe multiple paths into Confirm-AzBPBicepFile

      "./examples/actionGroupErrors.bicep", "./examples/actionGroupErrors.bicep" | Confirm-AzBPBicepFile

      Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
      Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
      Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
      0
      Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
      Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
      Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
      1

      Errors
      -----------
      {@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection`1[System.Management.Automation.PSObject]...

    .EXAMPLE
      Provide -BicepPath Parameter

      Confirm-AzBPBicepFile -BicepPath ./examples/actionGroupErrors.bicep

      Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
      Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
      Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
      0

      Errors
      -----------
      {@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection`1[System.Management.Automation.PSObject]...

    .EXAMPLE
        Path without -BicepPath Parameter

      Confirm-AzBPBicepFile ./examples/actionGroupErrors.bicep

      Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
      Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
      Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
      0

      Errors
      -----------
      {@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection`1[System.Management.Automation.PSObject]...

    .INPUTS
      System.String[]

    .OUTPUTS
      System.Management.Automation.PSCustomObject[]
  #>
  [CmdletBinding()]
  [OutputType([System.Object[]])]
  param(
    [Parameter(Mandatory, Position=0, ValueFromPipeline)] [string[]]$BicepFilePath
  )
  Begin{
    $out = [PSCustomObject]@{
      Errors = New-Object System.Collections.ArrayList
    }
  }
  Process {
    foreach ($path in $BicepFilePath) {
      # The --stdout parameter will send the built ARM template to stdout instead of creating a file
      # 2>&1 will send errors to stdout so that they can be captured by PowerShell
      # Both the ARM template and any output from linting will be in the array $results, with individual errors in the
      # array separately
      $results = Invoke-Command -ScriptBlock { bicep build $path --stdout 2>&1 }
      # .Where() returns a collection of System.Management.Automation.ErrorRecord or null if there are no errors
      $errorResults = $results.Where({$PSItem.GetType().Name -eq 'ErrorRecord'})

      if ($errorResults.Count -gt 0) {
        Write-Error "${path}:"
        $errorResults | Write-Error

        $out.Errors.Add([PSCustomObject]@{Path = $path; ErrorResults = $errorResults})
      }
    }
  }
  End {
    $out
  }
}
# file Modules/BenchPress.Azure/Public/Confirm-ContainerApp.ps1

function Confirm-ContainerApp {
  <#
    .SYNOPSIS
      Confirms that a Container Application exists.

    .DESCRIPTION
      The Confirm-AzBPContainerApp cmdlet gets a Container Application using the specified Container Application and
      Resource Group name.

    .PARAMETER Name
      The name of the Container Application

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPContainerApp -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzContainerApp -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-ContainerRegistry.ps1

function Confirm-ContainerRegistry {
  <#
    .SYNOPSIS
      Confirms that a Container Registry exists.

    .DESCRIPTION
      The Confirm-AzBPContainerRegistry cmdlet gets a Container Registry using the specified Container Registry and
      Resource Group name.

    .PARAMETER Name
      The name of the Container Registry

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPContainerRegistry -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzContainerRegistry -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-CosmosDBAccount.ps1

function Confirm-CosmosDBAccount {
  <#
    .SYNOPSIS
      Confirms that a Cosmos DB Account exists.

    .DESCRIPTION
      The Confirm-AzBPCosmosDBAccount cmdlet gets Cosmos DB Account given the Resource Group Name and the name of the
      Cosmos DB Account.

    .PARAMETER ResourceGroupName
      The name of the Resource Group.

    .PARAMETER Name
      The Cosmos DB account name.

    .EXAMPLE
      Confirm-AzBPCosmosDBAccount -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Process {
    $Resource = Get-AzCosmosDBAccount -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-CosmosDBGremlinDatabase.ps1

function Confirm-CosmosDBGremlinDatabase {
  <#
    .SYNOPSIS
      Confirms that a Cosmos DB Gremlin Database exists.

    .DESCRIPTION
      The Confirm-AzBPCosmosDBGremlinDatabase cmdlet gets Cosmos DB Gremlin database given the Resource Group Name, the
      name of the Cosmos DB Account, and the name of the Gremlin Database.

    .PARAMETER ResourceGroupName
      The name of the Resource Group.

    .PARAMETER AccountName
      The Cosmos DB account name.

    .PARAMETER Name
      The name of the Cosmos DB Gremlin Database

    .EXAMPLE
      Confirm-AzBPCosmosDBGremlinDatabase -ResourceGroupName "rgbenchpresstest" -AccountName "an" -Name "gremlindb"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$AccountName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Process {
    $params = @{
      ResourceGroupName = $ResourceGroupName
      AccountName       = $AccountName
      Name              = $Name
    }
    $Resource = Get-AzCosmosDBGremlinDatabase @params

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-CosmosDBMongoDBDatabase.ps1

function Confirm-CosmosDBMongoDBDatabase {
  <#
    .SYNOPSIS
      Confirms that a Cosmos DB Mongo DB Database exists.

    .DESCRIPTION
      The Confirm-CosmosDBMongoDBDatabase cmdlet gets Cosmos DB Mongo DB database given the Resource Group Name, the
      name of the Cosmos DB Account, and the name of the Mongo DB Database.

    .PARAMETER ResourceGroupName
      The name of the Resource Group.

    .PARAMETER AccountName
      The Cosmos DB account name.

    .PARAMETER Name
      The name of the Cosmos DB Mongo DB Database

    .EXAMPLE
      Confirm-AzBPCosmosDBMongoDBDatabase  -ResourceGroupName "rgbenchpresstest" -AccountName "an" -Name "mongodbdb"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$AccountName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Process {
    $params = @{
      ResourceGroupName = $ResourceGroupName
      AccountName       = $AccountName
      Name              = $Name
    }
    $Resource = Get-AzCosmosDBMongoDBDatabase @params

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-CosmosDBSqlDatabase.ps1

function Confirm-CosmosDBSqlDatabase {
  <#
    .SYNOPSIS
      Confirms that a Cosmos DB SQL Database exists.

    .DESCRIPTION
      The Confirm-AzBPCosmosDBSqlDatabase cmdlet gets Cosmos DB Gremlin database given the Resource Group Name, the
      name of the Cosmos DB Account, and the name of the SQL Database.

    .PARAMETER ResourceGroupName
      The name of the Resource Group.

    .PARAMETER AccountName
      The Cosmos DB account name.

    .PARAMETER Name
      The name of the Cosmos DB SQL Database

    .EXAMPLE
      Confirm-AzBPCosmosDBSqlDatabase  -ResourceGroupName "rgbenchpresstest" -AccountName "an" -Name "sqldb"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$AccountName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Process {
    $Resource = Get-AzCosmosDBSqlDatabase -ResourceGroupName $ResourceGroupName -AccountName $AccountName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-DataFactory.ps1

function Confirm-DataFactory {
  <#
    .SYNOPSIS
      Confirms that a Data Factory exists.

    .DESCRIPTION
      The Confirm-AzBPDataFactory cmdlet gets a data factory using the specified Data Factory and
      Resource Group name.

    .PARAMETER Name
      The name of the Data Factory

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPDataFactory -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzDataFactoryV2 -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-DataFactoryLinkedService.ps1

function Confirm-DataFactoryLinkedService {
  <#
    .SYNOPSIS
      Confirms that a Data Factory exists.

    .DESCRIPTION
      The Confirm-AzBPDataFactoryLinkedService cmdlet gets a data factory linked service using the specified
      Data Factory, Linked Service and Resource Group name.

    .PARAMETER Name
      The name of the Linked Service

    .PARAMETER DataFactoryName
      The name of the Data Factory

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPDataFactoryLinkedService -Name "bplinkedservice" -ResourceGroupName "rgbenchpresstest" `
        -DataFactoryName "bpdatafactory"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$DataFactoryName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzDataFactoryV2LinkedService -ResourceGroupName $ResourceGroupName `
      -DataFactoryName $DataFactoryName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-EventHub.ps1

function Confirm-EventHub {
  <#
    .SYNOPSIS
      Confirms that an EventHub exists.

    .DESCRIPTION
      The Confirm-AzBPEventHub cmdlet gets an EventHub using the specified EventHub name, EventHub Namespace,
      and Resource Group name.

    .PARAMETER Name
      The name of the EventHub

    .PARAMETER NamespaceName
      The name of the EventHub Namespace

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPEventHub -Name "bpeventhub" -NamespaceName 'bpeventhubnamespace' -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$NamespaceName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzEventHub -ResourceGroupName $ResourceGroupName -NamespaceName $NamespaceName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-EventHubConsumerGroup.ps1

function Confirm-EventHubConsumerGroup {
  <#
    .SYNOPSIS
      Confirms that an EventHub ConsumerGroup exists.

    .DESCRIPTION
      The Confirm-AzBPEventHubConsumerGroup cmdlet gets an EventHub ConsumerGroup using the specified EventHub ConsumerGroup name,
      EventHub Namespace name, Eventhub name and Resource Group name.

    .PARAMETER Name
      The name of the EventHub ConsumerGroup

    .PARAMETER NamespaceName
      The name of the EventHub Namespace

    .PARAMETER EventHubName
      The name of the EventHub

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPEventHubConsumerGroup -Name 'consumergrouptest' -NamespaceName 'bpeventhubnamespace' -EventHubName 'bpeventhub' -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$NamespaceName,

    [Parameter(Mandatory=$true)]
    [string]$EventHubName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $params = @{
      Name              = $Name
      NamespaceName     = $NamespaceName
      EventHubName      = $EventHubName
      ResourceGroupName = $ResourceGroupName
    }

    $Resource = Get-AzEventHubConsumerGroup @params

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-EventHubNamespace.ps1

function Confirm-EventHubNamespace {
  <#
    .SYNOPSIS
      Confirms that an EventHub Namespace exists.

    .DESCRIPTION
      The Confirm-AzBPEventHubNamespace cmdlet gets an EventHub Namespace using the specified EventHub Namespace name,
      and Resource Group name.

    .PARAMETER NamespaceName
      The name of the EventHub Namespace

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPEventHubNamespace -NamespaceName 'bpeventhubnamespace' -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$NamespaceName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzEventHubNamespace -ResourceGroupName $ResourceGroupName -NamespaceName $NamespaceName

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-KeyVault.ps1

function Confirm-KeyVault {
  <#
    .SYNOPSIS
      Confirms that a Key Vault exists.

    .DESCRIPTION
      The Confirm-AzBPKeyVault cmdlet gets a Key Vault using the specified Key Vault and
      Resource Group name.

    .PARAMETER Name
      The name of the Key Vault

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPKeyVault -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzKeyVault -ResourceGroupName $ResourceGroupName -VaultName $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-KeyVaultCertificate.ps1

function Confirm-KeyVaultCertificate {
  <#
    .SYNOPSIS
      Confirms that a Key Vault Certificate exists.

    .DESCRIPTION
      The Confirm-AzBPKeyVaultCertificate cmdlet gets a Key Vault Certificate using the specified Key Vault and
      Certificate name.

    .PARAMETER Name
      The name of the Certificate

    .PARAMETER KeyVaultName
      The name of the Key Vault

    .EXAMPLE
      Confirm-AzBPKeyVaultCertificate -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$KeyVaultName
  )
  Process {
    $Resource = Get-AzKeyVaultCertificate -Name $Name -VaultName $KeyVaultName

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-KeyVaultKey.ps1

function Confirm-KeyVaultKey {
  <#
    .SYNOPSIS
      Confirms that a Key Vault Key exist.

    .DESCRIPTION
      The Confirm-AzBPKeyVaultKey cmdlet gets a Key Vault Key using the specified Key Vault and
      Key name.

    .PARAMETER Name
      The name of the Key

    .PARAMETER KeyVaultName
      The name of the Key Vault

    .EXAMPLE
      Confirm-AzBPKeyVaultKey -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$KeyVaultName
  )
  Process {
    $Resource = Get-AzKeyVaultKey -Name $Name -VaultName $KeyVaultName

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-KeyVaultSecret.ps1

function Confirm-KeyVaultSecret {
  <#
    .SYNOPSIS
      Confirms that a Key Vault Secret exists.

    .DESCRIPTION
      The Confirm-AzBPKeyVaultSecret cmdlet gets a Key Vault Secret using the specified Key Vault and
      Secret name.

    .PARAMETER Name
      The name of the Secret

    .PARAMETER KeyVaultName
      The name of the Key Vault

    .EXAMPLE
      Confirm-AzBPKeyVaultSecret -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$KeyVaultName
  )
  Process {
    $Resource = Get-AzKeyVaultSecret -Name $Name -VaultName $KeyVaultName

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-OperationalInsightsWorkspace.ps1

function Confirm-OperationalInsightsWorkspace {
  <#
    .SYNOPSIS
      Confirms that an Operational Insights Workspace exists.

    .DESCRIPTION
      The Confirm-AzBPOperationalInsightsWorkspace cmdlet gets an Operational Insights Workspace using the specified
      Workspace Name and Resource Group name.

    .PARAMETER Name
      Specifies the workspace name.

    .PARAMETER ResourceGroupName
      Specifies the name of an Azure resource group.

    .EXAMPLE
      Confirm-AzBPOperationalInsightsWorkspace -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzOperationalInsightsWorkspace -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-Resource.ps1

function Confirm-Resource {
  <#
    .SYNOPSIS
      Confirms whether a resource exists or properties on a resource are configured correctly.

    .DESCRIPTION
      The Confirm-AzBPResource cmdlet confirms whether an Azure resource exists and/or confirms whether properties
      on a resource exist and are configured to the correct value. The cmdlet will return a ConfirmResult object
      which contains the following properties:
      - Success: True if the resource exists and/or the property is set to the expected value. Otherwise, false.
      - ResourceDetails: System.Object that contains the details of the Azure Resource that is being confirmed.

    .PARAMETER ResourceName
      The name of the Resource

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .PARAMETER ResourceType
      The type of the Resource as a [ResourceType]

    .PARAMETER ServerName
      If testing an Azure SQL Database resource, the name of the server to which the database is assigned.

    .PARAMETER DataFactoryName
      If testing an Azure Data Factory Linked Service resource, the name of the data factory to which the linked
      service is assigned.

    .PARAMETER WorkspaceName
      If testing a resource that belongs to some sort of Azure workspace (i.e. SQL pool in a Synapse workspace),
      the name of the workspace to which the resource is assigned.

    .PARAMETER AccountName
      If the Azure resource has an associated account name (e.g., Cosmos DB SQL Database, Storage Container)

    .PARAMETER PropertyKey
      The name of the property to check on the resource

    .PARAMETER PropertyValue
      The expected value of the property to check

    .EXAMPLE
      Checking whether a resource exists (i.e. Resource Group)
      Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName

    .EXAMPLE
      Confirm whether a resource has a property configured correctly (i.e. Resource Group located in West US 3)
      Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName -PropertyKey "Location" `
                            -PropertyValue "WestUS3"

    .EXAMPLE
      Checking whether a nested property on a resource is configured correctly (i.e. OS of VM is Linux)

      $params = @{
        ResourceGroupName = "rg-test";
        ResourceType = "VirtualMachine";
        ResourceName = "testvm";
        PropertyKey = "StorageProfile.OsDisk.OsType";
        PropertyValue = "Linux"
      }

      $result = Confirm-AzBPResource @params

    .INPUTS
      ResourceType
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory = $false)]
    [string]$ResourceName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [ResourceType]$ResourceType,

    [Parameter(Mandatory = $false)]
    [string]$ServerName,

    [Parameter(Mandatory = $false)]
    [string]$DataFactoryName,

    [Parameter(Mandatory = $false)]
    [string]$NamespaceName,

    [Parameter(Mandatory = $false)]
    [string]$EventHubName,

    [Parameter(Mandatory = $false)]
    [string]$WorkspaceName,

    [Parameter(Mandatory = $false)]
    [string]$ServicePrincipalId,

    [Parameter(Mandatory = $false)]
    [string]$Scope,

    [Parameter(Mandatory = $false)]
    [string]$RoleDefinitionName,

    [Parameter(Mandatory = $false)]
    [string]$AccountName,

    [Parameter(Mandatory = $false)]
    [string]$ServiceName,

    [Parameter(Mandatory = $false)]
    [string]$JobName,

    [Parameter(Mandatory = $false)]
    [string]$PropertyKey,

    [Parameter(Mandatory = $false)]
    [string]$PropertyValue
  )
  Begin { }
  Process {
    $ResourceParams = @{
      ResourceType       = $ResourceType
      NamespaceName      = $NamespaceName
      EventHubName       = $EventHubName
      JobName            = $JobName
      ResourceName       = $ResourceName
      ResourceGroupName  = $ResourceGroupName
      ServerName         = $ServerName
      DataFactoryName    = $DataFactoryName
      WorkspaceName      = $WorkspaceName
      AccountName        = $AccountName
      RoleDefinitionName = $RoleDefinitionName
      Scope              = $Scope
      ServicePrincipalId = $ServicePrincipalId
      ServiceName        = $ServiceName
    }

    $ConfirmResult = Get-ResourceByType @ResourceParams

    if ($null -eq $ConfirmResult) {
      Write-Error "Resource not found" -Category InvalidResult -ErrorId "InvalidResource"
      $ConfirmResult = [ConfirmResult]::new($null)
    } elseif ($ConfirmResult.Success -and -not [string]::IsNullOrWhiteSpace($PropertyKey)) {
      $ActualValue = $ConfirmResult.ResourceDetails

      # Split property path on open and close square brackets and periods. Remove empty items from array.
      $Keys = ($PropertyKey -split '[\[\]\.]').Where({ $_ -ne "" })
      foreach ($Key in $Keys) {
        try {
          # If key is a numerical value, index into array
          if ($Key -match "^\d+$") {
            $ActualValue = $ActualValue[$Key]
          } else {
            $ActualValue = $ActualValue.$Key
          }
        } catch {
          $thrownError = $_
          $ConfirmResult = [ConfirmResult]::new($null)
          Write-Error $thrownError
          break
        }
      }

      if ($ConfirmResult.Success -and $ActualValue -ne $PropertyValue) {
        $ConfirmResult.Success = $false

        if ($null -eq $ActualValue) {
          $errorParams = @{
            Message  = "A value for the property key: ${$PropertyKey}, was not found."
            Category = [System.Management.Automation.ErrorCategory]::InvalidArgument
            ErrorId  = "InvalidKey"
          }

          Write-Error @errorParams
        } else {
          $errorParams = @{
            Message  = "The value provided: ${$PropertyValue}, does not match the actual value: ${ActualValue} for " +
            "property key: ${$PropertyKey}"
            Category = [System.Management.Automation.ErrorCategory]::InvalidResult
            ErrorId  = "InvalidPropertyValue"
          }

          Write-Error @errorParams
        }
      }
    }

    $ConfirmResult
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-ResourceGroup.ps1

function Confirm-ResourceGroup {
  <#
    .SYNOPSIS
      Confirms that a Resource Group exists.

    .DESCRIPTION
      The Confirm-AzBPResourceGroup cmdlet gets a Resource Group using the specified Resource Group and
      Resource Group name.

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPResourceGroup -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzResourceGroup $ResourceGroupName

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-RoleAssignment.ps1

function Confirm-RoleAssignment {
  <#
    .SYNOPSIS
      Confirms that a Role Assignment for a service principal exists.

    .DESCRIPTION
      The Confirm-AzBPRoleAssignment cmdlet gets a Role Assignment using the specified Service Prinicpal, Scope
      and Role Assignment name.

    .PARAMETER RoleDefinitionName
      The name of the role definition i.e. Reader, Contributor etc.

    .PARAMETER ServicePrincipalId
      The service principal app id

    .PARAMETER Scope
      The scope of the role assignment. In the format of relative URI. For e.g.
      /subscriptions/{id}/resourceGroups/{resourceGroupName}.
      It must start with "/subscriptions/{id}".

    .EXAMPLE
      Confirm-AzBPRoleAssignment -RoleDefinitionName Reader -ServicePrincipalName testId `
      -Scope /subscriptions/{id}/resourceGroups/{resourceGroupName}

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$RoleDefinitionName,

    [Parameter(Mandatory=$true)]
    [string]$ServicePrincipalId,

    [Parameter(Mandatory=$true)]
    [ValidatePattern("/subscriptions/.*")]
    [string]$Scope
  )
  Process {
    $params = @{
      ServicePrincipalName = $ServicePrincipalId
      RoleDefinitionName   = $RoleDefinitionName
      Scope                = $Scope
    }

    # Filter to specific scope specified by the parameter
    $Resource = Get-AzRoleAssignment @params | Where-Object Scope -eq $Scope

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-SqlDatabase.ps1

function Confirm-SqlDatabase {
  <#
    .SYNOPSIS
      Confirms that one or more SQL Databases exist.

    .DESCRIPTION
      The Confirm-AzBPSqlDatabase cmdlet gets one or more SQL Databases using the specified SQL Database, SQL Server
      and Resource Group name.

    .PARAMETER DatabaseName
      The name of the SQL Database

    .PARAMETER DatabaseServer
      The name of the SQL Server

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPSqlDatabase -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"

    .EXAMPLE
      Confirm-AzBPSqlDatabase -DatabaseName "testdb" -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$DatabaseName,

    [Parameter(Mandatory=$true)]
    [string]$ServerName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $requestParams = @{
      ResourceGroupName = $ResourceGroupName
      ServerName = $ServerName
      DatabaseName = $DatabaseName
    }

    $Resource = Get-AzSqlDatabase @requestParams

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-SqlServer.ps1

function Confirm-SqlServer {
  <#
    .SYNOPSIS
      Confirms that a SQL Server exists.

    .DESCRIPTION
      The Confirm-AzBPSqlServer cmdlet gets a SQL Server using the specified SQL Server and
      Resource Group name.

    .PARAMETER ServerName
      The name of the SQL Server

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPSqlServer -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ServerName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
      $Resource = Get-AzSqlServer -ResourceGroupName $ResourceGroupName -ServerName $ServerName

      [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-StorageAccount.ps1

function Confirm-StorageAccount {
  <#
    .SYNOPSIS
      Confirms that a Storage Account exists.

    .DESCRIPTION
      The Confirm-AzBPStorageAccount cmdlet gets a Storage Account using the specified Storage Account and
      Resource Group name.

    .PARAMETER Name
      The name of the Storage Account

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPStorageAccount -Name "teststorageaccount" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
      $Resource = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $Name

      [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-StorageContainer.ps1

function Confirm-StorageContainer {
  <#
    .SYNOPSIS
      Confirms that a Storage Container exists.

    .DESCRIPTION
      The Confirm-AzBPStorageContainer cmdlet gets a Storage Container using the specified Storage Account, Container
      and Resource Group name.

    .PARAMETER Name
      The name of the Storage Container

    .PARAMETER AccountName
      The name of the Storage Account

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPStorageContainer -Name "teststgcontainer" -AccountName "teststgacct" -ResourceGroupName "rg-test"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$AccountName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
      $Resource = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $AccountName `
       | Get-AzStorageContainer -Name $Name

      [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-StreamAnalyticsCluster.ps1

function Confirm-StreamAnalyticsCluster {
  <#
    .SYNOPSIS
      Confirms that a Stream Analytics cluster exists.

    .DESCRIPTION
      The Confirm-AzBPStreamAnalyticsCluster cmdlet gets a Stream Analytics cluster using the specified Cluster and
      Resource Group name.

    .PARAMETER Name
      The name of the Stream Analytics Cluster

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPStreamAnalyticsCluster -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzStreamAnalyticsCluster -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-StreamAnalyticsFunction.ps1

function Confirm-StreamAnalyticsFunction {
  <#
    .SYNOPSIS
      Confirms that a Stream Analytics Function exists.

    .DESCRIPTION
      The Confirm-AzBPStreamAnalyticsFunction cmdlet gets a Stream Analytics Function using the specified Resource
      Group, the name of the Job executing the Function, and the name of the Function.

    .PARAMETER ResourceGroupName
      The name of the resource group. The name is case insensitive.

    .PARAMETER JobName
      The name of the streaming job.

    .PARAMETER Name
      The name of the function.

    .EXAMPLE
      Confirm-AzBPStreamAnalyticsFunction -ResourceGroupName "rgbenchpresstest" -JobName "jn" -Name "benchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$JobName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Process {
    $Resource = Get-AzStreamAnalyticsFunction -ResourceGroupName $ResourceGroupName -JobName $JobName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-StreamAnalyticsInput.ps1

function Confirm-StreamAnalyticsInput {
  <#
    .SYNOPSIS
      Confirms that a Stream Analytics Input exists.

    .DESCRIPTION
      The Confirm-AzBPStreamAnalyticsInput cmdlet gets a Stream Analytics Input using the specified Resource Group, the
      name of the Job with the Input, and the name of the Input.

    .PARAMETER ResourceGroupName
      The name of the resource group. The name is case insensitive.

    .PARAMETER JobName
      The name of the streaming job.

    .PARAMETER Name
      The name of the input.

    .EXAMPLE
      Confirm-AzBPStreamAnalyticsInput -ResourceGroupName "rgbenchpresstest" -JobName "jn" -Name "benchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$JobName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Process {
    $Resource = Get-AzStreamAnalyticsInput -ResourceGroupName $ResourceGroupName -JobName $JobName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-StreamAnalyticsJob.ps1

function Confirm-StreamAnalyticsJob {
  <#
    .SYNOPSIS
      Confirms that a Stream Analytics Job exists.

    .DESCRIPTION
      The Confirm-AzBPStreamAnalyticsJob cmdlet gets a Stream Analytics Job using the specified Resource Group and
      Stream Analytics job name.

    .PARAMETER ResourceGroupName
      The name of the resource group. The name is case insensitive.

    .PARAMETER Name
      The name of the Stream Analytics job.

    .EXAMPLE
      Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName "rgbenchpresstest" -Name "benchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Process {
    $Resource = Get-AzStreamAnalyticsJob -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-StreamAnalyticsOutput.ps1

function Confirm-StreamAnalyticsOutput {
  <#
    .SYNOPSIS
      Confirms that a Stream Analytics Output exists.

    .DESCRIPTION
      The Confirm-AzBPStreamAnalyticsOutput cmdlet gets a Stream Analytics Output using the specified Resource Group,
      the name of the Job with the Output, and the name of the Output.

    .PARAMETER ResourceGroupName
      The name of the resource group. The name is case insensitive.

    .PARAMETER JobName
      The name of the streaming job.

    .PARAMETER Name
      The name of the output.

    .EXAMPLE
      Confirm-AzBPStreamAnalyticsOutput -ResourceGroupName "rgbenchpresstest" -JobName "jn" -Name "benchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$JobName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Process {
    $Resource = Get-AzStreamAnalyticsOutput -ResourceGroupName $ResourceGroupName -JobName $JobName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-StreamAnalyticsTransformation.ps1

function Confirm-StreamAnalyticsTransformation {
  <#
    .SYNOPSIS
      Confirms that a Stream Analytics Transformation exists.

    .DESCRIPTION
      The Confirm-AzBPStreamAnalyticsTransformation cmdlet gets a Stream Analytics Transformation using the specified
      Resource Group, the name of the Job with the Transformation, and the name of the Transformation.

    .PARAMETER ResourceGroupName
      The name of the resource group. The name is case insensitive.

    .PARAMETER JobName
      The name of the streaming job.

    .PARAMETER Name
      The name of the transformation.

    .EXAMPLE
      Confirm-AzBPStreamAnalyticsTransformation -ResourceGroupName "rgbenchpresstest" -JobName "jn" `
        -Name "benchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$JobName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Process {
    $Resource = Get-AzStreamAnalyticsTransformation -ResourceGroupName $ResourceGroupName -JobName $JobName -Name $Name

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-SynapseSparkPool.ps1

function Confirm-SynapseSparkPool {
  <#
    .SYNOPSIS
      Confirms that a Synapse Spark pool exists.

    .DESCRIPTION
      The Confirm-AzBPSynapseSparkPool cmdlet gets a Spark pool under a Synapse workspace using the specified
      Synapse Workspace, Spark Pool and Resource Group name.

    .PARAMETER SynapseSparkPoolName
      The name of the Spark pool

    .PARAMETER WorkspaceName
      The name of the Synapse Workspace

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPSynapseSparkPool -SynapseSparkPoolName "benchpresstest" -WorkspaceName "wstest" `
        -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$SynapseSparkPoolName,

    [Parameter(Mandatory=$true)]
    [string]$WorkspaceName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzSynapseSparkPool -ResourceGroupName $ResourceGroupName -WorkspaceName $WorkspaceName -Name $SynapseSparkPoolName

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-SynapseSqlPool.ps1

function Confirm-SynapseSqlPool {
  <#
    .SYNOPSIS
      Confirms that a Synapse SQL pool exists.

    .DESCRIPTION
      The Confirm-AzBPSynapseSqlPool cmdlet gets a SQL pool under a Synapse workspace using the specified
      Synapse Workspace, SQL Pool and Resource Group name.

    .PARAMETER SynapseSqlPoolName
      The name of the SQL pool

    .PARAMETER WorkspaceName
      The name of the Synapse Workspace

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPSynapseSqlPool -SynapseSqlPoolName "benchpresstest" -WorkspaceName "wstest" `
        -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$SynapseSqlPoolName,

    [Parameter(Mandatory=$true)]
    [string]$WorkspaceName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzSynapseSqlPool -ResourceGroupName $ResourceGroupName -WorkspaceName $WorkspaceName -Name $SynapseSqlPoolName

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-SynapseWorkspace.ps1

function Confirm-SynapseWorkspace {
  <#
    .SYNOPSIS
      Confirms that a Synapse Workspace exists.

    .DESCRIPTION
      The Confirm-AzBPSynapseWorkspace cmdlet gets a synapse workspace using the specified Synapse Workspace and
      Resource Group name.

    .PARAMETER WorkspaceName
      The name of the Synapse Workspace

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPSynapseWorkspace -WorkspaceName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$WorkspaceName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
    $Resource = Get-AzSynapseWorkspace -ResourceGroupName $ResourceGroupName -Name $WorkspaceName

    [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-VirtualMachine.ps1

function Confirm-VirtualMachine {
  <#
    .SYNOPSIS
      Confirms that a Virtual Machine exists.

    .DESCRIPTION
      The Confirm-AzBPVirtualMachine cmdlet gets a Virtual Machine using the specified Virtual Machine and
      Resource Group name.

    .PARAMETER VirtualMachineName
      The name of the Virtual Machine

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPVirtualMachine -VirtualMachineName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$VirtualMachineName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
      $Resource = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VirtualMachineName

      [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Confirm-WebApp.ps1

function Confirm-WebApp {
  <#
    .SYNOPSIS
      Confirms that a Web App exists.

    .DESCRIPTION
      The Confirm-AzBPWebApp cmdlet gets a Web App using the specified Web App and
      Resource Group name.

    .PARAMETER WebAppName
      The name of the Web App

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPWebApp -WebAppName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$WebAppName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Process {
      $Resource = Get-AzWebApp -ResourceGroupName $ResourceGroupName -Name $WebAppName

      [ConfirmResult]::new($Resource, "AuthenticationData")
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Deploy-BicepFeature.ps1

function Deploy-BicepFeature(){
  <#
    .SYNOPSIS
      Deploys Azure resources using a bicep file.

    .DESCRIPTION
      Deploy-AzBPBicepFeature cmdlet deploys Azure resources when given a path to a bicep file. The cmdlet will
      transpile the bicep file to an ARM template and uses the ARM template to deploy to Azure.

    .PARAMETER BicepPath
      This is the path to the bicep file that will be used to transpile to ARM and deploy to Azure.

    .EXAMPLE
      $params = @{
        name           = "acrbenchpresstest1"
        location       = "westus3"
      }
      Deploy-AzBPBicepFeature -BicepPath "./containerRegistry.bicep" -Params $params -ResourceGroupName "rg-test"

    .INPUTS
      System.String
      System.Collections.Hashtable

    .OUTPUTS
      None
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$BicepPath,

    [Parameter(Mandatory=$true)]
    [hashtable]$Params,

    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName
  )
  $fileName = [System.IO.Path]::GetFileNameWithoutExtension($BicepPath)
  $folder = Split-Path $BicepPath
  $armPath  = Join-Path -Path $folder -ChildPath "$fileName.json"

  Write-Information "Transpiling Bicep to Arm"
  # 2>&1 will send errors to stdout so that they can be captured by PowerShell
  # Both the ARM template and any output from linting will be in the array $results, with individual errors in the
  # array separately
  $results = Invoke-Command -ScriptBlock { bicep build $BicepPath 2>&1 }
  # .Where() returns a collection of System.Management.Automation.ErrorRecord or null if there are no errors
  $errorResults = $results.Where({$PSItem.GetType().Name -eq 'ErrorRecord'})

  # Only deploy if there are no errors.
  if ($errorResults.Count -eq 0) {
    $location = $Params.location
    $deploymentName = $Params.deploymentName

    if ([string]::IsNullOrEmpty($deploymentName)) {
      $deploymentName = "BenchPressDeployment"
    }

    Write-Information "Deploying ARM Template ($deploymentName) to $location"

    if ([string]::IsNullOrEmpty($ResourceGroupName)) {
      New-AzSubscriptionDeployment -Name "$deploymentName" -Location "$location" -TemplateFile "$armPath" -TemplateParameterObject $Params -SkipTemplateParameterPrompt
    }
    else{
      New-AzResourceGroupDeployment -Name "$deploymentName" -ResourceGroupName "$ResourceGroupName" -TemplateFile "$armPath" -TemplateParameterObject $Params -SkipTemplateParameterPrompt
    }
  }

  Write-Information "Removing Arm template json"
  Remove-Item "$armPath"
}
# file Modules/BenchPress.Azure/Public/Get-Resource.ps1

function Get-Resource {
  <#
    .SYNOPSIS
      Gets one or more resources of a given name.

    .DESCRIPTION
      The Get-AzBPResource cmdlet gets Azure resources of a given name.

    .PARAMETER ResourceName
      The name of the Resources

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Get-AzBPResource -ResourceName "benchpresstest"

    .EXAMPLE
      Get-AzBPResource -ResourceName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResource
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName
  )
  Process {
    if ([string]::IsNullOrEmpty($ResourceGroupName)) {
      return Get-AzResource -Name $ResourceName
    }
    else {
      return Get-AzResource -Name $ResourceName -ResourceGroupName $ResourceGroupName
    }
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Get-ResourceByType.ps1

function Get-ResourceByType {
  <#
    .SYNOPSIS
      Gets an Azure Resource.

    .DESCRIPTION
      The Get-AzBPResourceByType cmdlet gets an Azure resource depending on the resource type (i.e. Action Group, Key Vault,
      Container Registry, etc.).

    .PARAMETER ResourceName
      The name of the Resource

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .PARAMETER ResourceType
      The type of the Resource.

    .PARAMETER ServerName
      If testing an Azure SQL Database resource, the name of the server to which the database is assigned.

    .PARAMETER DataFactoryName
      If testing an Azure Data Factory Linked Service resource, the name of the data factory to which the linked
      service is assigned.

    .PARAMETER WorkspaceName
      If testing a resource that belongs to some sort of Azure workspace (i.e. SQL pool in a Synapse workspace),
      the name of the workspace to which the resource is assigned.

    .PARAMETER AccountName
      If the Azure resource has an associated account name (e.g., Cosmos DB SQL Database, Storage Container) this is
      the parameter to use to pass the account name.

    .PARAMETER ServiceName
      If the Azure resource is associated with a service (e.g, API Management Service) this is the parameter to use to
      pass the service name.

    .EXAMPLE
      Get-AzBPResourceByType -ResourceType ActionGroup -ResourceName "bpactiongroup" -ResourceGroupName "rgbenchpresstest"

    .EXAMPLE
      Get-AzBPResourceByType -ResourceType VirtualMachine -ResourceName "testvm" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory = $false)]
    [string]$ResourceName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [ResourceType]$ResourceType,

    [Parameter(Mandatory = $false)]
    [string]$ServerName,

    [Parameter(Mandatory = $false)]
    [string]$DataFactoryName,

    [Parameter(Mandatory = $false)]
    [string]$NamespaceName,

    [Parameter(Mandatory = $false)]
    [string]$EventHubName,

    [Parameter(Mandatory = $false)]
    [string]$WorkspaceName,

    [Parameter(Mandatory = $false)]
    [string]$AccountName,

    [Parameter(Mandatory = $false)]
    [string]$ServicePrincipalId,

    [Parameter(Mandatory = $false)]
    [string]$Scope,

    [Parameter(Mandatory = $false)]
    [string]$RoleDefinitionName,

    [Parameter(Mandatory = $false)]
    [string]$ServiceName,

    [Parameter(Mandatory = $false)]
    [string]$JobName
  )
  Begin { }
  Process {
    switch ($ResourceType) {
      "ActionGroup" {
        return Confirm-ActionGroup -ActionGroupName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "AksCluster" {
        return Confirm-AksCluster -AKSName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "ApiManagement" {
        return Confirm-ApiManagement -ResourceGroupName $ResourceGroupName -Name $ResourceName
      }
      "ApiManagementApi" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          ServiceName = $ServiceName
          Name = $ResourceName
        }
        return Confirm-ApiManagementApi @params
      }
      "ApiManagementDiagnostic" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          ServiceName = $ServiceName
          Name = $ResourceName
        }
        return Confirm-ApiManagementDiagnostic @params
      }
      "ApiManagementLogger" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          ServiceName = $ServiceName
          Name = $ResourceName
        }
        return Confirm-ApiManagementLogger @params
      }
      "ApiManagementPolicy" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          ServiceName = $ServiceName
          ApiId = $ResourceName
        }
        return Confirm-ApiManagementPolicy @params
      }
      "AppInsights" {
        return Confirm-AppInsights -ResourceGroupName $ResourceGroupName -Name $ResourceName
      }
      "AppServicePlan" {
        return Confirm-AppServicePlan -AppServicePlanName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "ContainerApp" {
        return Confirm-ContainerApp -ResourceGroupName $ResourceGroupName -Name $ResourceName
      }
      "ContainerRegistry" {
        return Confirm-ContainerRegistry -Name $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "CosmosDBAccount" {
        return Confirm-CosmosDBAccount -ResourceGroupName $ResourceGroupName -Name $ResourceName
      }
      "CosmosDBGremlinDatabase" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          AccountName       = $AccountName
          Name              = $ResourceName
        }
        return Confirm-CosmosDBGremlinDatabase @params
      }
      "CosmosDBMongoDBDatabase" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          AccountName       = $AccountName
          Name              = $ResourceName
        }
        return Confirm-CosmosDBMongoDBDatabase @params
      }
      "CosmosDBSqlDatabase" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          AccountName       = $AccountName
          Name              = $ResourceName
        }
        return Confirm-CosmosDBSqlDatabase @params
      }
      "DataFactory" {
        return Confirm-DataFactory -Name $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "DataFactoryLinkedService" {
        $params = @{
          Name              = $ResourceName
          DataFactoryName   = $DataFactoryName
          ResourceGroupName = $ResourceGroupName
        }
        return Confirm-DataFactoryLinkedService @params
      }
      "EventHub" {
        $params = @{
          Name              = $ResourceName
          NamespaceName     = $NamespaceName
          ResourceGroupName = $ResourceGroupName
        }
        return Confirm-EventHub @params
      }
      "EventHubConsumerGroup" {
        $params = @{
          Name              = $ResourceName
          EventHubName      = $EventHubName
          NamespaceName     = $NamespaceName
          ResourceGroupName = $ResourceGroupName
        }
        return Confirm-EventHubConsumerGroup @params
      }
      "EventHubNamespace" {
        return Confirm-EventHubNamespace -NamespaceName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "KeyVault" {
        return Confirm-KeyVault -Name $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "OperationalInsightsWorkspace" {
        return Confirm-OperationalInsightsWorkspace -Name $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "ResourceGroup" {
        return Confirm-ResourceGroup -ResourceGroupName $ResourceName
      }
      "RoleAssignment" {
        $params = @{
          ServicePrincipalId   = $ServicePrincipalId
          RoleDefinitionName   = $RoleDefinitionName
          Scope                = $Scope
        }
        return Confirm-RoleAssignment @params
      }
      "SqlDatabase" {
        $params = @{
          ServerName        = $ServerName
          DatabaseName      = $ResourceName
          ResourceGroupName = $ResourceGroupName
        }
        return Confirm-SqlDatabase @params
      }
      "SqlServer" {
        return Confirm-SqlServer -ServerName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "StorageAccount" {
        return Confirm-StorageAccount -Name $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "StorageContainer" {
        $params = @{
          Name              = $ResourceName
          AccountName       = $AccountName
          ResourceGroupName = $ResourceGroupName
        }
        return Confirm-StorageContainer @params
      }
      "StreamAnalyticsCluster" {
        return Confirm-StreamAnalyticsCluster -Name $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "StreamAnalyticsFunction" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          JobName = $JobName
          Name = $ResourceName
        }
        return Confirm-StreamAnalyticsFunction @params
      }
      "StreamAnalyticsInput" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          JobName = $JobName
          Name = $ResourceName
        }
        return Confirm-StreamAnalyticsInput @params
      }
      "StreamAnalyticsJob" {
        return Confirm-StreamAnalyticsJob -ResourceGroupName $ResourceGroupName -Name $ResourceName
      }
      "StreamAnalyticsOutput" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          JobName = $JobName
          Name = $ResourceName
        }
        return Confirm-StreamAnalyticsOutput @params
      }
      "StreamAnalyticsTransformation" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          JobName = $JobName
          Name = $ResourceName
        }
        return Confirm-StreamAnalyticsTransformation @params
      }
      "SynapseSparkPool" {
        $params = @{
          SynapseSparkPoolName = $ResourceName
          WorkspaceName        = $WorkspaceName
          ResourceGroupName    = $ResourceGroupName
        }
        return Confirm-SynapseSparkPool @params
      }
      "SynapseSqlPool" {
        $params = @{
          SynapseSqlPoolName = $ResourceName
          WorkspaceName      = $WorkspaceName
          ResourceGroupName  = $ResourceGroupName
        }
        return Confirm-SynapseSqlPool @params
      }
      "SynapseWorkspace" {
        return Confirm-SynapseWorkspace -WorkspaceName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "VirtualMachine" {
        return Confirm-VirtualMachine -VirtualMachineName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "WebApp" {
        return Confirm-WebApp -WebAppName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      default {
        Write-Information "Not implemented yet"
        return $null
      }
    }
  }
  End { }
}
# file Modules/BenchPress.Azure/Public/Invoke-AzCli.ps1
function Invoke-AzCli {
  <#
    .DESCRIPTION
    Invoke an Azure CLI command.

    .SYNOPSIS
    Invoke-AzBPAzCli cmdlet invokes an Azure CLI command and returns the result as an object.

    .EXAMPLE
    PS C:\> Invoke-AzBPAzCli "account list"

    .EXAMPLE
    PS C:\> Invoke-AzBPAzCli "account list --query [].name"

    .EXAMPLE
    PS C:\> Invoke-AzBPAzCli "webapp create --name ${WEBAPP_NAME} --resource-group ${RESOURCE_GROUP_NAME} --plan ${APP_SERVICE_PLAN_NAME}"

    .PARAMETER Command
    The command to execute.

    .NOTES
    Invoke-AzBPAzCli adds the az prefix to the command.

    .LINK
    https://learn.microsoft.com/en-us/cli/azure/

    .LINK
    https://learn.microsoft.com/en-us/cli/azure/get-started-with-azure-cli

    .LINK
    https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest

    .INPUTS
    System.String

    .OUTPUTS
    System.Object
  #>
  [CmdletBinding()]
  [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingInvokeExpression", "")]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Command
  )

  $toExecute = "az $Command"

  $result = Invoke-Expression "$toExecute"

  if ($LastExitCode -gt 0) {
    Write-Error "$result"
  } else {
    $result | ConvertFrom-Json
  }
}
# file Modules/BenchPress.Azure/Public/Remove-BicepFeature.ps1

function Remove-BicepFeature(){
  <#
    .SYNOPSIS
      Deletes Azure resources.

    .DESCRIPTION
      Remove-AzBPBicepFeature cmdlet will take an Azure Resource Group name and delete that resource group and all
      resources contained in it.

    .PARAMETER ResourceGroupName
      Name of the Resource Group to delete

    .EXAMPLE
      Remove-AzBPBicepFeature -ResourceGroupName "rg-test"

    .INPUTS
      System.String

    .OUTPUTS
      None
  #>
  [CmdletBinding()]
  [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resourceGroup = Get-AzResourceGroup -Name $ResourceGroupName
  Remove-AzResourceGroup -Name $resourceGroup.ResourceGroupName -Force
}
# file Modules/BenchPress.Azure/Public/CustomAssertions/BeInLocation.ps1
function ShouldBeInLocation ($ActualValue, [string]$ExpectedValue, [switch] $Negate, [string] $Because) {
  <#
    .SYNOPSIS
      Custom Assertion function to check status on a resource deployment.

    .DESCRIPTION
      BeInLocation is a custom assertion that checks the provided ConfirmResult Object for deployment success.
      It can be used when writing Pester tests.

    .EXAMPLE
      Confirm-AzBPResourceGroup -ResourceGroupName $rgName | Should -BeInLocation 'westus3'

    .EXAMPLE
      Confirm-AzBPResourceGroup -ResourceGroupName $rgName | Should -Not -BeInLocation 'westus2'

    .INPUTS
      ConfirmResult
      System.Switch
      System.String

    .OUTPUTS
      PSCustomObject
  #>
  $propertyName = 'Location'

  if ($null -eq $ActualValue){
    [bool] $succeeded = $false
    $failureMessage = "ConfirmResult is null or empty."
  } elseif (-not [bool]$ActualValue.ResourceDetails.PSObject.Properties[$propertyName]) {
    [bool] $succeeded = $false
    $failureMessage = "Resource does not have a location property. It is null or empty."
  } else {
    # Both expected and actual locations should be normalized with no spaces
    $resourceLocation = $ActualValue.ResourceDetails.Location -replace " ",""
    $expectedLocation = $ExpectedValue -replace " ",""

    [bool] $succeeded = $resourceLocation -ieq $expectedLocation
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded) {
      if ($Negate) {
        $failureMessage = "Resource is deployed, incorrectly, in $resourceLocation."
      } else {
        $failureMessage = "Resource not in location or there was an error when confirming resource.
        Expected $ExpectedValue but got $resourceLocation."
        if ($Because) { $failureMessage = "Resource not in location $Because." }
      }
    }
  }

  return [pscustomobject]@{
      Succeeded      = $succeeded
      FailureMessage = $failureMessage
  }
}

Add-ShouldOperator -Name BeInLocation `
    -InternalName 'ShouldBeInLocation' `
    -Test ${function:ShouldBeInLocation} `
    -Alias 'SBIL'
# file Modules/BenchPress.Azure/Public/CustomAssertions/BeInResourceGroup.ps1
function ShouldBeInResourceGroup ($ActualValue, [string]$ExpectedValue, [switch] $Negate, [string] $Because) {
  <#
    .SYNOPSIS
      Custom Assertion function to check resource's resource group.

    .DESCRIPTION
      BeInResourceGroup is a custom assertion that checks the resource group of a resource.
      It can be used when writing Pester tests.

    .EXAMPLE
      Confirm-AzBPContainerRegistry -ResourceGroupName $rgName | Should -BeInResourceGroup 'rg-test'

    .EXAMPLE
      Confirm-AzBPContainerRegistry -ResourceGroupName $rgName | Should -Not -BeInResourceGroup 'rg-test2'

    .INPUTS
      ConfirmResult
      System.Switch
      System.String

    .OUTPUTS
      PSCustomObject
  #>
  $rgProperty = 'ResourceGroup'
  $rgNameProperty = 'ResourceGroupName'
  $idProperty = 'Id'

  if ($null -eq $ActualValue){
    [bool] $succeeded = $false
    $failureMessage = "ConfirmResult is null or empty."
  } else {
    if ([bool]$ActualValue.ResourceDetails.PSObject.Properties[$rgProperty]){
      $resourceGroupName = $ActualValue.ResourceDetails.$rgProperty
    } elseif ([bool]$ActualValue.ResourceDetails.PSObject.Properties[$rgNameProperty]){
      $resourceGroupName = $ActualValue.ResourceDetails.$rgNameProperty
    } elseif ([bool]$ActualValue.ResourceDetails.PSObject.Properties[$idProperty]){
      # If it does not have a property for resource group, then we can maybe get the resource group from Id
      # ex: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/'
      # providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
      $resourceId = $ActualValue.ResourceDetails.$idProperty
      $resourceGroupPath = $resourceId -split 'resourceGroups' | Select-Object -Last 1
      $resourceGroupName = @($resourceGroupPath -split '/')[1]

      # If $resourceGroupName is empty, the Id is the wrong format
      # so, set it to null
      if ('' -eq $resourceGroupName) {
        $resourceGroupName = $null
      }
    }

    # Some resources don't have any of the resource group properties
    if ($null -eq $resourceGroupName){
      [bool] $succeeded = $false
      $failureMessage = "Resource does not have a ResourceGroup, a ResourceGroupName, or an Id (with a RG) property.
      They are null or empty."
    } else {
        [bool] $succeeded = $resourceGroupName -eq $ExpectedValue
        if ($Negate) { $succeeded = -not $succeeded }

        if (-not $succeeded) {
            if ($Negate) {
              $failureMessage = "Resource is deployed, incorrectly, in $resourceGroupName."
            } else {
              $failureMessage = "Resource not in resource group or there was an error when confirming resource.
              Expected $ExpectedValue but got $resourceGroupName."
              if ($Because) { $failureMessage = "Resource not in resource group. This failed $Because." }
            }
        }
    }
  }

  return [pscustomobject]@{
      Succeeded      = $succeeded
      FailureMessage = $failureMessage
  }
}

Add-ShouldOperator -Name BeInResourceGroup `
    -InternalName 'ShouldBeInResourceGroup' `
    -Test ${function:ShouldBeInResourceGroup} `
    -Alias 'SBIRG'
# file Modules/BenchPress.Azure/Public/CustomAssertions/BeSuccessful.ps1
function ShouldBeSuccessful ($ActualValue, [switch] $Negate, [string] $Because) {
  <#
    .SYNOPSIS
      Custom Assertion function to check status on a resource deployment.

    .DESCRIPTION
      BeSuccessful is a custom assertion that checks the provided ConfirmResult Object for deployment success.
      It can be used when writing Pester tests.

    .EXAMPLE
      Confirm-AzBPResourceGroup -ResourceGroupName $rgName | Should -BeSuccessful

    .EXAMPLE
      Confirm-AzBPResourceGroup -ResourceGroupName $rgName | Should -Not -BeSuccessful

    .INPUTS
      ConfirmResult
      System.Switch
      System.String

    .OUTPUTS
      PSCustomObject
  #>
  if ($null -eq $ActualValue){
    [bool] $succeeded = $false
    $failureMessage = "ConfirmResult is null or empty."
  } else {
    [bool] $succeeded = $ActualValue.Success
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded) {
      if ($Negate) {
        $failureMessage = "Resource is currently deployed, but should not be."
      } else {
        $failureMessage = "Resource not deployed or there was an error when confirming resource."
        if ($Because) { $failureMessage = "Resource not available $Because." }
      }
    }
  }

  return [pscustomobject]@{
    Succeeded      = $succeeded
    FailureMessage = $failureMessage
  }
}

Add-ShouldOperator -Name BeSuccessful `
    -InternalName 'ShouldBeSuccessful' `
    -Test ${function:ShouldBeSuccessful} `
    -Alias 'SBS'
# file Modules/BenchPress.Azure/Private/Connect-Account.ps1

function Connect-Account {
  <#
    .SYNOPSIS
      Connect-Account uses environment variable values to log into an Azure context. This is an internal function and
      should not be used outside of the BenchPress module.

    .DESCRIPTION
      Connect-Account is designed to login to an Azure context using environment variables to login as a
      ServicePrincipal for the PowerShell session.

      The expected environment variables are:

      AZ_APPLICATION_ID - The Service Principal ID
      AZ_ENCRYPTED_PASSWORD - The Service Principal account password properly encrypted using ConvertTo-SecureString
                              and saved as an environment variable using ConvertFrom-SecureString
      AZ_TENANT_ID - The Tenant ID to login to
      AZ_SUBSCRIPTION_ID - The Subscription ID to login to

      If the current context that is logged in to matches the Service Principal, Tenant, and Subscription this function
      is a no-op.

    .EXAMPLE
      There is only one way to call Connect-Account:

      Connect-Account

    .INPUTS
      None

    .OUTPUTS
      AuthenticationResult
  #>
  [OutputType([AuthenticationResult])]
  [CmdletBinding()]
  param ( )
  Begin { }
  Process {
    $ApplicationId = Get-RequiredEnvironmentVariable AZ_APPLICATION_ID
    $TenantId = Get-RequiredEnvironmentVariable AZ_TENANT_ID
    $SubscriptionId = Get-RequiredEnvironmentVariable AZ_SUBSCRIPTION_ID
    $CurrentConnection = Get-AzContext
    $Results = [AuthenticationResult]::new()

    # If the current context matches the subscription, tenant, and service principal, then we're already properly
    # logged in.
    if ($null -ne $CurrentConnection `
      -and ($CurrentConnection).Account.Type -eq 'ServicePrincipal' `
      -and ($CurrentConnection).Account.Id -eq $ApplicationId `
      -and ($CurrentConnection).Tenant.Id -eq $TenantId `
      -and ($CurrentConnection).Subscription.Id -eq $SubscriptionId) {
      $Results.Success = $true
      $Results.AuthenticationData = [AuthenticationData]::new(($CurrentConnection).Subscription.Id)
    } else {
      # The current context is not correct, create the credentials and login to the correct account
      $ClientSecret = Get-RequiredEnvironmentVariable AZ_ENCRYPTED_PASSWORD | ConvertTo-SecureString
      $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $ApplicationId, $ClientSecret

      try {
        $ConnectionParams = @{
          Credential = $Credential
          TenantId = $TenantId
          Subscription = $SubscriptionId
        }
        $Connection = Connect-AzAccount -ServicePrincipal @ConnectionParams

        $Results.Success = $true
        $Results.AuthenticationData = [AuthenticationData]::new($Connection.Context.Subscription.Id)
      } catch {
        $thrownError = $_
        $Results.Success = $false
        Write-Error $thrownError
      }

      $Results
    }
  }
  End { }
}
# file Modules/BenchPress.Azure/Private/Disconnect-Account.ps1

function Disconnect-Account {
  <#
    .SYNOPSIS
      Disconnect-Account uses environment variable values to disconnect from a specific Azure context. This is an
      internal function and should not be used outside of the BenchPress module.

    .DESCRIPTION
      Disconnect-Account is designed to automatically log out of the specific Azure context using environment variables
      to identify the context to disconnect.

      The expected environment variables are:

      AZ_APPLICATION_ID - The Service Principal ID
      AZ_TENANT_ID - The Tenant ID to login to
      AZ_SUBSCRIPTION_ID - The Subscription ID to login to

      If the current context does not match the Service Principal, Tenant, or Subscription then this function is a
      no-op

    .EXAMPLE
      There is only one way to call Disconnect-Account:

      Disconnect-Account

    .INPUTS
      None

    .OUTPUTS
      None
  #>
  [OutputType([System.Void])]
  [CmdletBinding()]
  param ( )
  Begin {
    $ApplicationId = Get-RequiredEnvironmentVariable AZ_APPLICATION_ID
    $TenantId = Get-RequiredEnvironmentVariable AZ_TENANT_ID

    # If the current context doesn't match the target subscription, tentant, and client, then the testing account is
    # not logged in. Do nothing.
    $CurrentConnection = Get-AzContext
  }
  Process {
    if ($null -eq $CurrentConnection `
      -or ($CurrentConnection).Account.Type -ne "ServicePrincipal" `
      -or ($CurrentConnection).Account.Id -ne $ApplicationId `
      -or ($CurrentConnection).Tenant.Id -ne $TenantId) {
      return
    }

    $CurrentConnection | Disconnect-AzAccount -Scope CurrentUser
  }
  End { }
}
# file Modules/BenchPress.Azure/Private/Get-RequiredEnvironmentVariable.ps1
function Get-RequiredEnvironmentVariable {
  <#
    .SYNOPSIS
      Get-RequiredEnvironmentVariable is a private helper method that retrieves environment variables with the
      expectation that if they are not present that an error will be logged with an immedate exit.

    .DESCRIPTION
      Get-RequiredEnvironmentVariable retrieves the environment variable specified by the input parameter and checks to
      be sure that a value is present for that environment variable. If the value is missing or whitespace a message
      will be written to Write-Error with the name of the variable in the output and exit will be called.

    .PARAMETER VariableName
      This is the name of the environment variable to retrieve and validate that a value is present.

    .EXAMPLE
      Provide -VariableName Parameter

      Get-RequiredEnvironmentVariable -VariableName AZ_APPLICATION_ID

    .EXAMPLE
      Provide variable name without -VariableName Parameter

      Get-RequiredEnvironmentVariable AZ_APPLICATION_ID

    .INPUTS
      System.String

    .OUTPUTS
      System.String
  #>
  [OutputType([System.String])]
  param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$VariableName
  )
  Begin {
    $Value = [string]$null
  }
  Process {
    $Value = [System.Environment]::GetEnvironmentVariable($VariableName)

    if ([string]::IsNullOrWhiteSpace($Value)) {
      Write-Error "Missing Required Environment Variable $VariableName"
      exit 1
    }
  }
  End {
    return $Value
  }
}
Export-ModuleMember Confirm-ActionGroup,Confirm-AksCluster,Confirm-ApiManagement,Confirm-ApiManagementApi,Confirm-ApiManagementDiagnostic,Confirm-ApiManagementLogger,Confirm-ApiManagementPolicy,Confirm-AppInsights,Confirm-AppServicePlan,Confirm-BicepFile,Confirm-ContainerApp,Confirm-ContainerRegistry,Confirm-CosmosDBAccount,Confirm-CosmosDBGremlinDatabase,Confirm-CosmosDBMongoDBDatabase,Confirm-CosmosDBSqlDatabase,Confirm-DataFactory,Confirm-DataFactoryLinkedService,Confirm-EventHub,Confirm-EventHubConsumerGroup,Confirm-EventHubNamespace,Confirm-KeyVault,Confirm-KeyVaultCertificate,Confirm-KeyVaultKey,Confirm-KeyVaultSecret,Confirm-OperationalInsightsWorkspace,Confirm-Resource,Confirm-ResourceGroup,Confirm-RoleAssignment,Confirm-SqlDatabase,Confirm-SqlServer,Confirm-StorageAccount,Confirm-StorageContainer,Confirm-StreamAnalyticsCluster,Confirm-StreamAnalyticsFunction,Confirm-StreamAnalyticsInput,Confirm-StreamAnalyticsJob,Confirm-StreamAnalyticsOutput,Confirm-StreamAnalyticsTransformation,Confirm-SynapseSparkPool,Confirm-SynapseSqlPool,Confirm-SynapseWorkspace,Confirm-VirtualMachine,Confirm-WebApp,Deploy-BicepFeature,Get-Resource,Get-ResourceByType,Invoke-AzCli,Remove-BicepFeature,BeInLocation,BeInResourceGroup,BeSuccessful

