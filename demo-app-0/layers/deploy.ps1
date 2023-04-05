$RESOURCE_SUFFIX = [guid]::NewGuid().ToString('N').Substring(0, 8)

$RESOURCE_GROUP_NAME = "rg-$RESOURCE_SUFFIX"
$LOCATION_NAME = "northeurope"

Write-Host "Resource Group Name: $RESOURCE_GROUP_NAME"

$env:RESOURCE_SUFFIX = $RESOURCE_SUFFIX
$env:RESOURCE_GROUP_NAME = $RESOURCE_GROUP_NAME
$env:LOCATION_NAME = $LOCATION_NAME

Push-Location 010_Jumpbox

az deployment sub create --name "deployment-${RESOURCE_SUFFIX}-010" --location "$LOCATION_NAME" --template-file "./main.bicep" `
                         --verbose --output "none" --parameters `
                           resourceGroupName="${RESOURCE_GROUP_NAME}"

Pop-Location

Push-Location 020_Network

az deployment group create --name "deployment-${RESOURCE_SUFFIX}-020" --resource-group "$RESOURCE_GROUP_NAME" --template-file "./main.bicep" `
                           --verbose --output "none" --parameters `
                             resourceSuffix="${RESOURCE_SUFFIX}" `
                             location="${LOCATION_NAME}"

Pop-Location

Push-Location 030_Monitoring

az deployment group create --name "deployment-${RESOURCE_SUFFIX}-030" --resource-group "$RESOURCE_GROUP_NAME" --template-file "./main.bicep" `
                           --verbose --output "none" --parameters `
                             resourceSuffix="${RESOURCE_SUFFIX}" `
                             location="${LOCATION_NAME}"

Pop-Location

Push-Location 040_KeyVault

az deployment group create --name "deployment-${RESOURCE_SUFFIX}-040" --resource-group "$RESOURCE_GROUP_NAME" --template-file "./main.bicep" `
                           --verbose --output "none" --parameters `
                             resourceSuffix="${RESOURCE_SUFFIX}" `
                             location="${LOCATION_NAME}"

Pop-Location

Push-Location 050_Cosmos

az deployment group create --name "deployment-${RESOURCE_SUFFIX}-050" --resource-group "$RESOURCE_GROUP_NAME" --template-file "./main.bicep" `
                           --verbose --output "none" --parameters `
                             resourceSuffix="${RESOURCE_SUFFIX}" `
                             location="${LOCATION_NAME}"

Pop-Location

Push-Location 060_WebApp

az deployment group create --name "deployment-${RESOURCE_SUFFIX}-060" --resource-group "$RESOURCE_GROUP_NAME" --template-file "./main.bicep" `
                           --verbose --output "none" --parameters `
                             resourceSuffix="${RESOURCE_SUFFIX}" `
                             location="${LOCATION_NAME}"

Pop-Location

Push-Location 070_VirtualMachine

az deployment group create --name "deployment-${RESOURCE_SUFFIX}-070" --resource-group "$RESOURCE_GROUP_NAME" --template-file "./main.bicep" `
                           --verbose --output "none" --parameters `
                             resourceSuffix="${RESOURCE_SUFFIX}" `
                             location="${LOCATION_NAME}"

Pop-Location

Push-Location 080_DataExplorer

az deployment group create --name "deployment-${RESOURCE_SUFFIX}-080" --resource-group "$RESOURCE_GROUP_NAME" --template-file "./main.bicep" `
                           --verbose --output "none" --parameters `
                             resourceSuffix="${RESOURCE_SUFFIX}" `
                             location="${LOCATION_NAME}"

Pop-Location

Push-Location 090_DataFactory

az deployment group create --name "deployment-${RESOURCE_SUFFIX}-090" --resource-group "$RESOURCE_GROUP_NAME" --template-file "./main.bicep" `
                           --verbose --output "none" --parameters `
                             resourceSuffix="${RESOURCE_SUFFIX}" `
                             location="${LOCATION_NAME}"

Pop-Location
