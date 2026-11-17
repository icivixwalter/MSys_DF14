
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
REM
REM  REGOLA: .git e .gitignore restano SOLO sul PC e negli zip 7-Zip,
REM          NON vanno MAI su GitHub:
REM  - le regole indispensabili sono scritte in .git\info\exclude
REM    (locale, mai su GitHub): .gitignore git_LOG.txt AA_BACKUP_GITHUB/ AA_SALVATAGGI/
REM  - prima del pull .gitignore viene copiato in %TEMP% e, se il pull lo
REM    cancella, viene rimesso; se manca del tutto (repository nuovo)
REM    viene ricreato dal modello
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
call :regole_locali
del "%TEMP%\gitignore_git_PULL.bak" >nul 2>&1
if exist ".gitignore" copy /y ".gitignore" "%TEMP%\gitignore_git_PULL.bak" >nul 2>&1
git pull --no-edit --no-rebase origin %BRANCH%
set "RC_PULL=%errorlevel%"
call :ripristina_gitignore
if not "%RC_PULL%"=="0" (
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
call :regole_locali
del "%TEMP%\gitignore_git_PULL.bak" >nul 2>&1
if exist ".gitignore" copy /y ".gitignore" "%TEMP%\gitignore_git_PULL.bak" >nul 2>&1

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
call :ripristina_gitignore
echo.
echo === ULTIMI COMMIT ===
git log --oneline -5
echo.
echo === OPERAZIONE COMPLETATA ===
pause
endlocal
exit /b 0

REM =====================================================================
REM  :regole_locali  -> regole in .git\info\exclude (mai su GitHub)
REM =====================================================================
:regole_locali
if not exist ".git\info\" mkdir ".git\info"
for %%R in (".gitignore" "git_LOG.txt" "AA_BACKUP_GITHUB/" "AA_SALVATAGGI/") do call :regola "%%~R"
exit /b 0
:regola
findstr /x /l /c:"%~1" ".git\info\exclude" >nul 2>&1
if not errorlevel 1 exit /b 0
>> ".git\info\exclude" echo.
>> ".git\info\exclude" echo(%~1
exit /b 0

REM =====================================================================
REM  :ripristina_gitignore  -> rimette .gitignore se il pull l'ha cancellato,
REM                            altrimenti lo ricrea dal modello
REM =====================================================================
:ripristina_gitignore
if exist ".gitignore" exit /b 0
if exist "%TEMP%\gitignore_git_PULL.bak" (
    copy /y "%TEMP%\gitignore_git_PULL.bak" ".gitignore" >nul
    echo .gitignore cancellato dal pull: rimesso dalla copia
    exit /b 0
)
echo .gitignore mancante: lo ricreo dal modello
> ".gitignore" echo # questo file resta SOLO sul PC e negli zip 7-Zip: NON va su GitHub
>> ".gitignore" echo .gitignore
>> ".gitignore" echo.
>> ".gitignore" echo # salvataggi 7-Zip - restano solo sul PC
>> ".gitignore" echo AA_SALVATAGGI/
>> ".gitignore" echo.
>> ".gitignore" echo # copie di sicurezza di GitHub - restano solo sul PC
>> ".gitignore" echo AA_BACKUP_GITHUB/
>> ".gitignore" echo.
>> ".gitignore" echo # log del bat git - resta solo sul PC
>> ".gitignore" echo git_LOG.txt
>> ".gitignore" echo.
>> ".gitignore" echo # file di blocco di Access/Office - esistono solo mentre il file e' aperto
>> ".gitignore" echo *.ldb
>> ".gitignore" echo *.laccdb
>> ".gitignore" echo ~$*
exit /b 0
