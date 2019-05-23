function Update-GitModule {

    [CmdletBinding(HelpUri='https://github.com/iricigor/InstallModuleFromGit/blob/master/Docs/Update-GitModule.md')]

    param (
        
        
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,Position=0)]
        [string[]]$ProjectUri,
        # https://github.com/dfinke/InstallModuleFromGitHub
        # https://github.com/iricigor/FIFA2018
        
        [string]$Branch = "master",
        [string]$DestinationPath = (Get-InstallPath),
        [switch]$Force

    )

    BEGIN {
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose -Message "$(Get-Date -f G) $FunctionName starting"

        if (!(Test-Prerequisites)) {
            throw "$FunctionName prerequisites not met"
            # TODO: Add more details
        }

        if ($env:AGENT_TEMPDIRECTORY) {
            $tmpRoot = $env:AGENT_TEMPDIRECTORY    
        } else {
            $tmpRoot = [System.IO.Path]::GetTempPath()
        }        

    }

    PROCESS {

        foreach ($P1 in $ProjectUri) {

            Write-Verbose -Message "$(Get-Date -f T)   processing $P1"

            $RemoteModuleInfo = Get-GitModule -ProjectUri $P1 -KeepTempCopy
            if (!$RemoteModuleInfo -or ($RemoteModuleInfo.Count -gt 1)) {continue} # we have the error in get-gitmodule
            $ModuleName = $RemoteModuleInfo.Name

            # TODO: continue only after cleanup!

            # Check version, and if higher install it
            $LocalModuleInfo = Get-Module -Name $ModuleName -ListAvailable | Sort-Object Version -Descending | Select -First 1
            if (!$LocalModuleInfo) {
                Write-Error "$FunctionName cannot find local module '$ModuleName'"
                continue
            }
            if ($LocalModuleInfo.Version -ge $RemoteModuleInfo.Version) {
                Write-Verbose "$(Get-Date -f T)   not updating module '$ModuleName', local version $($LocalModuleInfo.Version), remote version $($RemoteModuleInfo.Version)"
            } else {
                Install-ModuleInfo -ModuleInfo $RemoteModuleInfo -DestinationPath $DestinationPath -Force:$Force
            }
            
        }
    }

    END {
        Write-Verbose -Message "$(Get-Date -f G) $FunctionName completed"
    }

}