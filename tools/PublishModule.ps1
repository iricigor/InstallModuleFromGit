# Script should be executed manually by developer
$ModuleName = 'InstallModuleFromGit'

# check running folder
if ((Test-Path "..\$ModuleName\$ModuleName.psd1") -or ((Test-Path "..\s\$ModuleName.psd1"))) {
    "Checking module $(Resolve-Path ".\$ModuleName.psd1")"
} else {
    throw "We are not in correct folder, please run this tool as .\tools\PublishModule.ps1"
}

# test manifest
try {
    $Module = Test-ModuleManifest "$ModuleName.psd1" -ea Stop
    "Module $ModuleName.psd1 is OK"
} catch {
    throw 'Module manifest not in proper format'
}

# test version, must be x.y.z
if (($Module.Version.ToString() -split '\.').Count -lt 3) {
    throw "Module version must have three segments at least, currently it is $($Module.Version.ToString())"
} else {
    "Module version tag '$($Module.Version.ToString())' is OK"
}

# test if remote is not the same
"Checking for module with version $($Module.Version) online..."
if (Find-Module -Name $ModuleName -RequiredVersion ($Module.Version) -Repository PSGallery -ea 0) {
    throw 'Module with same version already exists'
} else {
    "No module with version $($Module.Version) found online"
}

if ($Env:NugetKey) {$NugetKey = $Env:NugetKey}
if ($NugetKey) {
    "NugetKey found"
} else {
    throw 'Please define $NugetKey variable (run $NugetKey = Read-Host)'
}

# copy entire folder to temp location
if ($IsLinux -or $IsMacOS) {$Destination = '/tmp'}
else {$Destination = $Env:TEMP}

$Destination2 = Join-Path $Destination $ModuleName
"Copying to $Destination2"
if (Test-Path $Destination2) {Remove-Item $Destination2 -Recurse -Force}
if ($Env:TF_BUILD -eq 'True') {
    Copy-Item -Path .\* -Destination $Destination2 -Recurse # it creates folder $ModuleName    
} else {
    Copy-Item -Path . -Destination $Destination -Recurse # it creates folder $ModuleName
}

# remove not needed files (as per .publishignore)
"Removing not needed files"
$pwdLength = $Destination2.Length + 1
foreach ($line in (Get-Content '.publishignore'| where {$_ -notlike '#*'})) {
    #"Checking files like $line"
    foreach ($file in (Get-ChildItem -Path $Destination2 -Recurse -Force -File)) {
        $relativeName = $file.FullName.Substring($pwdLength) -replace '\\','/'
        #"$relativeName"
        if ($relativeName -like $line) {
            "Removing $relativeName"
            Remove-Item $file.FullName -Recurse -Force
        }        
    } 
}

# publish
if ($Env:TF_BUILD -eq 'True') {
    if ($Env:ModuleVersionToPublish -eq $Module.Version) {
        Publish-Module -Path $Destination2 -Repository PSGallery -NuGetApiKey $NugetKey -Verbose
        "Module $ModuleName published to PowerShell Gallery"    
    } else {
        throw "Mismatching module versions $($Env:ModuleVersionToPublish) and $($Module.Version), please update pipeline variable ModuleVersionToPublish"
    }
} else {
    Read-Host "All prerequisites check. Press Enter to Publish module or Ctrl+C to abort"
    Publish-Module -Path $Destination2 -Repository PSGallery -NuGetApiKey $NugetKey -Verbose
    "Module $ModuleName published to PowerShell Gallery"
}

