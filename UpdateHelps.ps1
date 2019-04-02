break # seat-belt
New-ExternalHelp -Path .\Docs\ -OutputPath .\Docs\ -Force
New-ExternalHelpCab -CabFilesFolder .\Docs\ -LandingPagePath .\Docs\InstallGitModule.md -OutputFolder .\cab\
Update-Help -Module InstallGitModule