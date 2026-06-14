Stop-Process -Name StartAllBackCfg -ErrorAction SilentlyContinue -Force
taskkill /f /im explorer.exe 2>$null | Out-Null

$relativePath = "StartAllBack\StartAllBackX64.dll"
$pathsToCheck = @(
    "$Env:LocalAppData\$relativePath"
    "$Env:ProgramFiles\$relativePath"
    "${Env:ProgramFiles(x86)}\$relativePath"
)

$existingPaths = @()
foreach ($path in $pathsToCheck) {
    if (Test-Path -Path $path -ErrorAction SilentlyContinue) {
        $existingPaths += $path
    }
}

if ($existingPaths.Count -eq 0) {
    Start-Process explorer
    exit 1
}

foreach ($originalPath in $existingPaths) {
    $backupPath = "$originalPath.bak"
    
    if (-not (Test-Path -Path $backupPath -ErrorAction SilentlyContinue)) {
        Copy-Item -Path $originalPath -Destination $backupPath -Force
    }
    
    $sourceFile = if (Test-Path $backupPath) { $backupPath } else { $originalPath }
    $bytes = [System.IO.File]::ReadAllBytes($sourceFile)
    
    $hexString = ($bytes | ForEach-Object { $_.ToString('X2') }) -join ' '
    
    $oldPattern = '\b48 89 5C 24 08 55 56 57 48 8D AC 24 70 FF FF FF\b'
    $newBytesPattern = '67 C7 01 01 00 00 00 B8 01 00 00 00 C3 90 90 90'
    
    if ($hexString -match $oldPattern) {
        $newHexString = $hexString -replace $oldPattern, $newBytesPattern
        $newBytes = $newHexString -split ' ' | ForEach-Object { [Convert]::ToByte($_, 16) }
        [System.IO.File]::WriteAllBytes($originalPath, $newBytes)
    }
}

Start-Process explorer
