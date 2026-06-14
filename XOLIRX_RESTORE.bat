@echo off
title XOLIRX RESTORE - StartAllBack Unlocker
color 0E

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo [ XOLIRX RESTORE ]
    echo.
    powershell start-process -verb runas "%~f0"
    exit /b
)

cls
echo.
echo ========================================
echo        X O L I R X   R E S T O R E
echo ========================================
echo.
echo [1] Closing processes...
taskkill /f /im explorer.exe >nul 2>&1
taskkill /f /im StartAllBackCfg.exe >nul 2>&1
echo     [OK]
echo.

echo [2] Checking files...
if not exist "%~dp0xolirx.ps1" (
    echo [ERROR] xolirx.ps1 not found!
    start explorer.exe
    pause
    exit /b 1
)
echo     [OK]
echo.

echo [3] Restoring...
echo.

setlocal enabledelayedexpansion

for /l %%x in (1,1,6) do (
    <nul set /p "=     [ >>> ] Restoring...  "
    ping -n 1 127.0.0.1 >nul
    <nul set /p "=     [ <<< ] Restoring...  "
    ping -n 1 127.0.0.1 >nul
)
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0xolirx.ps1" -Restore

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo        [SUCCESS] RESTORE SUCCESSFUL!
    echo ========================================
) else (
    echo.
    echo ========================================
    echo          [ERROR] RESTORE FAILED!
    echo ========================================
)

echo.
echo Restarting explorer...
start explorer.exe

echo.
pause