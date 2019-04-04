#
# Script which invokes tests inside of Azure DevOps Pipelines
#

#
# Display diagnostic information
#

if ($env:TF_BUILD) {
    $PSVersionTable
    Get-ChildItem Env:\   
    Get-Module -ListAvailable 
}

#
# Install Pester and Platy, if needed
#

if (!(Get-Module Pester -List | where Version -ge 4.0.0)) {
    Write-Host "`nInstalling Pester"
    Install-Module -Name Pester -Force -SkipPublisherCheck -Scope CurrentUser -Repository PSGallery
    Get-Module Pester -List
    Import-Module Pester
}

if (!(Get-Module PlatyPS -List | where Version -ge 0.14.0)) {
    Write-Host "`nInstalling Pester"
    Install-Module -Name PlatyPS -Force -SkipPublisherCheck -Scope CurrentUser -Repository PSGallery
    Get-Module PlatyPS -List
    Import-Module PlatyPS
}


#
# Run Pester Tests
#

Write-Host "Run Pester tests"
$Result = Invoke-Pester -PassThru -OutputFile PesterTestResults.xml
if ($Result.failedCount -ne 0) {Write-Error "Pester returned errors"}