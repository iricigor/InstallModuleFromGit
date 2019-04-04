break # seat-belt
$ModuleName='InstallModuleFromGit'

if (!(Test-Path '.\Docs')) {
    throw 'Please run this as .\tools\UpdateHelps.ps1'
}

New-ExternalHelp -Path .\Docs\ -OutputPath .\Docs\ -Force
New-ExternalHelpCab -CabFilesFolder .\Docs\ -LandingPagePath ".\Docs\$ModuleName.md" -OutputFolder .\cab\
Update-Help -Module $ModuleName -Verbose