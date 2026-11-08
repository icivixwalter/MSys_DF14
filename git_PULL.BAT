@echo off
REM si posiziona da solo nella cartella del repository (quella di questo bat)
cd /d "%~dp0"
git rev-parse --is-inside-work-tree >nul 2>&1 || (echo *** ERRORE: %CD% non e' un repository git & pause & exit /b 1)
echo REPOSITORY: %CD%
echo.
echo === PULL: scarico le modifiche da GitHub ===
git pull --no-edit
if errorlevel 1 (echo. & echo *** ERRORE PULL: leggere i messaggi sopra *** & pause & exit /b 1)
echo.
echo === PULL COMPLETATO ===
pause
