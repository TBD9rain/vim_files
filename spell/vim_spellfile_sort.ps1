# This is a powershell script for automatic
# vim spell dictionary sorting
#
# Use it with the git hook 'pre-commit'
# Add the following codes in the .git/hooks/pre-commit file
#
# powershell -Command "& '~\\vim_files\\spell\\vim_spellfile_sort.ps1'"
#
# if [ $? -ne 0 ]; then
#     exit 1
# else
#     exit 0
# fi

[CmdletBinding()]

param(
    [string]$filename = "spell/en.utf-8.add"
)

if (! (Test-Path $filename)) {
    Write-Error "Spell file path is not correct."
    exit 1
}
else {
    Write-Verbose "Found $filename."
}

# get file names in staged area
try {
    Write-Verbose "Getting file names in index area..."
    $staged_files = git diff --cached --name-only
}
catch{
    Write-Error "Failed to get file names in index area."
    exit 1
}

if ($staged_files -contains $filename) {
    Write-Verbose "Detected $filename in staged area."

    # sort spell dictionary
    try {
        Write-Verbose "Sorting lines in $filename..."
        Get-Content $filename | Sort-Object | Set-Content $filename
        Write-Output "Sorted lines in $filename."
    }
    catch{
        Write-Error "Failed to sort lines in $filename."
        exit 1
    }

    # make spell binary file
    Write-Verbose "Making vim spell file..."
    vim -e -s -c ":mkspell! $filename" -c "quit"
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to make vim spell file."
        exit 1
    }
    else {
        Write-Verbose "Made vim spell file."
    }

    # add spell files
    try {
        Write-Verbose "Adding sorted $filename..."
        git add $filename
        git add "$filename.spl"
        Write-Verbose "Added sorted $filename."
    }
    catch {
        Write-Error "Failed to add sorted file."
        exit 1
    }
}

exit 0

