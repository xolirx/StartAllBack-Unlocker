@echo off
title StartAllBack Восстановление
color 0E

powershell -ExecutionPolicy Bypass -File "%~dp0SAB.ps1" -Restore
echo.
echo [*] Нажмите любую клавишу...
pause >nul
