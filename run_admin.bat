@echo off
title StartAllBack Активатор
color 0A

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [*] Запрашиваю права администратора...
    powershell start-process -verb runas "%~dp0run.bat"
    exit /b
)

powershell -ExecutionPolicy Bypass -File "%~dp0SAB.ps1"
echo.
echo [*] Нажмите любую клавишу для выхода...
pause >nul
