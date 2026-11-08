
@echo off
setlocal
REM =====================================================================
REM DIRECTORY DEL PROGETTO:
REM c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS\MSys_DF14\
REM  git_PULL.BAT - scarica le modifiche da GitHub (origin/main)
REM  repository: https://github.com/icivixwalter/MSys_DF14
REM
REM  - se nella cartella del bat esiste gia' il repository: esegue il pull
REM  - se NON esiste la .git: crea il repository e scarica tutto da GitHub
REM    (basta copiare questo bat in una cartella vuota e lanciarlo)
REM =====================================================================
set "REPO_URL=https://github.com/icivixwalter/MSys_DF14.git"
set "BRANCH=main"

REM ---------------------------------------------------------------------
REM  Il bat e' anch'esso nel repository: il pull/checkout potrebbe
REM  sovrascriverlo mentre gira. Per sicurezza si copia in %TEMP% e
REM  continua da li', passando la cartella di origine come parametro.
REM ---------------------------------------------------------------------
if /i not "%~1"=="__RUN__" (
    copy /y "%~f0" "%TEMP%\git_PULL_run.bat" >nul
    "%TEMP%\git_PULL_run.bat" __RUN__ "%~dp0." "%~nx0"
)
set "BAT_NAME=%~3"
cd /d "%~2"

where git >nul 2>&1 || (echo *** ERRORE: git non installato o non nel PATH ^(https://git-scm.com^) & pause & exit /b 1)

REM evita l'errore "dubious ownership" se la cartella appartiene a un altro utente
git config --global --get-all safe.directory | findstr /i /x /c:"%CD:\=/%" >nul 2>&1 || git config --global --add safe.directory "%CD:\=/%"

echo REPOSITORY: %CD%
echo REMOTE    : %REPO_URL%  [branch %BRANCH%]
echo.

if not exist ".git\" goto :NUOVO_REPO

REM =====================================================================
REM  REPOSITORY GIA' ESISTENTE: PULL
REM =====================================================================
git rev-parse --is-inside-work-tree >nul 2>&1 || (echo *** ERRORE: la cartella .git esiste ma non e' valida & pause & exit /b 1)

REM controlla/sistema il remote origin
git remote get-url origin >nul 2>&1 || git remote add origin "%REPO_URL%"
for /f "delims=" %%U in ('git remote get-url origin') do set "CUR_URL=%%U"
if /i not "%CUR_URL%"=="%REPO_URL%" (
    echo Remote origin era: %CUR_URL%
    echo Lo imposto a:      %REPO_URL%
    git remote set-url origin "%REPO_URL%"
)

echo === FETCH: controllo le novita' su GitHub ===
git fetch origin
if errorlevel 1 (echo. & echo *** ERRORE FETCH: controllare connessione / credenziali GitHub *** & pause & exit /b 1)

REM collega il branch locale a origin/main (se non lo e' gia')
git branch --set-upstream-to=origin/%BRANCH% %BRANCH% >nul 2>&1

echo.
echo === STATO PRIMA DEL PULL ===
git status -sb
echo.

echo === PULL: scarico le modifiche da GitHub ===
git pull --no-edit --no-rebase origin %BRANCH%
if errorlevel 1 (
    echo.
    echo *** ERRORE PULL: leggere i messaggi sopra ***
    echo Se ci sono modifiche locali non salvate eseguire prima git_COMMIT.BAT
    echo oppure accantonarle con:  git stash   ^(poi git stash pop^)
    pause
    exit /b 1
)
goto :FINE

REM =====================================================================
REM  .git NON ESISTE: CREA IL REPOSITORY E SCARICA DA GITHUB
REM =====================================================================
:NUOVO_REPO
echo *** In questa cartella non esiste il repository git ***
echo Verra' creato e collegato a GitHub, poi verranno scaricati tutti i file.
echo.
choice /c SN /m "Procedere"
if errorlevel 2 (echo Operazione annullata. & pause & exit /b 0)

echo.
echo === INIT: creo il repository ===
git init
if errorlevel 1 (echo *** ERRORE INIT *** & pause & exit /b 1)
git remote add origin "%REPO_URL%"

echo.
echo === FETCH: scarico da GitHub ===
git fetch origin
if errorlevel 1 (
    echo.
    echo *** ERRORE FETCH: controllare connessione / credenziali GitHub ***
    echo Il repository vuoto e' stato rimosso: correggere e rilanciare il bat.
    rmdir /s /q ".git"
    pause
    exit /b 1
)

echo.
echo === CHECKOUT: estraggo i file del branch %BRANCH% ===
REM questo bat e' anche nel repository: lo sposto da parte per non bloccare il checkout
if exist "%BAT_NAME%" move /y "%BAT_NAME%" "%TEMP%\git_PULL_orig.bat" >nul
git checkout -B %BRANCH% --track origin/%BRANCH%
if not errorlevel 1 goto :FINE

echo.
REM checkout fallito: rimetto al suo posto il bat se non e' stato ricreato
if not exist "%BAT_NAME%" if exist "%TEMP%\git_PULL_orig.bat" move /y "%TEMP%\git_PULL_orig.bat" "%BAT_NAME%" >nul
if exist "%BAT_NAME%" move /y "%BAT_NAME%" "%TEMP%\git_PULL_orig.bat" >nul
echo.
echo *** Nella cartella ci sono file che verrebbero sovrascritti (elencati sopra) ***
choice /c SN /m "Sovrascriverli con la versione di GitHub"
if errorlevel 2 (
    echo Operazione annullata: rimuovo il repository creato.
    rmdir /s /q ".git"
    if not exist "%BAT_NAME%" move /y "%TEMP%\git_PULL_orig.bat" "%BAT_NAME%" >nul
    pause
    exit /b 1
)
git checkout -f -B %BRANCH% --track origin/%BRANCH%
if errorlevel 1 (echo *** ERRORE CHECKOUT: leggere i messaggi sopra *** & pause & exit /b 1)

:FINE
echo.
echo === ULTIMI COMMIT ===
git log --oneline -5
echo.
echo === OPERAZIONE COMPLETATA ===
pause
endlocal
exit /b 0
