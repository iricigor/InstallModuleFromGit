# Script should be executed manually by developer
$ModuleName = 'InstallModuleFromGit'
$InVSTS = [bool]($Env:TF_BUILD -eq 'True')


if ($Env:TF_BUILD -ne 'True') {
    throw 'This script should be executed only from VSTS. Please use the other publishing script.'
}


# check running folder
if (Test-Path "..\s\$ModuleName.psd1") {
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


# test if the module is not already published with same version number
"Checking for module with version $($Module.Version) online..."
if (Find-Module -Name $ModuleName -RequiredVersion ($Module.Version) -Repository PSGallery -ea 0) {
    throw 'Module with same version already exists'
} else {
    "No module with version $($Module.Version) found online"
}


# get publishing key from pipeline or directly
if ($Env:NugetKey) {
    "NugetKey found"
} else {
    throw 'Please define NugetKey (secret) variable'
}

# copy entire folder to temp location
if ($IsLinux -or $IsMacOS) {$Destination = '/tmp'} else {$Destination = $Env:TEMP}
$Destination2 = Join-Path $Destination $ModuleName
if (Test-Path $Destination2) {Remove-Item $Destination2 -Recurse -Force}

"Copying to $Destination2"
New-Item -Path $Destination2 -ItemType Directory | Out-Null
Get-ChildItem -Force | Copy-Item -Destination $Destination2 -Container -Recurse
"`nverifying content of $Destination2"
Get-ChildItem $Destination2 -Force


# remove not needed files (as per .publishignore)
"Removing not needed files"
$pwdLength = (Get-Item $Destination2).FullName.Length + 1 # expands 'C:\Users\VSSADM~1\AppData\Local\Temp'
foreach ($line in (Get-Content '.publishignore'| where {$_ -notlike '#*'})) {
    "Checking files like $line"
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
"Publishing total of $((Get-ChildItem $Destination2 -Recurse -File).Count) files"
Get-ChildItem $Destination2 -Recurse -File
if ($Env:ModuleVersionToPublish -eq $Module.Version) {
    Publish-Module -Path $Destination2 -Repository PSGallery -NuGetApiKey $NugetKey -Verbose
    "Module $ModuleName published to PowerShell Gallery"    
} else {
    throw "Mismatching module versions $($Env:ModuleVersionToPublish) and $($Module.Version), please update pipeline variable ModuleVersionToPublish"
}
