@echo off
REM ============================================================
REM  RIPRISTINA UN PUNTO DI RIPRISTINO (SalvataggioGit)
REM  SU GITHUB *E* SUL PC  -  basta il doppio clic, nessun comando DOS
REM ============================================================
REM
REM  IL CONCETTO:
REM   - nella cartella AA_BACKUP_GITHUB ci sono i PUNTI DI RIPRISTINO
REM     (salvataggi completi di git), ognuno con la DATA davanti al nome:
REM        2026_11_01_H09_M30_S12_SalvataggioGit_MANUALE.git
REM        2026_11_25_H18_M02_S44_SalvataggioGit_PRIMA_SVUOTAMENTO.git
REM   - se l'evoluzione del codice finisce male, questo bat mostra
REM     l'ELENCO NUMERATO dei salvataggi (dal piu' recente), tu scrivi il
REM     NUMERO e la cartella del PC e GitHub tornano esattamente a quel
REM     salvataggio. Poi si continua a lavorare normalmente con
REM     git_STATUS+PULL+ADD+COMMIT+PUSH.BAT.
REM
REM  CHI CREA I PUNTI DI RIPRISTINO (la parte finale del nome dice chi):
REM   _SalvataggioGit_MANUALE (o la descrizione scritta)
REM         git_CREA_SALVATAGGIO.BAT, quando vuoi tu (es. prima di un
REM         cambiamento importante)
REM   _SalvataggioGit_PRIMA_SVUOTAMENTO
REM         git_CANCELLA_TUTTI_I_DATI_IN_GITHUB.BAT (la storia di GitHub
REM         prima dello svuotamento = la "vecchia storia")
REM   _SalvataggioGit_PRIMA_RIPARTENZA
REM         git_STATUS+PULL+ADD+COMMIT+PUSH.BAT quando riparte da zero
REM         (la storia del PC, anche i commit mai inviati)
REM   _SalvataggioGit_PRIMA_RIPRISTINO (e _PRIMA_RIPRISTINO_GITHUB)
REM         questo bat, subito PRIMA di ripristinare: serve per ANNULLARE
REM         un ripristino sbagliato (basta scegliere quel numero)
REM
REM  REGOLA: TUTTI I FILE DEL PROGETTO DEVONO ESSERE CHIUSI
REM   - il bat cerca i file di blocco di Access (*.laccdb, *.ldb) e di
REM     Office (~$*): se ne trova si FERMA e li elenca.
REM   - chiudere comunque anche gli altri programmi che usano i file
REM     del progetto (es. editor), altrimenti il ripristino puo' fallire.
REM
REM  COSA FA:
REM   - GitHub: rimette ESATTAMENTE lo stato del salvataggio (main, altri
REM     branch, tag, storia). Branch/tag non presenti nel salvataggio
REM     vengono cancellati (--prune).
REM   - PC: il main del PC e i FILE della cartella tornano a quelli del
REM     salvataggio (git reset --hard).
REM
REM  COSA NON VIENE TOCCATO SUL PC:
REM   - le cartelle escluse da git: AA_BACKUP_GITHUB, AA_SALVATAGGI;
REM   - i bat git_*.BAT: restano nella versione ATTUALE (sono strumenti,
REM     non fanno parte della "storia"; senza questa regola tornando a un
REM     salvataggio vecchio potrebbero sparire). Se differiscono dal
REM     salvataggio risultano "modificati" e il prossimo
REM     git_STATUS+PULL+ADD+COMMIT+PUSH.BAT li salva.
REM   - .gitignore: dopo il ripristino controlla che contenga
REM     AA_BACKUP_GITHUB/, AA_SALVATAGGI/ e git_LOG.txt e se mancano
REM     le aggiunge (un salvataggio vecchio potrebbe non averle).
REM
REM  PROTEZIONI, IN QUESTO ORDINE:
REM   0) cartella = repository git; AA_BACKUP_GITHUB esistente ed esclusa
REM      da git; GitHub raggiungibile; NESSUN FILE APERTO  -> altrimenti STOP
REM   1) elenco numerato dei salvataggi, scelta per NUMERO (INVIO = annulla);
REM      il salvataggio deve essere valido e contenere main -> altrimenti STOP
REM   2) mostra il contenuto (ultimi commit, numero di file). Se l'ultimo
REM      commit di main e' "SVUOTATO..." il salvataggio e' VUOTO     -> STOP
REM   3) CONFERMA FORTE: riscrivere a mano il nome esatto della repository
REM   4) le modifiche non salvate vengono salvate in un commit locale,
REM      poi PUNTO DI RIPRISTINO dello stato attuale:
REM         <data_ora>_SalvataggioGit_PRIMA_RIPRISTINO.git  (storia del PC)
REM         <data_ora>_SalvataggioGit_PRIMA_RIPRISTINO_GITHUB.git (solo se
REM         GitHub ha commit che il PC non ha)          se fallisce -> STOP
REM   5) push forzato su GitHub di tutti i branch e tag del salvataggio
REM   6) controllo: main su GitHub deve essere uguale al salvataggio
REM   7) nuovo controllo file aperti, poi PC: git reset --hard, rimette i
REM      bat git_*.BAT attuali e controlla il .gitignore
REM
REM  NOTA TECNICA: il bat si esegue da una sua COPIA in %TEMP%, perche'
REM  il punto 7 cambia i file della cartella (anche questo bat) e cmd
REM  non puo' continuare a leggere un bat che viene sostituito.
REM
REM  NOTE:
REM   - se su GitHub main e' "protetto" (branch protection) il push con
REM     force viene rifiutato: togliere la protezione da Settings > Branches.
REM   - se il punto 7 fallisce (file aperti) GitHub e' gia' ripristinato:
REM     chiudere i file e RILANCIARE questo bat scegliendo lo stesso numero.
REM
REM  CODICI DI USCITA: 0 = ripristinato / annullato dall'utente, 1 = bloccato o errore
REM  PER UN ALTRO PROGETTO: cambiare solo NOME_REPO e URL_REPO qui sotto.
REM ============================================================
setlocal

REM --- esecuzione da una copia in %TEMP% (vedi NOTA TECNICA) ---
if /i not "%~1"=="__COPIA_TEMP__" (
    copy /y "%~f0" "%TEMP%\git_RICOSTRUISCI_GITHUB_esecuzione.bat" >nul
    call "%TEMP%\git_RICOSTRUISCI_GITHUB_esecuzione.bat" __COPIA_TEMP__ "%~dp0"
    exit /b
)
set "PROGETTO=%~2"

set "NOME_REPO=MSys_DF14"
set "URL_REPO=https://github.com/icivixwalter/MSys_DF14.git"
set "BRANCH=main"

cd /d "%PROGETTO%"
set "BACKUP_DIR=%CD%\AA_BACKUP_GITHUB"

echo ************************************************************
echo ***   RIPRISTINO DI UN PUNTO DI RIPRISTINO (SalvataggioGit)
echo ***   REPOSITORY : %NOME_REPO%
echo ***   GITHUB     : %URL_REPO%
echo ***   CARTELLA   : %CD%
echo ************************************************************
echo.

REM --- CONTROLLO 0 ---
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (echo *** ERRORE: %CD% non e' un repository git & pause & exit /b 1)
if not exist "%BACKUP_DIR%\" (echo *** ERRORE: la cartella dei salvataggi non esiste: %BACKUP_DIR% & pause & exit /b 1)
git check-ignore -q "AA_BACKUP_GITHUB/"
if errorlevel 1 (echo *** ERRORE: AA_BACKUP_GITHUB non e' esclusa da git: aggiungi la riga AA_BACKUP_GITHUB/ nel file .gitignore. Nessuna modifica fatta. & pause & exit /b 1)
call :file_aperti
if defined APERTI (echo *** CHIUDI questi file e rilancia. Nessuna modifica fatta. & pause & exit /b 1)
git ls-remote "%URL_REPO%" >nul 2>&1
if errorlevel 1 (
    echo *** ERRORE: la repository GitHub non esiste o non e' raggiungibile.
    echo ***         Controlla internet / credenziali. Nessuna modifica fatta.
    pause & exit /b 1
)

REM --- PROTEZIONE 1: elenco numerato e scelta ---
echo PUNTI DI RIPRISTINO DISPONIBILI (dal piu' recente):
echo.
set "N_SALV=0"
for /f "tokens=1* delims=:" %%A in ('dir /b /ad /o-n "%BACKUP_DIR%\*_SalvataggioGit_*.git" 2^>nul ^| findstr /n "^"') do call :mostra %%A "%%B"
echo.
if "%N_SALV%"=="0" (echo *** Nessun punto di ripristino in %BACKUP_DIR% & pause & exit /b 1)
set "NUM="
set /p "NUM=Scrivi il NUMERO del salvataggio da ripristinare (1-%N_SALV%, INVIO = annulla): "
if not defined NUM (echo Operazione ANNULLATA. Nessuna modifica fatta. & pause & exit /b 0)
set "SCELTA="
for /f "tokens=1* delims=:" %%A in ('dir /b /ad /o-n "%BACKUP_DIR%\*_SalvataggioGit_*.git" 2^>nul ^| findstr /n "^"') do if "%%A"=="%NUM%" set "SCELTA=%%B"
if not defined SCELTA (echo *** Numero non valido: %NUM%. Nessuna modifica fatta. & pause & exit /b 1)
set "BACKUP_REPO=%BACKUP_DIR%\%SCELTA%"
set "SHA_BACKUP="
for /f %%A in ('git --git-dir^="%BACKUP_REPO%" rev-parse --verify refs/heads/%BRANCH% 2^>nul') do set "SHA_BACKUP=%%A"
if not defined SHA_BACKUP (echo *** ERRORE: il salvataggio non e' valido o non contiene il branch %BRANCH%. & pause & exit /b 1)

REM --- PROTEZIONE 2: contenuto del salvataggio ---
echo.
echo === SALVATAGGIO SCELTO: %SCELTA%
echo Ultimi commit di %BRANCH%:
git --git-dir="%BACKUP_REPO%" log -5 "--format=   %%h  %%ci  %%s" refs/heads/%BRANCH%
set "NUM_FILE=0"
for /f %%N in ('git --git-dir^="%BACKUP_REPO%" ls-tree -r --name-only refs/heads/%BRANCH% ^| find /c /v ""') do set "NUM_FILE=%%N"
echo Numero di file: %NUM_FILE%
git --git-dir="%BACKUP_REPO%" log -1 --format=%%s refs/heads/%BRANCH% | findstr /b /c:"SVUOTATO" >nul
if not errorlevel 1 (
    echo.
    echo *** ATTENZIONE: questo salvataggio contiene main GIA' SVUOTATO: non serve.
    echo ***             Rilancia e scegli un altro numero.
    pause & exit /b 1
)

REM modifiche non salvate nella cartella?
set "SPORCO="
for /f "delims=" %%L in ('git status --porcelain') do set "SPORCO=1"
if defined SPORCO (
    echo.
    echo === MODIFICHE NON SALVATE nella cartella: verranno salvate in un
    echo     commit locale e nel punto di ripristino PRIMA del ripristino:
    git status -s
)
echo.

REM --- PROTEZIONE 3: conferma forte ---
echo ************************************************************
echo ***  ATTENZIONE: verranno riportati al salvataggio
echo ***     %SCELTA%
echo ***  - GitHub (branch/tag non presenti nel salvataggio cancellati)
echo ***  - i FILE della cartella del PC (tranne AA_BACKUP_GITHUB,
echo ***    AA_SALVATAGGI e i bat git_*.BAT)
echo ***  Lo stato attuale viene prima salvato: si puo' annullare.
echo ************************************************************
set "RISPOSTA="
set /p "RISPOSTA=Per confermare scrivi il nome esatto della repository (%NOME_REPO%): "
if not "%RISPOSTA%"=="%NOME_REPO%" (echo Nome diverso: operazione ANNULLATA. Nessuna modifica fatta. & pause & exit /b 0)

REM --- PROTEZIONE 4: punto di ripristino dello stato attuale ---
set "TS="
for /f %%T in ('powershell -NoProfile -Command "Get-Date -Format yyyy_MM_dd_\HHH_\Mmm_\Sss"') do set "TS=%%T"
if not defined TS (echo *** ERRORE: impossibile leggere data/ora. Nessuna modifica fatta. & pause & exit /b 1)
set "BACKUP_PC=%BACKUP_DIR%\%TS%_SalvataggioGit_PRIMA_RIPRISTINO.git"
set "BACKUP_GH=%BACKUP_DIR%\%TS%_SalvataggioGit_PRIMA_RIPRISTINO_GITHUB.git"
if defined SPORCO git add -A
if defined SPORCO git commit -q -m "SALVATAGGIO PRIMA DEL RIPRISTINO %TS%"
echo.
echo === PUNTO DI RIPRISTINO dello stato attuale del PC:
echo     %BACKUP_PC%
git clone --mirror "%CD%" "%BACKUP_PC%"
if errorlevel 1 (echo *** ERRORE: salvataggio FALLITO. GitHub e PC NON sono stati toccati. & pause & exit /b 1)
REM GitHub ha commit che il PC non ha (es. dall'altro PC)? allora salvo anche GitHub
git fetch origin >nul 2>&1
set "SALVA_GH=1"
git log -1 --format=%%s origin/%BRANCH% 2>nul | findstr /b /c:"SVUOTATO" >nul
if not errorlevel 1 set "SALVA_GH="
git merge-base --is-ancestor origin/%BRANCH% HEAD >nul 2>&1
if not errorlevel 1 set "SALVA_GH="
if defined SALVA_GH echo === GitHub ha commit che il PC non ha: salvo anche GitHub in:
if defined SALVA_GH echo     %BACKUP_GH%
if defined SALVA_GH git clone --mirror "%URL_REPO%" "%BACKUP_GH%"
if defined SALVA_GH if errorlevel 1 (echo *** ERRORE: salvataggio di GitHub FALLITO. GitHub e PC NON sono stati toccati. & pause & exit /b 1)
echo === SALVATAGGIO OK

REM --- 5: ripristino su GitHub di tutti i branch e tag del salvataggio ---
REM  (non uso push --mirror: un salvataggio di GitHub contiene anche
REM   refs/pull/* che GitHub rifiuta; per questo invio solo branch e tag)
echo.
echo === RIPRISTINO DI GITHUB IN CORSO ===
git --git-dir="%BACKUP_REPO%" push --force --prune "%URL_REPO%" "refs/heads/*:refs/heads/*" "refs/tags/*:refs/tags/*"
if errorlevel 1 (
    echo *** ERRORE PUSH: ripristino NON completato. Il PC NON e' stato toccato.
    echo ***   cause possibili: branch protetto su GitHub, credenziali o rete.
    pause & exit /b 1
)

REM --- PROTEZIONE 6: controllo GitHub ---
set "SHA_FINALE="
for /f %%A in ('git ls-remote --heads "%URL_REPO%" %BRANCH% 2^>nul') do set "SHA_FINALE=%%A"
if not "%SHA_FINALE%"=="%SHA_BACKUP%" (echo *** ATTENZIONE: su GitHub %BRANCH% non risulta uguale al salvataggio. Il PC NON e' stato toccato. & pause & exit /b 1)
echo === GITHUB RIPRISTINATO

REM --- 7: riporto il PC al salvataggio, conservando i bat git_*.BAT attuali ---
echo.
echo === RIPRISTINO DELLA CARTELLA DEL PC ===
call :file_aperti
if defined APERTI (
    echo *** GitHub e' gia' ripristinato, ma la cartella del PC NO.
    echo *** CHIUDI questi file e RILANCIA scegliendo lo stesso salvataggio.
    pause & exit /b 1
)
set "STRUMENTI=%TEMP%\git_strumenti_%NOME_REPO%_%TS%"
mkdir "%STRUMENTI%" >nul 2>&1
copy /y "git_*.BAT" "%STRUMENTI%\" >nul
git fetch --prune origin >nul 2>&1
git reset --hard %SHA_BACKUP%
if errorlevel 1 (
    copy /y "%STRUMENTI%\*.BAT" . >nul
    echo *** ERRORE: la cartella del PC NON e' stata riportata al salvataggio
    echo ***   ^(file aperti?^). GitHub e' gia' ripristinato: chiudi i file e
    echo ***   RILANCIA questo bat scegliendo lo stesso salvataggio.
    pause & exit /b 1
)
copy /y "%STRUMENTI%\*.BAT" . >nul
rd /s /q "%STRUMENTI%" >nul 2>&1
call :ignora "AA_SALVATAGGI/"
call :ignora "AA_BACKUP_GITHUB/"
call :ignora "git_LOG.txt"

echo.
echo ************************************************************
echo ***  FATTO: GitHub e PC riportati al salvataggio
echo ***     %SCELTA%
echo ***  Per ANNULLARE: rilancia e scegli
echo ***     %TS%_SalvataggioGit_PRIMA_RIPRISTINO.git
echo ***  Situazione del PC (bat git_*.BAT / .gitignore eventualmente
echo ***  modificati verranno salvati dal prossimo git_STATUS+...+PUSH):
git status -sb
echo ************************************************************
pause
endlocal
exit /b 0

REM ------------------------------------------------------------
REM  :mostra N "cartella"  -> riga dell'elenco numerato
REM ------------------------------------------------------------
:mostra
set "N_SALV=%~1"
set "ULT="
for /f "delims=" %%L in ('git --git-dir^="%BACKUP_DIR%\%~2" log -1 "--format=%%ci  %%s" refs/heads/%BRANCH% 2^>nul') do set "ULT=%%L"
echo   %~1^)  %~2
echo         ultimo commit: %ULT%
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

REM ------------------------------------------------------------
REM  :ignora "riga"  -> aggiunge la riga al .gitignore se manca
REM ------------------------------------------------------------
:ignora
findstr /x /c:"%~1" .gitignore >nul 2>&1
if not errorlevel 1 exit /b 0
echo    .gitignore: aggiungo la riga mancante %~1
>> .gitignore echo(
>> .gitignore echo(%~1
exit /b 0
