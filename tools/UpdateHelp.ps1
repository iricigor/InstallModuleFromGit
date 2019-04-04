break # seat-belt
$ModuleName='InstallModuleFromGit'

if (!(Test-Path '.\Docs')) {
    throw 'Please run this as .\tools\UpdateHelps.ps1'
}

# just initial time, or with good backup, run next command
# New-MarkdownHelp -Module InstallModuleFromGit -OutputFolder .\Docs -WithModulePage -Force

New-ExternalHelp -Path .\Docs\ -OutputPath .\Docs\ -Force
New-ExternalHelpCab -CabFilesFolder .\Docs\ -LandingPagePath ".\Docs\$ModuleName.md" -OutputFolder .\cab\
Update-Help -Module $ModuleName -Verbose