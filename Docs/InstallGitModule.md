---
Module Name: InstallGitModule
Module Guid: d6a1577c-e3b5-48f2-a698-f08ab4865a58
Download Help Link: https://github.com/iricigor/InstallGitModule/raw/master/cab/
Help Version: 1.0.0.0
Locale: en-US
---

# InstallGitModule Module
## Description
This PowerShell module will be help you to easily instal PowerShell modules directly from [Azure DevOps](https://azure.microsoft.com/en-us/services/devops/repos/) (_aka VSTS_) or [GitHub](https://github.com/).
All you need to know is a URL of the git repository and the module will take care of everything else.

## InstallGitModule Cmdlets
### [Get-GitModule](Get-GitModule.md)
This cmdlet will check for existence of PowerShell module in given repository and return its version.

### [Install-GitModule](Install-GitModule.md)
This cmdlet installs PowerShell module specified by its git repository URL to user's default install directory.

