---
external help file: InstallModuleFromGit-help.xml
Module Name: InstallModuleFromGit
online version:
schema: 2.0.0
---

# Get-GitModule

## SYNOPSIS
This cmdlet will check for existence of PowerShell module in given repository and return its version.

## SYNTAX

```
Get-GitModule [-ProjectUri] <String[]> [-Branch <String>] [-KeepTempCopy] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will check for existence of PowerShell module in given repository and return its version.
You can also specify desired git branch.

Cmdlet requires \`git\` client tool to work.
It will download (\`git clone\`) specified repository to temporary directory and analyze it.
By default, it will delete this temporary copy, but if needed, it can be kept.

Cmdlet searches for module manifest ( .psd1) file only.
Modules with only .psm1 files are not supported at the moment.

## EXAMPLES

### Example 1
```
PS C:\> Get-GitModule 'https://github.com/iricigor/FIFA2018' -Verbose

Name    : FIFA2018
Version : 0.3.46
Path    :
Root    : True
Git     : https://github.com/iricigor/FIFA2018
```

This cmdlet will check for existence of PowerShell module in given repository (https://github.com/iricigor/FIFA2018') and return its version _(currently 0.3.46)_.

### Example 2
```
PS C:\> $M = Find-Module FIFA2018; $M.Version; ($M | Get-GitModule).Version

0.2.45
0.3.46
```

This illustrates how you can check latest versions of the module both in PSGallery and in its repository.
Notice that cmdlet \`Get-GitModule\` accepts value for \`-ProjectURI\` via pipeline.

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

### -KeepTempCopy
Cmdlet will download (\`git clone\`) specified repository to temporary directory and analyze it.
By default, it will delete this temporary copy.
If needed use this switch parameter to keep this temporary copy.
You can check \`Path\` attribute of return value to see exact path where temporary copy is located.

This is used for example in \`Install-GitModule\` to directly install module from this temporary copy.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
