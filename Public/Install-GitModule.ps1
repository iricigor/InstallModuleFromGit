function Install-GitModule {

    [CmdletBinding(HelpUri='https://github.com/iricigor/InstallModuleFromGit/blob/master/Docs/Install-GitModule.md')]

    param (
        
        
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
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

        $tmpRoot = [System.IO.Path]::GetTempPath()

        # TODO: Check if this is inside of $env:PSModulePath
        if ($DestinationPath -notin ($env:PSModulePath -split ';')) {
            Write-Warning -Message "$FunctionName using path which is not in `$Env:PSModulePath ($DestinationPath)"
        }


    }

    PROCESS {

        foreach ($P1 in $ProjectUri) {

            Write-Verbose -Message "$(Get-Date -f T)   processing $P1"

            $ModuleInfo = Get-GitModule -ProjectUri $P1 -KeepTempCopy
            if (!$ModuleInfo -or ($ModuleInfo.Count -gt 1)) {continue} # we have the error in get-gitmodule
            
            Install-ModuleInfo -ModuleInfo $ModuleInfo -DestinationPath $DestinationPath -Force:$Force
        }
    }

    END {
        Write-Verbose -Message "$(Get-Date -f G) $FunctionName completed"
    }

}