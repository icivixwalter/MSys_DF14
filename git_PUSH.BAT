@echo off
REM si posiziona da solo nella cartella del repository (quella di questo bat)
cd /d "%~dp0"
git rev-parse --is-inside-work-tree >nul 2>&1 || (echo *** ERRORE: %CD% non e' un repository git & pause & exit /b 1)
echo REPOSITORY: %CD%
echo.
echo === PUSH: invio i commit su GitHub ===
git push
if errorlevel 1 (echo. & echo *** ERRORE PUSH: se dice "rejected" eseguire prima git_PULL.BAT *** & pause & exit /b 1)
echo.
echo === PUSH COMPLETATO ===
pause
