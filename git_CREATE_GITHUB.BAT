@echo off
REM ============================================================
REM  CREO LA REPOSITORY E LA COLLEGO A GITHUB (DA USARE UNA SOLA VOLTA)
REM ============================================================
REM
REM  PRIMA DI LANCIARLO:
REM   - creare su github.com la repository VUOTA
REM     (senza README, senza .gitignore, senza licenza),
REM     altrimenti il branch main esiste gia' e il bat si blocca.
REM   - per un nuovo progetto cambiare solo NOME_REPO e URL_REPO qui sotto.
REM
REM  PERCHE' SERVONO I BLOCCHI (problemi del vecchio bat se rilanciato):
REM   - "echo ... >> README.md" aggiungeva ogni volta una riga al README;
REM   - creava un commit inutile in piu';
REM   - "git remote add origin" andava in errore (origin gia' presente);
REM   - "git push" senza --force NON cancella i dati su GitHub: se il
REM     remoto e' diverso il push viene rifiutato. Il rischio vero era
REM     sporcare il repository locale, non perdere i dati remoti.
REM
REM  CONTROLLI ESEGUITI, IN QUESTO ORDINE:
REM   0) GitHub raggiungibile: se la repository non esiste su github.com
REM      o mancano internet / credenziali                    -> STOP con errore
REM   1) se su GitHub esiste gia' il branch main
REM      (git ls-remote --heads URL main)                    -> STOP "esiste gia'"
REM   2) se in locale il remote origin e' gia' collegato     -> STOP "esiste gia'"
REM   3) conferma esplicita: bisogna digitare S per procedere
REM   4) creazione prudente:
REM      - README.md creato SOLO se manca (non viene piu' allungato)
REM      - git init SOLO se la cartella .git non esiste
REM      - primo commit SOLO se il repository non ha ancora commit
REM      - push SEMPRE senza --force (non sovrascrive mai dati remoti)
REM
REM  SE LO RILANCI SU UN PROGETTO GIA' CREATO (es. MSys_DF14):
REM   si ferma al controllo 1 ("main ESISTE GIA' su GitHub") PRIMA di
REM   qualsiasi comando git che modifica qualcosa: nessun commit, nessun
REM   remote add, nessun push -> NON cancella e NON modifica nulla,
REM   ne' in locale ne' su GitHub. Anche se GitHub non risponde si ferma
REM   (controllo 0) senza toccare nulla.
REM
REM  CODICI DI USCITA: 0 = creato / annullato dall'utente, 1 = bloccato o errore
REM  DOPO LA CREAZIONE: per gli aggiornamenti usare git_STATUS+PULL+ADD+COMMIT+PUSH.BAT
REM ============================================================
setlocal
set "NOME_REPO=MSys_DF14"
set "URL_REPO=https://github.com/icivixwalter/MSys_DF14.git"

REM si posiziona da solo nella cartella del repository (quella di questo bat)
cd /d "%~dp0"
echo CARTELLA : %CD%
echo GITHUB   : %URL_REPO%
echo.

REM --- CONTROLLO 0: la repository su GitHub e' raggiungibile? ---
git ls-remote "%URL_REPO%" >nul 2>&1
if errorlevel 1 (
    echo *** ERRORE: la repository GitHub non esiste o non e' raggiungibile.
    echo ***         Creala prima su github.com oppure controlla internet / credenziali.
    pause & exit /b 1
)

REM --- CONTROLLO 1: il branch main esiste gia' su GitHub? ---
set "MAIN_REMOTO="
for /f %%A in ('git ls-remote --heads "%URL_REPO%" main 2^>nul') do set "MAIN_REMOTO=1"
if defined MAIN_REMOTO (
    echo ************************************************************
    echo ***  ATTENZIONE: il branch main ESISTE GIA' su GitHub     ***
    echo ***  La creazione e' gia' stata fatta: NON faccio nulla.  ***
    echo ***  Per aggiornare usa git_STATUS+PULL+ADD+COMMIT+PUSH   ***
    echo ************************************************************
    pause & exit /b 1
)

REM --- CONTROLLO 2: il remote origin e' gia' collegato in locale? ---
if exist ".git" (
    git remote get-url origin >nul 2>&1
    if not errorlevel 1 (
        echo *** ATTENZIONE: il remote origin e' GIA' collegato in locale:
        git remote get-url origin
        echo *** La creazione e' gia' stata fatta: NON faccio nulla.
        pause & exit /b 1
    )
)

REM --- CONFERMA ESPLICITA ---
set "RISPOSTA="
set /p "RISPOSTA=Confermi la creazione e il primo push di %NOME_REPO%? (S/N): "
if /i not "%RISPOSTA%"=="S" (echo Operazione annullata. & pause & exit /b 0)

REM --- CREAZIONE (solo se le cose non esistono gia') ---
if not exist "README.md" echo # %NOME_REPO%> README.md
if not exist ".git" git init

REM primo commit solo se il repository non ha ancora commit
git rev-parse --verify HEAD >nul 2>&1
if errorlevel 1 (
    git add README.md
    git commit -m "first commit creo repositori %NOME_REPO%"
)

git branch -M main
git remote add origin "%URL_REPO%"

REM push SENZA --force: se GitHub avesse gia' dei dati viene rifiutato e non cancella nulla
git push -u origin main
if errorlevel 1 (echo. & echo *** ERRORE PUSH: nessun dato remoto e' stato modificato. *** & pause & exit /b 1)

echo.
echo === REPOSITORY %NOME_REPO% CREATA E COLLEGATA A GITHUB ===
pause
endlocal
