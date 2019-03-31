function Install-GitModule {

    [CmdletBinding()]

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
            if (!$ModuleInfo -or ($ModuleInfo.Count -gt 1)) {
                Write-Verbose "Count: " + ($ModuleInfo.Count)
                Write-Verbose "Names: " + ($ModuleInfo.Name -join ',')
                Write-Error "$FunctionName cannot identify unique module"
                continue
            } # we have the error in get-gitmodule
            if (!$ModuleInfo.Root) {Write-Warning -Message "$FunctionName installing module with manifest not located in module root directory"}

            # check target directory
            $TargetDir = Join-Path (Join-Path $DestinationPath $ModuleInfo.Name) $ModuleInfo.Version
            if (!(Test-Path $TargetDir)) {
                New-Item $TargetDir -ItemType Directory -Force
            } elseif ((Get-ChildItem $TargetDir) -and (!$Force)) {
                Write-Error "$FunctionName cannot install into non-empty directory $TargetDir, use different -Destination or -Force to override it"
                continue
            }
            
            # copy module
            Write-Verbose -Message "$(Get-Date -f T)   installing module to $TargetDir"
            Copy-Item "$($ModuleInfo.Path)/*" $TargetDir -Force -Recurse | Out-Null
            
            # clean up
            $gitDir = Join-Path $TargetDir '.git'
            if (Test-Path $gitDir) {Remove-Item $gitDir -Recurse -Force}
            Remove-Item $ModuleInfo.Path -Recurse -Force | Out-Null
            Write-Verbose -Message "$(Get-Date -f T)   module $ModuleName installation completed"

            # return value
            $ModuleInfo.Path = $TargetDir
            $ModuleInfo
        }
    }

    END {
        Write-Verbose -Message "$(Get-Date -f G) $FunctionName completed"
    }

}