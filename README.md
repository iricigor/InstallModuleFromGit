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

## Similar versions

[dfinke](https://github.com/dfinke)/[InstallModuleFromGitHub](https://github.com/dfinke/InstallModuleFromGitHub)