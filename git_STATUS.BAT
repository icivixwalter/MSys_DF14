@echo off
REM si posiziona da solo nella cartella del repository (quella di questo bat)
cd /d "%~dp0"
git rev-parse --is-inside-work-tree >nul 2>&1 || (echo *** ERRORE: %CD% non e' un repository git & pause & exit /b 1)
echo REPOSITORY: %CD%
echo.
git status
echo.
pause
