function ConvertTo-Uri {
    # converts array of module names to uris based on projectUri field

    param (
        [Parameter(Mandatory)]
        [string[]]$Name
    )

    Write-Verbose -Message "$(Get-Date -f T)   searching module URIs from their names"
    foreach ($N1 in $Name) {
        $Module = Get-InstalledModule $N1 -ea 0
        if (!$Module) {$Module = Get-Module $N1 -ListAvailable -ea 0}

        if (!$Module) {
            Write-Error "$FunctionName found no module $N1"
            continue
        } 

        if (!($Module | ? ProjectUri)) {
            Write-Warning "$FunctionName found module $N1, but it has no ProjectUri information"
            continue
        }

        # return information to $ProjectUri variable
        $Module | Sort-Object Version | Select-Object -Last 1 -ExpandProperty ProjectUri
    }
}