function Install-ModuleInfo {

    param(
        [PSObject]$ModuleInfo,
        [string]$DestinationPath,
        [switch]$Force
    )

    # verify properties
    if (!$ModuleInfo.Root) {
        Write-Warning -Message "$FunctionName installing module with manifest not located in module root directory"
    }
    if (!$ModuleInfo.SameName) {
        Write-Warning -Message "$FunctionName installing module with module name not the same as its directory name"
    }

    # check target directory
    $TargetDir = Join-Path (Join-Path $DestinationPath $ModuleInfo.Name) $ModuleInfo.Version
    if (!(Test-Path $TargetDir)) {
        New-Item $TargetDir -ItemType Directory -Force | Out-Null
    } elseif ((Get-ChildItem $TargetDir) -and (!$Force)) {
        Write-Error "$FunctionName cannot install into non-empty directory $TargetDir, use different -Destination or -Force to override it"
        continue
    }
    
    # copy module
    Write-Verbose -Message "$(Get-Date -f T)   installing module to $TargetDir"
    Copy-Item "$($ModuleInfo.LocalPath)/*" $TargetDir -Force -Recurse | Out-Null
    
    # clean up
    $gitDir = Join-Path $TargetDir '.git'
    if (Test-Path $gitDir) {Remove-Item $gitDir -Recurse -Force}
    Remove-Item $ModuleInfo.LocalPath -Recurse -Force | Out-Null
    Write-Verbose -Message "$(Get-Date -f T)   module $ModuleName installation completed"

    # return value
    $ModuleInfo.LocalPath = $TargetDir
    $ModuleInfo
}