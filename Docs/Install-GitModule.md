---
external help file: InstallModuleFromGit-help.xml
Module Name: InstallModuleFromGit
online version:
schema: 2.0.0
---

# Install-GitModule

## SYNOPSIS

This cmdlet installs PowerShell module specified by its git repository URL to user's default install directory.

## SYNTAX

```
Install-GitModule [-ProjectUri] <String[]> [[-Branch] <String>] [[-DestinationPath] <String>] [-Force]
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet installs PowerShell module specified by its git repository URL to user's default install folder.

You can also specify desired git branch.

Cmdlet internally uses `Get-GitModule` cmdlet, so it requires `git` client tool to work.
Cmdlet will actually download specified repository to user's default install directory for PowerShell modules.

It does not support functionality `-Scope AllUsers`, but it is possible to specify `-DestinationPath` argument which will provide the same result.

Cmdlet searches for module manifest (*.psd1) file only. Modules with only *.psm1 files are not supported at the moment.

Note that this will not import module, only install it (the same as built-in cmdlet `Install-Module`).
You can rely on PowerShell's automatic import of modules into user session when needed.

## EXAMPLES

### Example 1

```powershell
PS C:\> Install-GitModule 'https://github.com/iricigor/psaptgetupdate' -Verbose
```

This cmdlet will install PowerShell module from [given repository](https://github.com/iricigor/psaptgetupdate').

## PARAMETERS

### -Branch

Optional parameter that specifies which branch should be cloned.
If omitted, `master` branch will be used.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

If the module with specified name and the version exists, installation will fail.
You can override this behaviour with `-Force` switch.

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

### -ProjectUri

Mandatory parameter specifying URL or the repository. Multiple values are supported.
Parameter is passed to `git` client, so whatever works there is good value.
For example, in GitHub URLs you can specify parameter both with or without `.git` at the end of URL.

You can pass this parameter also via pipeline, for example via `Find-Module` built-in cmdlet.


```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
