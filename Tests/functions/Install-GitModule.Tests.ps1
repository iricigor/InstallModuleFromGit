#
# This is a PowerShell Unit Test file.
# You need a unit test framework such as Pester to run PowerShell Unit tests.
# You can download Pester from http://go.microsoft.com/fwlink/?LinkID=534084
#

$CommandName = 'Install-GitModule'

Describe "$CommandName basic testing" -Tag 'Functionality' {

    $moduleName = 'psaptgetupdate'
    $moduleURL = 'https://github.com/iricigor/' + $moduleName

    It "$CommandName does not throw an exception" {
        {Install-GitModule $moduleURL -Force} | Should -Not -Throw
    }

    It "$CommandName returns some value" {
        Install-GitModule $moduleURL -Force | Should -Not -Be $null
    }

    It "$CommandName returns proper value" {
        (Install-GitModule $moduleURL -Force).Name | Should -Be $moduleName
    }

    It "$CommandName really installs module" {
        Get-Module $moduleName -ListAvailable | Should -Not -Be $null
    }
}