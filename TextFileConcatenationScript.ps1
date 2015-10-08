<# Simple PowerShell script I passed to my coworkers to automate file concatenation #>

#Set up timer here:
$sw = New-Object system.diagnostics.stopwatch
$sw.Start()

<# These take the $pwd from wherever this file is located.
#  You can delete it and put in a desired filepath.
#  Built it this way so you can drop it in a folder
#  and someone else can initiate the script without
#  having to play with parameters - for non-technical people.
#>

$CreatedFile = $pwd.ToString() + "" # Add desired file name here.
$path = $pwd.ToString() + ""        # Add folder which contains all files

<# If you have already run this script and
#  it has already output a file but you want to run
#  the script again this section deletes it out.
#  CAREFUL: If your file name is the same as a
#  file which currently exists it will delete it.
#>
if (Test-Path $CreatedFile) {
    Remove-Item $CreatedFile
}

$files = Get-ChildItem $path
$fileCounter = 0

<# This is really slow - could probably rewrite it to be a lot faster
#  but it gets the job done.
#>
foreach ($file in $files) {
    $lines = Get-Content $file.FullName
    foreach ($line in $lines) {
        Add-Content  -Path $CreatedFile -Value $line
    }
    Write-Host "Status Complete: $($file.FullName)"
    $fileCounter += 1
}

Write-Host "`r`n`r`n"
Write-Host "Concatenation Complete: $($fileCounter) files processed"
Write-Host "Time Elapsed: $($sw.Elapsed.Seconds) Seconds"
$sw.Stop()

Read-Host "PRESS ENTER"