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
REM .git e .gitignore restano SOLO sul PC e negli zip: NON vanno su GitHub
REM  - regole locali in .git\info\exclude (mai su GitHub)
REM  - se .gitignore e' ancora seguito da git lo tolgo da git (il file resta)
if not exist ".git\info\" mkdir ".git\info"
for %%R in (".gitignore" "git_LOG.txt" "AA_BACKUP_GITHUB/" "AA_SALVATAGGI/") do call :regola "%%~R"
git rm --cached -q --ignore-unmatch .gitignore >nul 2>&1
echo === ADD + COMMIT (tutto il repository) ===
git add -A
git diff --cached --quiet
if not errorlevel 1 (echo Nessuna modifica da salvare. & pause & exit /b 0)
git commit -m "%today%_aggiornamento_MSYS"
if errorlevel 1 (echo. & echo *** ERRORE COMMIT *** & pause & exit /b 1)
echo.
echo === COMMIT COMPLETATO (ricordati il PUSH) ===
pause
exit /b 0

REM ------------------------------------------------------------
REM  :regola "riga"  -> aggiunge la riga a .git\info\exclude se manca
REM ------------------------------------------------------------
:regola
findstr /x /l /c:"%~1" ".git\info\exclude" >nul 2>&1
if not errorlevel 1 exit /b 0
>> ".git\info\exclude" echo.
>> ".git\info\exclude" echo(%~1
exit /b 0
