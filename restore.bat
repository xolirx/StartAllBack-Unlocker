@echo off
title StartAllBack Восстановление
color 0E

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [*] Запрашиваю права администратора...
    powershell start-process -verb runas "%~dp0restore_admin.bat"
    exit /b
)

powershell -ExecutionPolicy Bypass -File "%~dp0SAB.ps1" -Restore
echo.
echo [*] Нажмите любую клавишу...
pause >nul
