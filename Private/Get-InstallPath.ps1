function Get-InstallPath {

    # returns OS specific path for module installation, it support only -Scope CurrentUser
    
    $defaultPath = if ($IsLinux -or $IsOSX) {
        #"$HOME/.local/share/powershell/Modules"
        # https://github.com/PowerShell/PowerShellGet/blob/d4dfebbbec4dfbe73392719a8a331541ed75d508/src/PowerShellGet/private/modulefile/PartOne.ps1#L71
        Join-Path (Split-Path -Path ([System.Management.Automation.Platform]::SelectProductNameForDirectory('USER_MODULES')) -Parent) 'Modules'
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

    $ModulePaths = $Env:PSModulePath -split (';:'[[int]($IsLinux -or $IsMacOS)])
    if ($defaultPath -in $ModulePaths) {
        $defaultPath
    } else {
        # default path is not in findable by get-module, try to avoid it
        $writablePath = ''
        foreach ($P1 in $ModulePaths) {
            if (([string]::IsNullOrEmpty($writablePath)) -and (Test-PathWritable $P1)) {
                $writablePath = $P1
            }
        }
        if ([string]::IsNullOrEmpty($writablePath)) {
            # we found no writable paths, return default one
            $defaultPath
        } else {
            $writablePath
        }
    }
}