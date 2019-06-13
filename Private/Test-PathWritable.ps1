function Test-PathWritable {
    param (
        [string]$Path
    )
    # returns true if given directory is writable, false otherwise
    if (!(Test-Path $Path -PathType Container)) {
        #throw "Path $Path is not a directory"
        $false
    }

    $FileName = Join-Path $Path ([io.path]::GetRandomFileName())

    try {
        [io.file]::OpenWrite($FileName).close()
        [io.file]::Delete($FileName)
        $true
    } catch {
        $false
    }
    
}