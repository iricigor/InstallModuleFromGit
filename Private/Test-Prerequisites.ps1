function Test-Prerequisites {
    # check if git command is available, can be extended as needed
    if (Get-Command 'git') {$true} else {$false}
}