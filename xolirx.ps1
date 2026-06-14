param(
    [switch]$Restore
)

$ErrorActionPreference = "Stop"

function Write-Color {
    param($Message, $Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

if ($Restore) {
    Write-Color "[*] Восстановление..." "Cyan"
    $paths = @(
        "$Env:LocalAppData\StartAllBack\StartAllBackX64.dll"
        "$Env:ProgramFiles\StartAllBack\StartAllBackX64.dll"
        "${Env:ProgramFiles(x86)}\StartAllBack\StartAllBackX64.dll"
    )
    foreach ($path in $paths) {
        if (Test-Path "$path.bak") {
            Copy-Item "$path.bak" $path -Force
            Write-Color "[✓] Восстановлено: $path" "Green"
        }
    }
    taskkill /f /im explorer.exe 2>$null
    Start-Process explorer
    Write-Color "[✓] Готово! Explorer перезапущен." "Green"
    exit 0
}

Write-Color "[*] StartAllBack Активатор" "Cyan"
Write-Color "[*] Завершаю процессы..." "Yellow"

Stop-Process -Name StartAllBackCfg -ErrorAction SilentlyContinue -Force
taskkill /f /im explorer.exe 2>$null | Out-Null

$paths = @(
    "$Env:LocalAppData\StartAllBack\StartAllBackX64.dll"
    "$Env:ProgramFiles\StartAllBack\StartAllBackX64.dll"
    "${Env:ProgramFiles(x86)}\StartAllBack\StartAllBackX64.dll"
)

$found = @()
foreach ($path in $paths) {
    if (Test-Path $path) {
        $found += $path
        Write-Color "[+] Найдено: $path" "Green"
    }
}

if ($found.Count -eq 0) {
    Write-Color "[-] StartAllBack не найден! Установите программу." "Red"
    Start-Process explorer
    exit 1
}

$activated = 0
foreach ($path in $found) {
    Write-Color "[*] Активирую: $path" "Cyan"
    
    if (-not (Test-Path "$path.bak")) {
        Copy-Item $path "$path.bak" -Force
        Write-Color "[+] Бэкап создан" "Green"
    }
    
    $bytes = [System.IO.File]::ReadAllBytes("$path.bak")
    $hex = ($bytes | ForEach-Object { $_.ToString('X2') }) -join ' '
    
    $old = '\b48 89 5C 24 08 55 56 57 48 8D AC 24 70 FF FF FF\b'
    $new = '67 C7 01 01 00 00 00 B8 01 00 00 00 C3 90 90 90'
    
    if ($hex -match $old) {
        $newHex = $hex -replace $old, $new
        $newBytes = $newHex -split ' ' | ForEach-Object { [Convert]::ToByte($_, 16) }
        [System.IO.File]::WriteAllBytes($path, $newBytes)
        Write-Color "[✓] Активация успешна!" "Green"
        $activated++
    } else {
        Write-Color "[-] Уже активирован или версия не подходит" "Yellow"
    }
}

Start-Process explorer
Write-Color "[✓] Готово! Активировано: $activated файлов" "Green"

if ($activated -eq 0) { exit 1 }
exit 0
