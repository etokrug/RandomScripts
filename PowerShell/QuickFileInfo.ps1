$oPath = "$($pwd)\OutFile.txt"
if (Test-Path $oPath) {
    Remove-Item $oPath;
}

$files = Get-ChildItem -Recurse $fPath

foreach ($file in $files) {
    if (!($file -is [System.IO.DirectoryInfo])) {
        "$($file.FullName): $($file.Length / 1024 /1024) MB" >> $oPath;
    }
}