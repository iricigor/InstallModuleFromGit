<img align="right" width="203" height="294" src="img/InstallModuleFromGit.logo.png">

# Install Module from Git

:bowtie: This PowerShell module will help you to easily instal PowerShell modules directly from [Azure DevOps](https://azure.microsoft.com/en-us/services/devops/repos/) (_aka VSTS_) or [GitHub](https://github.com/) or any other git repository.
All you need to know is a URL of the git repository and the module will take care of everything else.

The module is compatible both with **Linux** and **Windows** versions of PowerShell _(Windows PowerShell 5 or PowerShell Core 6)_.

## Prerequisites

:exclamation: **Git** client must be installed and available on path.
If you don't have it, you can get it for example from [git-scm.com](https://git-scm.com/downloads).
You can check if you have it by running `Get-Command git` in your PowerShell.

## Installation

### from PowerShell gallery

:dash: _(not yet available)_

### clone GitHub repository

```PowerShell
git clone https://github.com/iricigor/InstallModuleFromGit
Import-Module ./InstallModuleFromGit/InstallModuleFromGit.psd1
# and this is the last time you will be doing it like this

# after you install this module you can do it like this
Install-GitModule https://github.com/iricigor/InstallModuleFromGit
```

## Examples

```PowerShell
# Check for module existence and its version
PS:\> Get-GitModule 'https://github.com/iricigor/FIFA2018' -Verbose

# Download and import module in one line
PS:\> (Install-GitModule 'https://github.com/iricigor/psaptgetupdate').Name | Import-Module
```

## Commands

### Get-GitModule

Checks for module existence and returns its version. More info [here](/Docs/Get-GitModule.md).

### Install-GitModule

Installs PowerShell module to user's default install folder. More info [here](/Docs/Install-GitModule.md).

## Tests

:smirk: So far the module has a basic testing only, but it is doing that against two platforms - Linux and Windows. Tests results are available on the Tests tab ([example here](/img/TestResults-AzureDevops.png)).

Windows build status [![Build Status](https://dev.azure.com/iiric/PS1/_apis/build/status/InstallModuleFromGit%20-%20Win%20CI?branchName=master)](https://dev.azure.com/iiric/PS1/_build/latest?definitionId=16&branchName=master)

Linux build status [![Build Status](https://dev.azure.com/iiric/PS1/_apis/build/status/InstallModuleFromGit%20-%20Linux%20CI?branchName=master)](https://dev.azure.com/iiric/PS1/_build/latest?definitionId=17&branchName=master)

_Click on images to see details about the latest build runs._

## Similar PowerShell modules

- :mega: [dfinke](https://github.com/dfinke)/[InstallModuleFromGitHub](https://github.com/dfinke/InstallModuleFromGitHub)
  - (pluses) does not require git client
  - (minuses) works only with GitHub