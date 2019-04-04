#
# This is a PowerShell Unit Test file.
# You need a unit test framework such as Pester to run PowerShell Unit tests.
# You can download Pester from http://go.microsoft.com/fwlink/?LinkID=534084
#

#
# Import module
#

$ModuleName = 'InstallModuleFromGit'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path # test folder
$root = (get-item $here).Parent.FullName                # module root folder
Import-Module (Join-Path $root "$ModuleName.psm1") -Force


#
# Fake test
#

Describe "Fake-Test" {
    It "Should be fixed by developer" {
        $true | Should -Be $true
    }
}


#
# Module should import two functions
#


Describe 'Proper Declarations' {

    It 'Checks for existence of functions' {
        @(Get-Command -Module $ModuleName -CommandType Function).Count | Should -Be 2 -Because 'We should have two functions defined'
        Get-Command NonExistingCommand -ea 0 | Should -Be $Null
        # cache management
        Get-Command Get-GitModule -ea 0 | Should -Not -Be $Null
        Get-Command Install-GitModule -ea 0 | Should -Not -Be $Null
    }

}


#
# Basic tests, this should be added to individual files
#

Describe 'Basic testing' {

    $moduleName = 'FIFA2018'
    $moduleURL = 'https://github.com/iricigor/' + $moduleName
    It 'Get-GitModule does not throw an exception' {
        {Get-GitModule $moduleURL} | Should -Not -Throw
    }

    It 'Get-GitModule returns some value' {
        Get-GitModule $moduleURL | Should -Not -Be $null
    }

    It 'Get-GitModule returns proper value' {
        (Get-GitModule $moduleURL).Name | Should -Be $moduleName
    }
    
    $moduleName = 'psaptgetupdate'
    $moduleURL = 'https://github.com/iricigor/' + $moduleName
    It 'Install-GitModule does not throw an exception' {
        {Install-GitModule $moduleURL -Force} | Should -Not -Throw
    }

    It 'Install-GitModule returns some value' {
        Install-GitModule $moduleURL -Force | Should -Not -Be $null
    }

    It 'Install-GitModule returns proper value' {
        (Install-GitModule $moduleURL -Force).Name | Should -Be $moduleName
    }

    It 'Install-GitModule really installs module' {
        Get-Module $moduleName -ListAvailable | Should -Not -Be $null
    }
}


Describe 'Proper Documentation' {

	It 'Updates documentation and does git diff' {

        # install PlatyPS
        # Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
        if (!(Get-Module platyPS -List -ea 0)) {Install-Module platyPS -Force -Scope CurrentUser}
		Import-Module platyPS

        # update documentation
		Push-Location -Path $root
        Update-MarkdownHelp -Path .\Docs
        New-ExternalHelp -Path .\Docs -OutputPath .\en-US -Force

        # test it
        $diff = git diff .\Docs .\en-US --ignore-space-change
        Pop-Location
		$diff | Should -Be $null
	}
}


Describe 'ScriptAnalyzer Tests' {
    it 'Checks cmdlets and finds no errors' {
        # Install PSScriptAnalyzer
        if (!(Get-Module PSScriptAnalyzer -List -ea 0)) {Install-Module PSScriptAnalyzer -Force -Scope CurrentUser}
        Import-Module PSScriptAnalyzer
        # Check code
        $SA = Invoke-ScriptAnalyzer -Path $root -Recurse
        $SA | where Severity -eq 'Error' | Should -Be $null
    }
}