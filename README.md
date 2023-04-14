# What is BenchPress?

![image](https://user-images.githubusercontent.com/118744/231942183-6026270a-1fcc-437b-b15d-a2dcf64eb41f.png)

_Benchpress_ is an _infrastructure testing framework for Azure Deployment scenarios_. Regardless of the resource deployment mechanism utilized on _Azure_, such as _ARM Templates_, _Azure CLI_ commands, _Bicep_ files/modules, or the _Azure Portal_ (collectively referred to as Click-Ops), _BenchPress_ can be used.

## Why infrastructure testing is important?

When working on a project, such as a web project, it is widely understood that tests are crucial, particularly in the long term.

Without thorough testing, we can't be 100% sure that the upcoming changes don't break the app. So we have to live in fear, on the edge, and it's not good.

To avoid such unease and enjoy uninterrupted leisure time, it is advisable to have automated tests in place.

In the field of application development, we have matured testing approaches, facilities, frameworks, and automation capabilities.

After the rising of cloud systems, and pipeline orchestrators, and infrastructure as code tools/languages/frameworks, we started to realize that we have the same testing needs, with the same reasons, to our projects infrastructure code.

One of the good questions is, _How we can ensure the infra is in good state?_

An answer would be using the _BenchPress_ 🙂

Basically, with _BenchPress_, we test the existence and the configuration of the resources on an environment.

## Locations we can run the tests

You can run the tests on your local environment, on your machine, etc. , or, you can automate the tests on an orchestrator, like Azure DevOps pipelines, or even better, with GitHub Actions 🙂

## Types of tests

Similar to the various types of tests that can be developed for application code, we can create different kinds of tests for our infrastructure as well.

BenchPress offers support for both module and end-to-end tests.

From a high-level perspective,

Module tests are focused on a specific infrastructure component. We provision the resources on an ephemeral environment, configure them, execute tests (such as BenchPress tests), and then delete the ephemeral environment. This approach provides the assurance that the resource set can be safely and correctly deployed to the environment, as expected with the code.

In contrast, end-to-end tests do not entail deploying resources. We assume that the environment is already deployed, configured, and functioning correctly. The purpose of these tests is to ensure that the application is functioning and configured as anticipated, and the configuration complies with the project or company policy.

## How BenchPress developed

_Benchpress_ is open sourced and available on [BenchPress repo](https:github.com/azure/benchpress) on Azure org on GitHub.

_BenchPress_ code itself is in Powershell, and the tests that use _BenchPress_ is in Powershell too. Powershell Core can be used to run the _BenchPress_ tests, and since PowerShell Core is platform agnostic, it's possible to develop and run tests on Windows, Linux and Mac environments.

## Installation

![image](https://user-images.githubusercontent.com/118744/231942348-c95613e9-3a19-4574-b1bf-b8258691caba.png)

There are two main ways to install _Benchpress_, using Powershell Gallery, or cloning the benchpress repo itself.

_Benchpress_ published on Powershell Gallery as Az.InfrastructureTesting, to align with the other az modules, like Az.Storage, etc. we internally and externally call the project as _Benchpress_, but it's published to Powershell Gallery as Az.InfrastructureTesting.

## Creating Tests

In BenchPress version 0.2, you can provide a Bicep file or an ARM Template JSON file, and the generator will create a suite of tests based on the file contents for you. This functionality eliminates the need to begin the testing process from scratch. Instead, you can start with the pre-existing generated tests and make any necessary modifications by adding or removing tests.

## Running Tests

Running the tests are pretty similar in a local environment or in a pipeline. You can just call `Invoke-Pester` command to run all the tests in the folder, or you can provide the test filename to `Invoke-Pester` command to run the tests in a specific file, or you can simply call the test script file directly.

## Analyzing Test Results

After executing the tests, we can simply check the log messages in the terminal, or publish the results as an artifact in the orchestrator, and investigate results afterwards. And BenchPress is using Powershell Pester test runner under the hood, so, it's possible to export test results in different formats, like NUnit, JUnit, etc. and since the results are in an xml shape, we can use 3rd party apps to query or analyze them too.

## Demos

There are two demos in this repo, one is a complex demo, and the other one is a simple demo.

### Complex Demo

demo-app-0 has infrastructure layers, that's responsible to deploy portion of the whole infrastructure. Like, the (010) jumpbox vm and related resources, (020) vnet, subnet, network watcher storage, (060) app service plan, function app, etc. so, all of the resources are split into folders based on the responsibilities or based on the teams that is managing the resources

probably the company we're working with (or the project we're working on) has some policies in place that requires us to configure certain resources in a certain way.

we can assure that configuration by adding infrastructure tests and automate them using pipelines, etc.

in the test folder, we have bunch of test files, test files has three main sections, BeforeAll, Describes, and AfterAll;

In BeforeAll and AfterAll sections, basically we import the BenchPress module, do some setup stuff, and do cleanups. like deleting the environment, etc.

Test scripts may have one describe section, or more than one Describe section, to group the actual tests, based on the resource types or the reason we have those certain resources, etc.

When BenchPress module imported, powershell commandlets starting with Confirm-AzBP will be able to accessible.

basically, almost all benchpress commandlets are expecting you to provide the resourcegroupname and the name of the resource. and it returns back, the authentication related data, like which service principal is used, which subscription and tenant are connected to, etc. and the data of the resource itself.

all the configuration of the resource can be accessible by the resourcedetails property.

like, if it's a resource group, we have tags, if it's a storage account, we have accesstier, if it's a service plan, we have sku size, etc. with many other fields, or properties.

we have it sections under a describe section, and it sections are the place we code our actual tests. there can be many it sections in a describe section.

and we follow the most common test development approaches, one of them is having arrange-act-assert sections.

in the arrange section we populate the variables with the values that reference to the resource under the test.
in the act section, we go to the azure environment and get all the properties that we can find about the resource.
in the assert section, we basically assert the actual values of properties that we want to check with the expected values.

one of the most basic tests that we can develop, could be the existence check test.

we get the result of the benchpress commandlet, and check if the resource is deployed by calling "Should -BeSuccessful" helper.

other tests, can check one of the properties of the resourcedetails with the expected value. like kind should be functionapp, or, httpsonly should be true.

### Simple Demo

The demo includes the following deployed resources:

* [Application Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview?tabs=net)
* [Action Group](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/action-groups)
* [App Service Plan](https://learn.microsoft.com/en-us/azure/app-service/overview)
* [Web App](https://azure.microsoft.com/en-us/products/app-service/web)

#### Demo App Files

* [main.bicep](main.bicep) - Bicep module used to deploy the demo application infrastructure
* [deploy-demoapp.ps1](deploy-demoapp.ps1) - PowerShell script used to deploy the infrastructure and the demo application
* [DemoApp.Tests.ps1](DemoApp.Tests.ps1) - PowerShell script used to run the Benchpress tests against the demo application
* [demoapp-pipeline.yml](demoapp-pipeline.yml) - GitHub Action YAML file used to deploy the demo application infrastructure and run the Benchpress tests

#### Guidelines for creating and testing a demo application

1. Navigate to demo directory:

  ```powershell
  cd assets\demo\
  ```

2. Run the [deploy-demoapp.ps1](deploy-demoapp.ps1) script to deploy the demo application infrastructure and the demo application.

  ```powershell
  ./deploy-demoapp.ps1
  ```

#### Running the tests

- Run the tests by calling the test script file, or, `Invoke-Pester` command

```powershell
./DemoApp.Tests.ps1
```

```powershell
Invoke-Pester -Path .\DemoApp.Tests.ps1
```

#### Cleaning up the demo application

```powershell
az group delete --name "benchpress-rg-${env:ENVIRONMENT_SUFFIX}" --yes
```

#### Running the deployment, tests, and cleanup together

```powershell
./deploy-demoapp.ps1
./DemoApp.Tests.ps1
az group delete --name "benchpress-rg-${env:ENVIRONMENT_SUFFIX}" --yes
```

## Contribution

BenchPress is open sourced under the Azure org. and it's open to contribution.

You can create a PR, you can request a feature, you can report issues, you can join discussions, anything will be more than welcome.
