function Get-InstallPath {

    # returns OS specific path for module installation, it support only -Scope CurrentUser
    if ($IsLinux -or $IsOSX) {
        "$HOME/.local/share/powershell/Modules"
    } else {
        # https://github.com/PowerShell/PowerShellGet/blob/8004c304a2fa8ad32b92c6c2ba7efe116df3c862/src/PowerShellGet/private/modulefile/PartOne.ps1#L46
        try {
            if ($PSVersionTable.PSEdition -eq 'Core') {
                [Environment]::GetFolderPath("MyDocuments") + '\PowerShell\Modules'
            } else {
                [Environment]::GetFolderPath("MyDocuments") + '\WindowsPowerShell\Modules'
            }            
        } catch {
            "$home\Documents\PowerShell\Modules"
        }
    }

}