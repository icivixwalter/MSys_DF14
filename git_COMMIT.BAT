@echo off
REM si posiziona da solo nella cartella del repository (quella di questo bat)
cd /d "%~dp0"
git rev-parse --is-inside-work-tree >nul 2>&1 || (echo *** ERRORE: %CD% non e' un repository git & pause & exit /b 1)
echo REPOSITORY: %CD%
echo.
REM data nel formato AAAA_MM_GG_Hhh_Mmm_Sss (PowerShell: WMIC non esiste piu' in Windows 11)
set "today="
for /f "delims=" %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy_MM_dd_\HHH_\Mmm_\Sss"') do set "today=%%i"
if not defined today set "today=SENZA_DATA"
echo === ADD + COMMIT (tutto il repository) ===
git add -A
git diff --cached --quiet
if not errorlevel 1 (echo Nessuna modifica da salvare. & pause & exit /b 0)
git commit -m "%today%_aggiornamento_MSYS"
if errorlevel 1 (echo. & echo *** ERRORE COMMIT *** & pause & exit /b 1)
echo.
echo === COMMIT COMPLETATO (ricordati il PUSH) ===
pause
