@echo off
setlocal
REM ====================================================================
REM  NOME FILE : git_STATUS+PULL+ADD+COMMIT+PUSH.BAT
REM  SCOPO     : allineare il repository locale con GitHub in un colpo solo
REM              (salva le modifiche locali, scarica quelle dell'altro PC,
REM               invia tutto su GitHub) scrivendo un LOG passo passo.
REM  REPOSITORY: la cartella di questo bat
REM              (c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS\MSys_DF14\)
REM              il bat si posiziona da solo: basta il doppio clic.
REM  LOG       : git_LOG.txt  (aggiunto in coda ad ogni esecuzione,
REM              resta solo sul PC: e' escluso nel .gitignore)
REM ====================================================================
REM
REM  FLUSSO DEI PASSI
REM  --------------------------------------------------------------------
REM  PASSO 0 - CONTROLLO REPOSITORY      comando: git rev-parse --show-toplevel
REM            Verifica che la cartella sia un repository git.
REM            Se NON lo e': ERRORE e il bat si ferma.
REM
REM  PASSO 1 - STATUS                     comando: git status -s
REM            Mostra i file modificati, nuovi o cancellati.
REM            Solo informativo: non modifica nulla e non ferma il bat.
REM
REM  PASSO 2a - ADD                       comando: git add -A
REM            Prepara per il commit TUTTE le modifiche del repository
REM            (file modificati, file nuovi e file cancellati).
REM
REM  PASSO 2b - COMMIT                    comando: git commit -m "AAAA_MM_GG_Hhh_Mmm_Sss_aggiornamento_MSYS"
REM            Salva le modifiche nella storia LOCALE.
REM            Se non c'e' nulla da salvare scrive "commit non necessario"
REM            e prosegue senza errori.
REM
REM  PASSO 2c - CONTROLLO MAIN SVUOTATO   comando: git fetch origin
REM            Se su GitHub main e' stato SVUOTATO con
REM            git_CANCELLA_TUTTI_I_DATI_IN_GITHUB.BAT (ultimo commit
REM            "SVUOTATO ...") si RIPARTE DA ZERO, come un primo commit:
REM              2d) COPIA DI SICUREZZA della storia del PC (git clone --mirror)
REM                  in AA_BACKUP_GITHUB\<data_ora>_SalvataggioGit_PRIMA_RIPARTENZA.git
REM                  (e' un PUNTO DI RIPRISTINO per git_RICOSTRUISCI_GITHUB.BAT)
REM                  (cosi' anche i commit del PC mai inviati non vanno persi)
REM              4)  crea UN SOLO commit NUOVO, SENZA PASSATO, con tutti i
REM                  file attuali della cartella ("PRIMO COMMIT - ripartenza")
REM                  e lo mette su GitHub al posto del commit vuoto:
REM                  git push --force-with-lease=refs/heads/main:<commit_svuotato> origin <nuovo>:refs/heads/main
REM              4b) il main del PC riparte da quel commit (git reset --soft):
REM                  i FILE della cartella NON cambiano.
REM            Il PULL viene SALTATO (le storie sono diverse).
REM            PROTEZIONE: --force-with-lease sovrascrive SOLO se su GitHub
REM            c'e' ancora esattamente quel commit vuoto; se nel frattempo
REM            qualcuno ha inviato altro, GitHub rifiuta e il bat si ferma.
REM            PIANO DI RISERVA: la vecchia storia e' nelle copie in
REM            AA_BACKUP_GITHUB e si rimette con git_RICOSTRUISCI_GITHUB.BAT.
REM
REM  PROTEZIONE COPIE: se esiste la cartella AA_BACKUP_GITHUB ma NON e'
REM            esclusa da git (.gitignore) il bat si FERMA prima di git add,
REM            cosi' le copie di sicurezza non finiscono mai su GitHub.
REM
REM  PASSO 3 - PULL                      comando: git pull --no-edit
REM            Scarica da GitHub le modifiche fatte sull'altro PC
REM            (casa/ufficio) e le unisce alle nostre.
REM            Viene DOPO il commit: cosi' le modifiche locali sono gia'
REM            salvate e l'unione non viene rifiutata.
REM            Se ci sono CONFLITTI: ERRORE e il bat si ferma (niente push).
REM
REM  PASSO 4 - PUSH                       comando: git push
REM            Invia su GitHub i commit locali.
REM            Se GitHub lo rifiuta: ERRORE e il bat si ferma.
REM
REM  DATA DEL COMMIT: calcolata con PowerShell (Get-Date), perche' WMIC
REM  non esiste piu' nelle versioni recenti di Windows 11.
REM
REM  PASSO 5 - STATO FINALE               comando: git status -sb
REM            "## main...origin/main" senza altro = tutto allineato.
REM
REM  ESITO
REM  --------------------------------------------------------------------
REM  - per ogni passo il log riporta: ora, COMANDO, risposta di git
REM    ed  "ESITO: OK"  oppure  "ESITO: ERRORE - codice N"
REM  - alla fine:  "ESITO FINALE: TUTTO OK"  oppure  "*** ERRORE ***"
REM  - in caso di errore il bat salta i passi successivi e apre il log
REM    nel Blocco note
REM
REM  ROUTINE INTERNE (in fondo al file)
REM  --------------------------------------------------------------------
REM  :esegui "TITOLO" comando  -- esegue il comando, lo mostra a video,
REM                               lo scrive nel log con il suo esito
REM  :scrivi "testo"           -- scrive una riga a video e nel log
REM ====================================================================
set "LOG=%~dp0git_LOG.txt"
set "TMPOUT=%TEMP%\git_bat_output.tmp"
set "ESITO=OK"

cd /d "%~dp0"

REM data nel formato AAAA_MM_GG_Hhh_Mmm_Sss (senza WMIC)
set "today="
for /f "delims=" %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy_MM_dd_\HHH_\Mmm_\Sss"') do set "today=%%i"
if not defined today set "today=SENZA_DATA"

call :scrivi ""
call :scrivi "################################################################"
call :scrivi "### INIZIO  %date%  %time:~0,8%"
call :scrivi "### PC: %COMPUTERNAME%   UTENTE: %USERNAME%"
call :scrivi "### REPOSITORY: %CD%"
call :scrivi "################################################################"

call :esegui "0) CONTROLLO REPOSITORY" git rev-parse --show-toplevel || goto :errore
call :esegui "1) STATUS" git status -s

REM protezione: le copie di sicurezza NON devono mai finire nei commit
if not exist "AA_BACKUP_GITHUB\" goto :copie_ok
git check-ignore -q "AA_BACKUP_GITHUB/"
if errorlevel 1 (call :scrivi "*** ERRORE: AA_BACKUP_GITHUB non e' esclusa da git: aggiungi AA_BACKUP_GITHUB/ nel .gitignore" & goto :errore)
:copie_ok

call :esegui "2a) ADD di tutte le modifiche" git add -A || goto :errore

git diff --cached --quiet
if errorlevel 1 (
   call :esegui "2b) COMMIT" git commit -m "%today%_aggiornamento_MSYS" || goto :errore
) else (
   call :scrivi ""
   call :scrivi "=== 2b) COMMIT"
   call :scrivi "    Nessuna modifica locale da salvare: commit non necessario."
   call :scrivi "    ESITO: OK"
)

REM --- 2c) se su GitHub main e' un commit "SVUOTATO ..." si riparte da zero ---
call :esegui "2c) CONTROLLO MAIN SVUOTATO su GitHub" git fetch origin || goto :errore
set "SHA_SVUOTATO="
git log -1 --format=%%s origin/main 2>nul | findstr /b /c:"SVUOTATO" >nul
if errorlevel 1 goto :pull_normale
git merge-base --is-ancestor origin/main HEAD
if not errorlevel 1 goto :pull_normale
for /f %%A in ('git rev-parse origin/main') do set "SHA_SVUOTATO=%%A"
for %%I in ("%CD%") do set "NOME_REPO=%%~nxI"
call :scrivi "    Su GitHub main e' SVUOTATO (commit %SHA_SVUOTATO%)"
call :scrivi "    RIPARTENZA DA ZERO: nuovo PRIMO COMMIT con i file attuali della cartella"

REM 2d) copia di sicurezza della storia del PC (anche i commit mai inviati)
if not exist "AA_BACKUP_GITHUB\" mkdir "AA_BACKUP_GITHUB"
git check-ignore -q "AA_BACKUP_GITHUB/"
if errorlevel 1 (call :scrivi "*** ERRORE: AA_BACKUP_GITHUB non e' esclusa da git (.gitignore)" & goto :errore)
set "BK_PC=%CD%\AA_BACKUP_GITHUB\%today%_SalvataggioGit_PRIMA_RIPARTENZA.git"
call :esegui "2d) COPIA DI SICUREZZA della storia del PC" git clone --mirror "%CD%" "%BK_PC%" || goto :errore

REM creo il PRIMO COMMIT senza passato con i file attuali (index = ultimo commit)
set "ALBERO="
for /f %%E in ('git write-tree') do set "ALBERO=%%E"
set "NUOVO="
if defined ALBERO for /f %%C in ('git commit-tree %ALBERO% -m "PRIMO COMMIT - ripartenza %NOME_REPO% %today%"') do set "NUOVO=%%C"
if not defined NUOVO (call :scrivi "*** ERRORE: impossibile creare il PRIMO COMMIT" & goto :errore)
call :scrivi "    PRIMO COMMIT creato: %NUOVO%"
call :esegui "4) PUSH su GitHub (PRIMO COMMIT al posto di main svuotato)" git push "--force-with-lease=refs/heads/main:%SHA_SVUOTATO%" origin %NUOVO%:refs/heads/main || goto :errore
call :esegui "4b) il main del PC riparte dal PRIMO COMMIT (i file non cambiano)" git reset --soft %NUOVO% || goto :errore
git fetch origin >nul 2>&1
goto :stato_finale

:pull_normale
call :esegui "3) PULL da GitHub" git pull --no-edit || goto :errore
call :esegui "4) PUSH su GitHub" git push || goto :errore

:stato_finale
call :esegui "5) STATO FINALE" git status -sb

call :scrivi ""
call :scrivi "################################################################"
call :scrivi "### ESITO FINALE: TUTTO OK - repository allineato con GitHub"
call :scrivi "### FINE  %date%  %time:~0,8%"
call :scrivi "################################################################"
echo.
echo Log salvato in: %LOG%
pause
exit /b 0

:errore
call :scrivi ""
call :scrivi "################################################################"
call :scrivi "### ESITO FINALE: *** ERRORE *** operazione interrotta"
call :scrivi "### Leggere sopra il comando con ESITO: ERRORE"
call :scrivi "### FINE  %date%  %time:~0,8%"
call :scrivi "################################################################"
echo.
echo Log salvato in: %LOG%  (si apre ora nel Blocco note)
start "" notepad "%LOG%"
pause
exit /b 1

REM ------------------------------------------------------------
REM  :esegui "TITOLO" comando...  -> esegue, mostra, registra, esito
REM ------------------------------------------------------------
:esegui
set "TITOLO=%~1"
shift
set "CMD="
:esegui_args
if "%~1"=="" goto :esegui_run
set "CMD=%CMD% %1"
shift
goto :esegui_args
:esegui_run
call :scrivi ""
call :scrivi "=== %TITOLO%   [%time:~0,8%]"
echo(    COMANDO:%CMD%
>> "%LOG%" echo(    COMANDO:%CMD%
%CMD% > "%TMPOUT%" 2>&1
set "RC=%errorlevel%"
type "%TMPOUT%"
type "%TMPOUT%" >> "%LOG%"
if "%RC%"=="0" call :scrivi "    ESITO: OK"
if not "%RC%"=="0" call :scrivi "    ESITO: ERRORE - codice %RC%"
del "%TMPOUT%" >nul 2>&1
exit /b %RC%

REM ------------------------------------------------------------
REM  :scrivi "testo"  -> scrive a video e nel log
REM ------------------------------------------------------------
:scrivi
if "%~1"=="" goto :scrivi_vuoto
echo(%~1
>> "%LOG%" echo(%~1
exit /b 0
:scrivi_vuoto
echo.
>> "%LOG%" echo.
exit /b 0
