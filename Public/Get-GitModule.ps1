function Get-GitModule {

    [CmdletBinding()]

    param (
        
        
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,Position=0)]
        [string[]]$ProjectUri,
        # https://github.com/dfinke/InstallModuleFromGitHub
        # https://github.com/iricigor/FIFA2018
        
        [string]$Branch = "master",
        [switch]$KeepTempCopy

    )

    BEGIN {
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose -Message "$(Get-Date -f G) $FunctionName starting"

        if (!(Test-Prerequisites)) {
            throw "$FunctionName prerequisites not met"
            # TODO: Add more details
        }

        $tmpRoot = [System.IO.Path]::GetTempPath()

    }

    PROCESS {

        foreach ($P1 in $ProjectUri) {

            Write-Verbose -Message "$(Get-Date -f T)   processing $P1"

            $ModuleName = ($P1 -split '/')[-1]
            $tempDir = Join-Path $tmpRoot $ModuleName
            Write-Verbose -Message "$(Get-Date -f T)   cloning repository to $tempDir"
            git clone $P1 --branch $Branch --single-branch $tempDir 2>&1 | Out-Null
            $psd1 = (Get-ChildItem $tempDir -Include *.psd1 -Recurse).FullName

            if($psd1 -is [array]) {
                $errorText = "$FunctionName found multiple module manifests for $ModuleName"
            } elseif (!($psd1 -is [string])) {
                $errorText = "$FunctionName found no module manifest for $ModuleName"
            } else {
                $ModuleVersion = (Get-Content -Raw $psd1 | Invoke-Expression).ModuleVersion
                $errorText = $null
            }

            if ($KeepTempCopy) {
                Write-Verbose -Message "$(Get-Date -f T)   not deleting temp copy"
            } else {
                Write-Verbose -Message "$(Get-Date -f T)   deleting temp copy"
                Remove-Item $tempDir -Force -Recurse | Out-Null
            }

            if ($errorText) {
                # we need to throw the error after deleting temp directory
                Write-Error $errorText
                continue
            }

            # return value
            Write-Verbose -Message "$(Get-Date -f T)   preparing return value"
            [PSCustomObject]@{
                Name = $ModuleName
                Version = $ModuleVersion
                Path = if ($KeepTempCopy) {$tempDir} else {$null}
                Root = ((Split-Path $psd1 -Parent) -eq $tempDir)
                Git = $P1
            }
        }
    }

    END {
        Write-Verbose -Message "$(Get-Date -f G) $FunctionName completed"
    }

}