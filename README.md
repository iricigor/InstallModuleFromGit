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

### From PowerShell gallery

This is recommended way how to install module.

```PowerShell
Install-Module InstallModuleFromGit -Scope CurrentUser
```
[![downloads](https://img.shields.io/powershellgallery/dt/InstallModuleFromGit.svg?label=downloads)](https://www.powershellgallery.com/packages/InstallModuleFromGit)
[![latest version](https://img.shields.io/powershellgallery/v/InstallModuleFromGit.svg?label=latest+version)](https://www.powershellgallery.com/packages/InstallModuleFromGit)

### Clone GitHub repository

```PowerShell
git clone https://github.com/iricigor/InstallModuleFromGit
Import-Module ./InstallModuleFromGit/InstallModuleFromGit.psd1
```

### Using this module

If you have this module already installed, you can install latest / not-yet-published version from this GitHUb repository using the module itself!
As all commits are verified before and after they are merged to master branch, this should be pretty safe operation also.

```PowerShell
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

### Module

The module Install Module From Git exposes two new commandlets. More info on module [here](/Docs/InstallModuleFromGit.md).

Module provides updatable help system, though it is working currently only on Windows PowerShell. Tracking issue is [here](https://github.com/iricigor/InstallModuleFromGit/issues/3).

```PowerShell
Update-Help -Module InstallModuleFromGit -Force
```

### Get-GitModule

Checks for module existence and returns its version. More info [here](/Docs/Get-GitModule.md).

### Install-GitModule

Installs PowerShell module to user's default install folder. More info [here](/Docs/Install-GitModule.md).

## Tests

:smirk: Module has testing against two platforms - Linux and Windows. Code is verified before and after merging to master branch. Tests results are available on the Tests tab ([example here](/img/TestResults-AzureDevops.png)).

Windows build status [![Build Status](https://dev.azure.com/iiric/PS1/_apis/build/status/InstallModuleFromGit%20-%20Win%20CI?branchName=master)](https://dev.azure.com/iiric/PS1/_build/latest?definitionId=16&branchName=master)

Linux build status [![Build Status](https://dev.azure.com/iiric/PS1/_apis/build/status/InstallModuleFromGit%20-%20Linux%20CI?branchName=master)](https://dev.azure.com/iiric/PS1/_build/latest?definitionId=17&branchName=master)

_Click on images to see details about the latest build runs._

## Similar PowerShell modules

- :mega: [dfinke](https://github.com/dfinke)/[InstallModuleFromGitHub](https://github.com/dfinke/InstallModuleFromGitHub), (pluses) does not require git client, (minuses) works only with GitHub

## Support

You can chat about this commandlet via [Skype](https://www.skype.com) _(no Skype ID required)_, by clicking a link below.

[![chat on Skype](https://img.shields.io/badge/chat-on%20Skype-blue.svg?style=flat)](https://join.skype.com/hQMRyp7kwjd2)

## Contributing

If you find any problems, feel free to [open a new issue](https://github.com/iricigor/InstallModuleFromGit/issues/new).

![GitHub open issues](https://img.shields.io/github/issues/iricigor/InstallModuleFromGit.svg?style=flat)
![GitHub closed issues](https://img.shields.io/github/issues-closed/iricigor/InstallModuleFromGit.svg?style=flat)

If you want to contribute, please fork the code and make a new PR after!

![GitHub](https://img.shields.io/github/license/iricigor/InstallModuleFromGit.svg?style=flat)
![GitHub top language](https://img.shields.io/github/languages/top/iricigor/InstallModuleFromGit.svg?style=flat)