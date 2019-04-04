# Script should be executed manually by developer
$ModuleName = 'InstallModuleFromGit'

# check running folder
if (!(Test-Path "..\$ModuleName\$ModuleName.psd1")) {
    throw "We are not in correct folder, please run this tool as .\tools\PublishModule.ps1"
} else {
    "Checking module $(Resolve-Path "..\$ModuleName\$ModuleName.psd1")"
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
    "Module version $($Module.Version.ToString()) is OK"
}

# test if remote is not the same
if (Find-Module -Name $ModuleName -RequiredVersion ($Module.Version) -Repository PSGallery -ea 0) {
    throw 'Module with same version already exists'
} else {
    "No module with version $($Module.Version) found online"
}

# get nuget key from somewhere?
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
Copy-Item -Path . -Destination $Destination -Recurse # it creates folder $ModuleName

# remove not needed files (starting with dot and from .gitignore)
"Removing not needed files"
[string[]]$Exclude = (Get-Content '.gitignore')
Get-ChildItem -Path $Destination2 -Recurse -Force | where Name -Match '^\.' | Remove-Item -Recurse -Force
Get-ChildItem -Path $Destination2 -Include $Exclude -Recurse -Force | Remove-Item -Recurse -Force

# publish
Read-Host "All prerequisites check. Press Enter to Publish module or Ctrl+C to abort"
Publish-Module -Path $Destination2 -Repository PSGallery -NuGetApiKey $NugetKey -Verbose
"Module $ModuleName published to PowerShell Gallery"