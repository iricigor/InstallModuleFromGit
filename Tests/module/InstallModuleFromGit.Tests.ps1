#
# This is a PowerShell Unit Test file.
# You need a unit test framework such as Pester to run PowerShell Unit tests.
# You can download Pester from http://go.microsoft.com/fwlink/?LinkID=534084
#

#
# Import module
#

$ModuleName = 'InstallModuleFromGit'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path     # Tests/Module folder
$root = (get-item $here).Parent.Parent.FullName             # module root folder
Import-Module (Join-Path $root "$ModuleName.psd1") -Force


#
# Fake test
#

Describe "Fake-Test" -Tag 'Other' {
    It "Should be fixed by developer" {
        $true | Should -Be $true
    }
}


#
# Module manifest should have proper format
#

Describe 'Proper Module Declaration' -Tag 'Documentation' {

    $ModuleManifestFile = "$root/$ModuleName.psd1"
    It 'Module manifest can be parsed' {
        {Test-ModuleManifest $ModuleManifestFile} | Should -Not -Throw
    }

    $ModuleManifest = Test-ModuleManifest $ModuleManifestFile
    $ModuleVersion = $ModuleManifest.Version
    It 'Module version must be x.y.z' {        
        ($ModuleVersion.ToString() -split '\.').Count -ge 3 | Should -Be $true -Because "Module with version $ModuleVersion cannot exist online"
    }

    It "Checks online for module version $ModuleVersion" {
        Find-Module $ModuleName -Repository PSGallery -RequiredVersion $ModuleVersion -ea 0 | Should -Be $null
    }
}


#
# Module should import three functions
#


Describe 'Proper Functions Declaration' -Tag 'Other' {

    It 'Checks for existence of functions' {
        @(Get-Command -Module $ModuleName -CommandType Function).Count | Should -Be 3 -Because 'We should have two functions defined'
        Get-Command NonExistingCommand -ea 0 | Should -Be $Null
        Get-Command Get-GitModule -ea 0 | Should -Not -Be $Null
        Get-Command Update-GitModule -ea 0 | Should -Not -Be $Null
        Get-Command Install-GitModule -ea 0 | Should -Not -Be $Null
    }
}


Describe 'Proper Documentation' -Tag 'Documentation' {

    Push-Location $root

	It 'Updates documentation and does git diff' {

        # install PlatyPS
        # Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
        if (!(Get-Module platyPS -List -ea 0)) {Install-Module platyPS -Force -Scope CurrentUser}
		Import-Module platyPS

        # update documentation
		Push-Location -Path $root
        Update-MarkdownHelp -Path .\Docs -AlphabeticParamsOrder
        New-ExternalHelp -Path .\Docs -OutputPath .\en-US -Force

        # test it
        $diff = git diff --ignore-space-change .\Docs .\en-US 
        Pop-Location
        $diff | Should -Be $null
    }
    
    $Blank = '{{ Fill .+}}'    
    foreach ($File in (Get-ChildItem .\Docs)) {
        It "Documentation for $($File.Name) should not have blanks" {
            Get-Content $File.FullName | Select-String -Pattern $Blank | Should -Be $null
        }
    }
    
    Pop-Location
}


Describe 'ScriptAnalyzer Tests' -Tag 'Documentation' {
    it 'Checks cmdlets and finds no errors' {
        # Install PSScriptAnalyzer
        if (!(Get-Module PSScriptAnalyzer -List -ea 0)) {Install-Module PSScriptAnalyzer -Force -Scope CurrentUser}
        Import-Module PSScriptAnalyzer
        # Check code
        $SA = Invoke-ScriptAnalyzer -Path $root -Recurse
        $SA | where Severity -eq 'Error' | Should -Be $null
    }
}