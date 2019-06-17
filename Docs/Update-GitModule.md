---
external help file: InstallModuleFromGit-help.xml
Module Name: InstallModuleFromGit
online version: https://github.com/iricigor/InstallModuleFromGit/blob/master/Docs/Update-GitModule.md
schema: 2.0.0
---

# Update-GitModule

## SYNOPSIS
This cmdlet updates previously installed PowerShell module specified by its git repository URL if repository contains newer version than installed one.

## SYNTAX

### ByUri
```
Update-GitModule [-ProjectUri] <String[]> [-Branch <String>] [-DestinationPath <String>] [-Force]
 [<CommonParameters>]
```

### ByName
```
Update-GitModule -Name <String[]> [-Branch <String>] [-DestinationPath <String>] [-Force] [<CommonParameters>]
```

## DESCRIPTION

This cmdlet updates previously installed PowerShell module specified by its git repository URL if repository contains newer version than installed one.

You can also specify desired git branch.

Cmdlet internally uses \`Get-GitModule\` cmdlet, so it requires \`git\` client tool to work.
Cmdlet will actually download specified repository to user's default install directory for PowerShell modules.

Cmdlet searches for module manifest ( .psd1) file or if that is not found for module (.psm1) file itself.

If you do not have the same module already installed, commandlet will throw an error.

Note that this will not import module, only install it (the same as built-in cmdlet \`Update-Module\`).
You can rely on PowerShell's automatic import of modules into user session when needed.

## EXAMPLES

### Example 1
```powershell
PS C:\> Update-GitModule https://github.com/microsoft/SpeculationControl
```

Updates the most downloadable PowerShell module directly from GitHub. If you do not have it installed, it will throw an error.

## PARAMETERS

### -Branch
Optional parameter that specifies which branch should be cloned.
If omitted, \`master\` branch will be used.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DestinationPath
If you have a specific setup, you can override default install location with this parameter.
As cmdlet always installs to user specific location, this can be useful to perform system wide installation (requires also elevated prompt).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
If DestinationPath location is not empty, commandlet will not install newer version there.
This behavior can be overridden with -Force switch.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
You can update already installed modules with their git online version if ProjectUri is specified in the module info.
To do this, just specify module name(s) with parameter -Name.

```yaml
Type: String[]
Parameter Sets: ByName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProjectUri
Mandatory parameter specifying URL or the repository.
Multiple values are supported.
Parameter is passed to \`git\` client, so whatever works there is good value.
For example, in GitHub URLs you can specify parameter both with or without \`.git\` at the end of URL.

You can pass this parameter also via pipeline, for example via \`Find-Module\` built-in cmdlet.

```yaml
Type: String[]
Parameter Sets: ByUri
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[https://github.com/iricigor/InstallModuleFromGit/blob/master/Docs/Update-GitModule.md](https://github.com/iricigor/InstallModuleFromGit/blob/master/Docs/Update-GitModule.md)

