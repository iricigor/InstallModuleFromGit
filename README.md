<img align="right" width="203" height="294" src="InstallGitModule.logo.png">

# Install Git Module

:bowtie: This PowerShell module will be help you to easily instal PowerShell modules directly from Azure DevOps (aka VSTS) or GitHub.
All you need to know is a URL of the git repository and the module will take care of everything else.

## Prerequisites

* :exclamation: **git** - Git must be installed and available on path. If you don't have it, you can get it for example from [git-scm.com](https://git-scm.com/downloads).

## Installation

### clone GitHub repository

```PowerShell
git clone https://github.com/iricigor/InstallGitModule
Import-Module ./InstallGitModule/InstallGitModule.psd1
# and this is the last time you will be doing it like this

# after you install this module you can do it like this
Install-GitModule https://github.com/iricigor/InstallGitModule
```

### from PowerShell gallery

:dash: _(not yet available)_

## Examples

```PowerShell
# Check for module existance and its version
C:> Get-GitModule 'https://github.com/iricigor/FIFA2018' -Verbose

# Download and import module in one line
C:> (Install-GitModule 'https://github.com/iricigor/psaptgetupdate').Name | Import-Module
```

## Commands

### Get-GitModule

Checks for module existence and returns its version. More info [here](/Docs/Get-GitModule.md).

### Install-GitModule

Installs PowerShell module to user's default install folder. More info [here](/Docs/Install-GitModule.md).

## Tests

:smirk: So far the module have very very basic testing, but it is doing that against two platforms - Linux and Windows.

Windows build status [![Build Status](https://dev.azure.com/iiric/PS1/_apis/build/status/InstallGitModule%20-%20Win%20CI?branchName=master)](https://dev.azure.com/iiric/PS1/_build/latest?definitionId=16&branchName=master)

Linux build status [![Build Status](https://dev.azure.com/iiric/PS1/_apis/build/status/InstallGitModule%20-%20Linux%20CI?branchName=master)](https://dev.azure.com/iiric/PS1/_build/latest?definitionId=17&branchName=master)

_Click on images to see details about latest build runs._

## Similar PowerShell modules

:mega: [dfinke](https://github.com/dfinke)/[InstallModuleFromGitHub](https://github.com/dfinke/InstallModuleFromGitHub)