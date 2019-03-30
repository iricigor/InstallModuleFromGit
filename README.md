# InstallGitModule

Helps installing modules directly from GitHub or Azure DevOps

## Prerequisites

* **git** - it must be installed and available on path

## Installation

### clone GitHub repository

```PowerShell
git clone https://github.com/iricigor/InstallGitModule
Import-Module ./InstallGitModule/InstallGitModule.psd1
```

### from PowerShell gallery

_(not yet available)_

## Examples

```PowerShell
C:> Get-GitModule 'https://github.com/iricigor/FIFA2018' -Verbose

C:> Install-GitModule 'https://github.com/iricigor/psaptgetupdate' | Select -Expand Name | Import-Module
```

## Commands

### Get-GitModule

### Install-GitModule

## Tests

So far testing is very basic.

Windows build status [![Build Status](https://dev.azure.com/iiric/PS1/_apis/build/status/InstallGitModule%20-%20Win%20CI?branchName=master)](https://dev.azure.com/iiric/PS1/_build/latest?definitionId=16&branchName=master)

Linux build status [![Build Status](https://dev.azure.com/iiric/PS1/_apis/build/status/InstallGitModule%20-%20Linux%20CI?branchName=master)](https://dev.azure.com/iiric/PS1/_build/latest?definitionId=17&branchName=master)

_Click on images to see details about latest build runs._

## Similar versions

[dfinke](https://github.com/dfinke)/[InstallModuleFromGitHub](https://github.com/dfinke/InstallModuleFromGitHub)