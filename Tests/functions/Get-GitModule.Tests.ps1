#
# This is a PowerShell Unit Test file.
# You need a unit test framework such as Pester to run PowerShell Unit tests.
# You can download Pester from http://go.microsoft.com/fwlink/?LinkID=534084
#

$CommandName = 'Get-GitModule'

Describe "$CommandName basic testing" -Tag 'Functionality' {

    $moduleName = 'FIFA2018'
    $moduleURL = 'https://github.com/iricigor/' + $moduleName

    It "$CommandName does not throw an exception" {
        {Get-GitModule $moduleURL} | Should -Not -Throw
    }

    It "$CommandName returns some value" {
        Get-GitModule $moduleURL | Should -Not -Be $null
    }

    It "$CommandName returns proper value" {
        (Get-GitModule $moduleURL).Name | Should -Be $moduleName
    }

    It "$CommandName properly parses retrieved module" {
        (Get-GitModule $moduleURL).SameName | Should -Be $true
    }

    $moduleName = 'HBOParser'
    $moduleURL = 'https://github.com/iricigor/' + $moduleName
    It "$CommandName reads repository without psd1" {
        (Get-GitModule $moduleURL).Name | Should -Be $moduleName
    }

    $moduleName = 'FIFA2018'
    Install-Module -Name $moduleName -Repository PSGallery
    It "$CommandName finds module $moduleName by name" {
        (Get-GitModule -Name $moduleName).Name | Should -Be $moduleName
    }

}
