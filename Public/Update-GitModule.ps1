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

            $ModuleInfo = Get-GitModule -ProjectUri $P1 -KeepTempCopy
            if (!$ModuleInfo -or ($ModuleInfo.Count -gt 1)) {continue} # we have the error in get-gitmodule

            # TODO: Check version, and if higher install it
            # TODO: Unify code for two scripts: this and Install-GitModule
        }
    }

    END {
        Write-Verbose -Message "$(Get-Date -f G) $FunctionName completed"
    }

}