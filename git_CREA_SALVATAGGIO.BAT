@echo off
REM ============================================================
REM  CREA UN PUNTO DI RIPRISTINO (SalvataggioGit) DEL PROGETTO
REM  basta il doppio clic: NON serve internet, NON tocca GitHub
REM ============================================================
REM
REM  A COSA SERVE:
REM   prima di un cambiamento importante (o quando il codice funziona
REM   bene) salvi TUTTA la storia di git del PC in un punto di ripristino.
REM   Se poi l'evoluzione del codice finisce male, con
REM   git_RICOSTRUISCI_GITHUB.BAT scegli il suo NUMERO dall'elenco e
REM   cartella del PC + GitHub tornano esattamente a questo momento.
REM
REM  DOVE LO SALVA (cartella esclusa da git, resta solo sul PC):
REM      AA_BACKUP_GITHUB\<data_ora>_SalvataggioGit_<descrizione>.git
REM   es. AA_BACKUP_GITHUB\2026_11_01_H09_M30_S12_SalvataggioGit_MANUALE.git
REM       AA_BACKUP_GITHUB\2026_11_25_H18_M02_S44_SalvataggioGit_PRIMA_NUOVA_MASCHERA.git
REM   La data davanti al nome li mette in ordine cronologico.
REM   La descrizione e' facoltativa (INVIO = MANUALE): usare solo
REM   lettere, numeri e _ (gli spazi diventano _).
REM
REM  COME FUNZIONA:
REM   0) controlli: repository git, AA_BACKUP_GITHUB esclusa da git
REM      (.gitignore), NESSUN FILE APERTO (file di blocco di Access
REM      *.laccdb / *.ldb e di Office ~$*)              -> altrimenti STOP
REM   1) se ci sono modifiche non salvate le salva in un commit locale
REM      "SALVATAGGIO <data_ora> <descrizione>" (verra' inviato su GitHub
REM      dal prossimo git_STATUS+PULL+ADD+COMMIT+PUSH.BAT)
REM   2) git clone --mirror della storia del PC nel punto di ripristino
REM   3) controlla che il salvataggio contenga l'ultimo commit
REM
REM  I FILE DELLA CARTELLA NON VENGONO MODIFICATI.
REM  PER ELIMINARE un salvataggio vecchio: cancellare a mano la sua
REM  cartella ...SalvataggioGit... dentro AA_BACKUP_GITHUB.
REM
REM  CODICI DI USCITA: 0 = salvato / annullato, 1 = bloccato o errore
REM ============================================================
setlocal
cd /d "%~dp0"
set "BACKUP_DIR=%CD%\AA_BACKUP_GITHUB"

echo ************************************************************
echo ***   CREA PUNTO DI RIPRISTINO (SalvataggioGit)
echo ***   CARTELLA : %CD%
echo ************************************************************
echo.

REM --- CONTROLLO 0 ---
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (echo *** ERRORE: %CD% non e' un repository git & pause & exit /b 1)
git rev-parse --verify HEAD >nul 2>&1
if errorlevel 1 (echo *** ERRORE: il repository non ha ancora nessun commit. & pause & exit /b 1)
if not exist "%BACKUP_DIR%\" mkdir "%BACKUP_DIR%"
git check-ignore -q "AA_BACKUP_GITHUB/"
if errorlevel 1 (echo *** ERRORE: AA_BACKUP_GITHUB non e' esclusa da git: aggiungi la riga AA_BACKUP_GITHUB/ nel file .gitignore. & pause & exit /b 1)
call :file_aperti
if defined APERTI (echo *** CHIUDI questi file e rilancia. Nessun salvataggio fatto. & pause & exit /b 1)

REM --- descrizione facoltativa ---
set "DESCR="
set /p "DESCR=Breve descrizione del salvataggio (lettere/numeri, INVIO = MANUALE): "
if not defined DESCR set "DESCR=MANUALE"
set "DESCR=%DESCR: =_%"

set "TS="
for /f %%T in ('powershell -NoProfile -Command "Get-Date -Format yyyy_MM_dd_\HHH_\Mmm_\Sss"') do set "TS=%%T"
if not defined TS (echo *** ERRORE: impossibile leggere data/ora. & pause & exit /b 1)
set "SALV=%BACKUP_DIR%\%TS%_SalvataggioGit_%DESCR%.git"
if exist "%SALV%" (echo *** ERRORE: esiste gia' %SALV% & pause & exit /b 1)

REM --- 1) modifiche non salvate -> commit locale ---
set "SPORCO="
for /f "delims=" %%L in ('git status --porcelain') do set "SPORCO=1"
if defined SPORCO (
    echo.
    echo === Modifiche non salvate: le salvo in un commit locale
    git status -s
    git add -A
    git commit -q -m "SALVATAGGIO %TS% %DESCR%"
)
if defined SPORCO if errorlevel 1 (echo *** ERRORE: commit delle modifiche FALLITO. Nessun salvataggio fatto. & pause & exit /b 1)

REM --- 2) punto di ripristino ---
echo.
echo === CREO IL PUNTO DI RIPRISTINO:
echo     %SALV%
git clone --mirror "%CD%" "%SALV%"
if errorlevel 1 (echo *** ERRORE: salvataggio FALLITO. & pause & exit /b 1)

REM --- 3) controllo ---
set "SHA_PC="
for /f %%A in ('git rev-parse HEAD') do set "SHA_PC=%%A"
git --git-dir="%SALV%" cat-file -e %SHA_PC% >nul 2>&1
if errorlevel 1 (echo *** ERRORE: il salvataggio non contiene l'ultimo commit %SHA_PC%. & pause & exit /b 1)

echo.
echo ************************************************************
echo ***  FATTO: punto di ripristino creato
echo ***     %TS%_SalvataggioGit_%DESCR%.git
echo ***  Ultimo commit salvato:
git log -1 "--format=***     %%h  %%ci  %%s"
echo ***  Per tornare a questo momento: git_RICOSTRUISCI_GITHUB.BAT
echo ************************************************************
pause
endlocal
exit /b 0

REM ------------------------------------------------------------
REM  :file_aperti  -> APERTI=1 se trova file di blocco Access/Office
REM ------------------------------------------------------------
:file_aperti
set "APERTI="
for /f "delims=" %%F in ('dir /s /b /a-d "*.laccdb" "*.ldb" "~$*" 2^>nul ^| findstr /v /i "\\AA_BACKUP_GITHUB\\ \\AA_SALVATAGGI\\"') do call :aperto "%%F"
exit /b 0
:aperto
if not defined APERTI echo *** FILE APERTI nella cartella del progetto:
set "APERTI=1"
echo        %~1
exit /b 0
