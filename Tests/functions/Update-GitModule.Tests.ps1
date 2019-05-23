#
# This is a PowerShell Unit Test file.
# You need a unit test framework such as Pester to run PowerShell Unit tests.
# You can download Pester from http://go.microsoft.com/fwlink/?LinkID=534084
#

$CommandName = 'Update-GitModule'

Describe "$CommandName basic testing" -Tag 'Functionality' {


    $moduleName = 'FIFA2018'
    $moduleURL = 'https://github.com/iricigor/' + $moduleName

    $ExistingModule = Get-Module $moduleName -List
    It 'Should delete module if existing' -Skip:($ExistingModule -ne $null) {
        {Uninstall-Module $moduleName} | Should -Not -Throw
    }

    It 'Should install module from PSGallery' {
        {Install-Module $moduleName -Repository PSGallery -Scope CurrentUser} | Should -Not -Throw
    }

    It 'Should update module to newer version' {
        Update-GitModule -ProjectUri $moduleURL -Force | Should -Not -Be $null
    }

}


Describe "$CommandName error handling" -Tag 'Functionality' {

    $moduleName = 'dbatools'
    $moduleURL = 'https://github.com/sqlcollaborative/' + $moduleName

    It "Should not update non existing module" -Skip:((Get-Module $moduleName -ListAvailable) -ne $null) {
        {Update-GitModule -ProjectUri $moduleURL -ea Stop} | Should -Throw
    }

}