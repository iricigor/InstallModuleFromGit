#
# Script which invokes tests inside of Azure DevOps Pipelines
#

#
# Display diagnostic information
#

$PSVersionTable
Get-ChildItem Env:\

#
# Install Pester v4, if needed
#

if (!(Get-Module Pester -List | where Version -ge 4.0.0)) {
    Write-Host "`nInstalling Pester"
    Install-Module -Name Pester -Force -SkipPublisherCheck -Scope CurrentUser -Repository PSGallery
    Get-Module Pester -List
    Import-Module Pester
}


#
# Run Pester Tests
#

Write-Host "Run Pester tests"
$Result = Invoke-Pester -PassThru -OutputFile PesterTestResults.xml
if ($Result.failedCount -ne 0) {Write-Error "Pester returned errors"}