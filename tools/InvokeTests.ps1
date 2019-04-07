#
# Script which invokes tests inside of Azure DevOps Pipelines
#

param (
    # Describes what type of tests to run
    [ValidateSet('FunctionalityOnly','DocumentationOnly','All')]
    [string]$TestsToRun
)

function InstallModule ([string]$Name,[version]$Version){
    if (!(Get-Module $Name -List | where Version -ge $Version)) {
        Write-Host "Installing $Name"
        Install-Module -Name $Name -Force -SkipPublisherCheck -Scope CurrentUser -Repository PSGallery
        Import-Module $Name
    }
    if ($env:TF_BUILD) {Get-Module $Name -List}
}

#
# Display diagnostic information
#

if ($env:TF_BUILD) {
    $PSVersionTable
    Get-ChildItem Env:\   
    Get-Module -ListAvailable | Format-Table -Property ModuleType, Name, Version
}

#
# Install Pester and Platy, if needed
#

InstallModule Pester '4.0.0'
InstallModule PlatyPS '0.14.0'
InstallModule PSScriptAnalyzer '1.17.0'


#
# Run Pester Tests
#

$here = Split-Path -Parent $MyInvocation.MyCommand.Path # tools folder
$root = (get-item $here).Parent.FullName                # module root folder
$tests = Join-Path $root 'Tests'                        # tests folder

switch ($TestsToRun) {
    'FunctionalityOnly' { $Tags = @('Functionality','Other') }
    'DocumentationOnly' { $Tags = @('Documentation','Other') }
    'All' { $Tags = @('Documentation','Functionality','Other') }
} 

Write-Host "Run Pester tests"
$Result = Invoke-Pester -Path "$tests/module", "$tests/functions" -Tag $Tags -PassThru -OutputFile PesterTestResults.xml
if ($Result.failedCount -ne 0) {Write-Error "Pester returned errors"}