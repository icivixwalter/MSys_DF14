@echo off
REM ============================================================
REM  SVUOTA SU GITHUB IL BRANCH PRINCIPALE main  (OPERAZIONE PERICOLOSA)
REM ============================================================
REM
REM  COSA FA:
REM   - su GitHub il branch main RESTA, ma viene SVUOTATO: al posto di
REM     tutta la storia rimane UN SOLO commit vuoto, senza file
REM     ("SVUOTATO ...").  Su GitHub un branch non puo' esistere senza
REM     almeno un commit, per questo resta quel commit vuoto.
REM   - facoltativo: cancella su GitHub anche gli ALTRI branch e i TAG,
REM     cosi' resta solo main (vuoto).
REM
REM  COSA NON FA:
REM   - NON tocca nulla sul PC: file, commit locali e branch main locale
REM     restano come sono (il commit vuoto viene creato "a parte" con
REM     git commit-tree, senza cambiare la cartella di lavoro).
REM   - NON cancella la repository su GitHub (resta, con main vuoto).
REM
REM  PROTEZIONI, IN QUESTO ORDINE:
REM   0) controlla che la cartella sia un repository git e che GitHub
REM      sia raggiungibile                                  -> altrimenti STOP
REM   1) controlla che su GitHub esista main (se non esiste non c'e'
REM      niente da svuotare)                                -> altrimenti STOP
REM   2) COPIA DI SICUREZZA AUTOMATICA: git clone --mirror di TUTTA la
REM      repository GitHub (tutti i branch, tag e commit) nella cartella
REM         AA_BACKUP_GITHUB\<data_ora>_SalvataggioGit_PRIMA_SVUOTAMENTO.git
REM      es. AA_BACKUP_GITHUB\2026_11_07_H17_M45_S03_SalvataggioGit_PRIMA_SVUOTAMENTO.git
REM      E' un PUNTO DI RIPRISTINO: si rimette con git_RICOSTRUISCI_GITHUB.BAT
REM      (DENTRO la cartella del progetto: le copie valgono solo per questo progetto.
REM       La cartella e' esclusa da git con la riga AA_BACKUP_GITHUB/ nel .gitignore:
REM       se manca quella riga il bat si FERMA, cosi' le copie non finiscono nei commit).
REM      Se la copia fallisce                               -> STOP, nessuna modifica
REM   3) CONFERMA FORTE: bisogna riscrivere a mano il nome esatto della
REM      repository (maiuscole/minuscole comprese)         -> altrimenti annulla
REM   4) push con --force-with-lease: sovrascrive main SOLO se su GitHub
REM      c'e' ancora esattamente il commit salvato nella copia di
REM      sicurezza. Se nel frattempo qualcuno ha aggiunto commit -> STOP
REM   5) controllo finale: verifica che su GitHub main sia davvero il
REM      commit vuoto appena creato.
REM
REM  ATTENZIONE - DA SAPERE:
REM   - i vecchi commit NON spariscono subito dai server GitHub: chi ne
REM     conosce il codice puo' ancora aprirli per un po'. Se nella
REM     repository c'erano PASSWORD o DATI SENSIBILI questo bat NON basta:
REM     bisogna cancellare la repository intera (Settings > Delete).
REM   - se su GitHub main e' "protetto" (branch protection) il push con
REM     force viene rifiutato: va tolta la protezione da Settings > Branches.
REM
REM  DOPO LO SVUOTAMENTO:
REM   - git_CREATE_GITHUB.BAT continua a BLOCCARSI (main esiste, anche se vuoto).
REM   - PER RIPARTIRE DA ZERO: usare git_STATUS+PULL+ADD+COMMIT+PUSH.BAT.
REM     Riconosce il commit "SVUOTATO ...", salva la storia del PC in un
REM     punto di ripristino e crea un PRIMO COMMIT nuovo, senza passato,
REM     con i file attuali della cartella (con --force-with-lease, sicuro).
REM   - git_PUSH.BAT e git_PULL.BAT da soli NON vanno usati finche' main
REM     e' svuotato: il push viene rifiutato e il pull prova a unire due
REM     storie diverse ("refusing to merge unrelated histories").
REM   - per TORNARE alla vecchia storia (piano di riserva):
REM     git_RICOSTRUISCI_GITHUB.BAT e scegliere dall'elenco il numero del
REM     salvataggio ..._SalvataggioGit_PRIMA_SVUOTAMENTO.git
REM
REM  CODICI DI USCITA: 0 = svuotato / annullato dall'utente, 1 = bloccato o errore
REM  PER UN ALTRO PROGETTO: cambiare solo NOME_REPO e URL_REPO qui sotto.
REM ============================================================
setlocal
set "NOME_REPO=MSys_DF14"
set "URL_REPO=https://github.com/icivixwalter/MSys_DF14.git"
set "BRANCH=main"

REM si posiziona da solo nella cartella del repository (quella di questo bat)
cd /d "%~dp0"
set "BACKUP_DIR=%~dp0AA_BACKUP_GITHUB"

echo ************************************************************
echo ***   SVUOTAMENTO DEL BRANCH %BRANCH% SU GITHUB
echo ***   REPOSITORY : %NOME_REPO%
echo ***   GITHUB     : %URL_REPO%
echo ***   CARTELLA   : %CD%
echo ************************************************************
echo.

REM --- CONTROLLO 0: repository git locale e GitHub raggiungibile ---
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (echo *** ERRORE: %CD% non e' un repository git & pause & exit /b 1)
git ls-remote "%URL_REPO%" >nul 2>&1
if errorlevel 1 (
    echo *** ERRORE: la repository GitHub non esiste o non e' raggiungibile.
    echo ***         Controlla internet / credenziali. Nessuna modifica fatta.
    pause & exit /b 1
)

REM --- CONTROLLO 1: main esiste su GitHub? (e ne leggo il commit attuale) ---
set "SHA_REMOTO="
for /f %%A in ('git ls-remote --heads "%URL_REPO%" %BRANCH% 2^>nul') do set "SHA_REMOTO=%%A"
if not defined SHA_REMOTO (
    echo *** Su GitHub il branch %BRANCH% NON esiste: non c'e' niente da svuotare.
    pause & exit /b 1
)
echo Commit attuale di %BRANCH% su GitHub: %SHA_REMOTO%
echo.
echo Branch e tag presenti su GitHub:
for /f "tokens=2" %%R in ('git ls-remote --refs --heads --tags "%URL_REPO%"') do echo    %%R
echo.

REM --- PROTEZIONE 2: copia di sicurezza completa (git clone --mirror) ---
set "TS="
for /f %%T in ('powershell -NoProfile -Command "Get-Date -Format yyyy_MM_dd_\HHH_\Mmm_\Sss"') do set "TS=%%T"
if not defined TS (echo *** ERRORE: impossibile leggere data/ora. Nessuna modifica fatta. & pause & exit /b 1)
set "BACKUP_REPO=%BACKUP_DIR%\%TS%_SalvataggioGit_PRIMA_SVUOTAMENTO.git"
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
REM la cartella delle copie DEVE essere esclusa da git (.gitignore), altrimenti le copie finirebbero nei commit e su GitHub
git check-ignore -q "AA_BACKUP_GITHUB/"
if errorlevel 1 (echo *** ERRORE: AA_BACKUP_GITHUB non e' esclusa da git: aggiungi la riga AA_BACKUP_GITHUB/ nel file .gitignore. Nessuna modifica fatta. & pause & exit /b 1)
echo === COPIA DI SICUREZZA in corso in:
echo     %BACKUP_REPO%
git clone --mirror "%URL_REPO%" "%BACKUP_REPO%"
if errorlevel 1 (echo *** ERRORE: copia di sicurezza FALLITA. Nessuna modifica fatta. & pause & exit /b 1)
REM verifico che la copia contenga proprio il commit che sto per cancellare
git --git-dir="%BACKUP_REPO%" cat-file -e %SHA_REMOTO%^^{commit} >nul 2>&1
if errorlevel 1 (echo *** ERRORE: la copia non contiene il commit %SHA_REMOTO%. Nessuna modifica fatta. & pause & exit /b 1)
echo === COPIA DI SICUREZZA OK
echo.

REM --- PROTEZIONE 3: conferma forte riscrivendo il nome della repository ---
echo ************************************************************
echo ***  ATTENZIONE: su GitHub il branch %BRANCH% verra' SVUOTATO.
echo ***  Tutti i file e la storia spariranno da GitHub.
echo ***  (I file sul PC NON vengono toccati.)
echo ************************************************************
set "RISPOSTA="
set /p "RISPOSTA=Per confermare scrivi il nome esatto della repository (%NOME_REPO%): "
if not "%RISPOSTA%"=="%NOME_REPO%" (echo Nome diverso: operazione ANNULLATA. Nessuna modifica fatta. & pause & exit /b 0)

REM --- creo il commit vuoto (albero vuoto, senza passato) SENZA toccare il PC ---
set "ALBERO_VUOTO="
for /f %%E in ('git hash-object -t tree -w --stdin ^<nul') do set "ALBERO_VUOTO=%%E"
if not defined ALBERO_VUOTO (echo *** ERRORE: impossibile creare l'albero vuoto. Nessuna modifica fatta. & pause & exit /b 1)
set "COMMIT_VUOTO="
for /f %%C in ('git commit-tree %ALBERO_VUOTO% -m "SVUOTATO %NOME_REPO% il %TS%"') do set "COMMIT_VUOTO=%%C"
if not defined COMMIT_VUOTO (echo *** ERRORE: impossibile creare il commit vuoto. Nessuna modifica fatta. & pause & exit /b 1)

REM --- PROTEZIONE 4: push forzato SOLO se GitHub e' ancora uguale alla copia ---
echo.
echo === SVUOTAMENTO di %BRANCH% su GitHub ===
git push --force-with-lease=refs/heads/%BRANCH%:%SHA_REMOTO% "%URL_REPO%" %COMMIT_VUOTO%:refs/heads/%BRANCH%
if errorlevel 1 (
    echo *** ERRORE PUSH: %BRANCH% NON e' stato svuotato.
    echo ***   cause possibili: qualcuno ha aggiunto commit nel frattempo,
    echo ***   branch protetto su GitHub, credenziali o rete.
    pause & exit /b 1
)

REM --- facoltativo: cancello gli altri branch e i tag su GitHub ---
set "ALTRI="
for /f "tokens=2" %%R in ('git ls-remote --refs --heads --tags "%URL_REPO%"') do if not "%%R"=="refs/heads/%BRANCH%" set "ALTRI=1"
if defined ALTRI (
    echo.
    echo Su GitHub ci sono ancora questi altri branch / tag:
    for /f "tokens=2" %%R in ('git ls-remote --refs --heads --tags "%URL_REPO%"') do if not "%%R"=="refs/heads/%BRANCH%" echo    %%R
)
if defined ALTRI set "RISPOSTA="
if defined ALTRI set /p "RISPOSTA=Vuoi cancellare anche questi (sono gia' nella copia di sicurezza)? (S/N): "
if defined ALTRI if /i "%RISPOSTA%"=="S" (
    for /f "tokens=2" %%R in ('git ls-remote --refs --heads --tags "%URL_REPO%"') do if not "%%R"=="refs/heads/%BRANCH%" git push "%URL_REPO%" --delete "%%R"
)

REM --- PROTEZIONE 5: controllo finale ---
set "SHA_FINALE="
for /f %%A in ('git ls-remote --heads "%URL_REPO%" %BRANCH% 2^>nul') do set "SHA_FINALE=%%A"
if not "%SHA_FINALE%"=="%COMMIT_VUOTO%" (echo *** ATTENZIONE: su GitHub %BRANCH% non risulta svuotato. Controlla sul sito. & pause & exit /b 1)

REM aggiorno il riferimento locale origin/main (solo l'indicatore, i file non cambiano)
git fetch origin >nul 2>&1

echo.
echo ************************************************************
echo ***  FATTO: su GitHub %BRANCH% ora contiene solo un commit vuoto.
echo ***  Copia di sicurezza: %BACKUP_REPO%
echo ***  Per ripartire da zero: git_STATUS+PULL+ADD+COMMIT+PUSH.BAT
echo ***  Per recuperare la copia:  git_RICOSTRUISCI_GITHUB.BAT
echo ************************************************************
pause
endlocal
exit /b 0
