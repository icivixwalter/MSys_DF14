@REM  FILE .BAT DI SALVATAGGIO INCREMENTALE CON IL LOG DI CONTROLLO

@REM  cambia questo parametro ---------:    c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS\MSys_DF14\
@REM
@REM  cambia questo parametro ---------:    _Msys_DF14



@CLS
@SETLOCAL ENABLEDELAYEDEXPANSION
@SET "ZIP_7ZIP_INCREMENTALE_FILE_LOG=%~dp0ZIP_7ZIP_INCREMENTALE_FILE_LOG.TXT"
@IF EXIST "%ZIP_7ZIP_INCREMENTALE_FILE_LOG%" DEL /F /Q "%ZIP_7ZIP_INCREMENTALE_FILE_LOG%"

@REM ================================================================================================
@REM INDICE DEI COMMENTI / SEZIONI
@REM ================================================================================================
@REM
@REM  00.00  INTESTAZIONE E AVVIO LOG
@REM  00.01  PARAMETRI GLOBALI (PATH, FILE, LISTA) - MODIFICABILI IN UN PUNTO SOLO
@REM  00.02  NOTE GENERALI SUL PROGETTO
@REM
@REM  01.00  CREAZIONE CARTELLA SALVATAGGI (PATH ASSOLUTO)
@REM  01.01  VERIFICA ESISTENZA CARTELLA DOPO MKDIR
@REM
@REM  02.00  TITOLO COSTRUZIONE BAT INCREMENTALE
@REM  02.01  IMPOSTAZIONE VARIABILI (PATH_DEST_S, PATH_PART_S, FILE_S, LISTA_FILE_S)
@REM  02.02  NOTE DI UTILITA (TUTORIAL, SUBLIME, LINK)
@REM
@REM  03.00  CONTROLLO PARAMETRI GENERALI
@REM  03.01  STAMPA DI CONTROLLO DELLE VARIABILI
@REM
@REM  04.00  TIPI FILE DA ARCHIVIARE (BLOCCATO - SOLO DOCUMENTAZIONE)
@REM  04.01  RAGGRUPPAMENTO ESTENSIONI
@REM  04.02  CONCATENAZIONE TIPO_FILE_S
@REM
@REM  05.00  GESTIONE DATA CORRENTE
@REM  05.01  CICLO FOR I CASO - wmic + fallback PowerShell
@REM  05.02  IMPOSTAZIONE ANNO_S, MESE_S, GIORNO_S, TODAY
@REM  05.03  CONTROLLO TODAY NON VUOTA
@REM
@REM  06.00  CHIAMATA DECODIFICA (Zip_N70_DECODIFICA.bat)
@REM  06.01  CONTROLLO ANNO_S
@REM  06.02  CALL Zip_N70_DECODIFICA.bat CON LOG ERRORLEVEL
@REM
@REM  07.00  SALVATAGGIO 7ZIP
@REM  07.01  POSIZIONAMENTO IN PATH_PART_S E CONTROLLO LISTA FILE
@REM  07.02  COMANDO 7ZIP u -tzip -r CON GESTIONE ERRORLEVEL (0 OK, 1 WARNING NOTO, >=2 ERRORE)
@REM  07.03  CONTROLLO CONTENUTO CARTELLA DESTINAZIONE
@REM  07.04  COMANDO 7ZIP l PER ESPORTARE LISTA CONTENUTO ARCHIVIO (CON .zip ESPLICITO)
@REM
@REM  08.00  CHIAMATA CRIPTA (Zip_N70_CRIPTA.bat)
@REM  08.01  CALL Zip_N70_CRIPTA.bat CON LOG ERRORLEVEL
@REM
@REM  09.00  SOSPENSIONE ED USCITA
@REM  09.01  MESSAGGIO FINALE E USCITA
@REM
@REM  A.00   SUBROUTINE :LOG (SCRIVE A VIDEO + SU FILE CON TIMESTAMP)
@REM  A.01   NOTE DOS DI UTILIZZO (DIR, PARAMETRI 7Z, CONCATENA STRINGHE)
@REM
@REM ================================================================================================

@CALL :LOG "==================== AVVIO BAT ===================="
@CALL :LOG "ZIP_7ZIP_INCREMENTALE_FILE_LOG = %ZIP_7ZIP_INCREMENTALE_FILE_LOG%"
@CALL :LOG "CWD iniziale = %CD%"

@REM ================================================================================================
@REM  00.00  INTESTAZIONE E AVVIO LOG
@REM ================================================================================================
@CLS
@echo.@@-------@_PROGETTO_BAT_INCREMENTALE_CRIPTA_DECOFICA_INTERNI@-----------------------

@REM ================================================================================================
@REM  00.02  NOTE GENERALI SUL PROGETTO
@REM ================================================================================================
@REM file di zip denominato : ZIP_7ZIP_INCREMENTALE_CRIPTA_INTERNO.MD
@REM @salvataggio@incrementale_(con file @zip@incrementale con @cripta @interno)
@REM
@REM Note_incrementale:
@REM questo bat effettua il salvataggio incrementale ma non ha i due file bat
@REM separati di criptaggio e decriptaggio in GE14 in quanto al suo interno effettua
@REM la trasformazione in file criptato.

@ECHO.
@ECHO.00.00 PROGETTO BAT INCREMENTALE BASATO SU 7zip
@ECHO.
@ECHO.
@ECHO. IMPOSTO I $PARAMETRI SU TUTTO IL FILE e qui possono essere cambiati e
@ECHO. di seguito puoi cambiare questo percorso path per una sostituzione collettiva:
@ECHO.
@ECHO. cambia questo parametro ---------:    c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS\MSys_DF14\
@ECHO.
@ECHO. cambia questo parametro ---------:    _Msys_DF14
@ECHO.
@ECHO.
@ECHO.
@ECHO. cambiando questi 2 parametri si ha effetto di cambiare i valori di tutti i parametri
@ECHO. dos preimpostati come di seguito indicato:
@ECHO.
@ECHO.                                  effetto sostituzione collettivo
@ECHO. --------------------------------------------------------------------------------------------------------
@ECHO. LA PATH DI DESTINAZIONE PER I SALVATAGGI     =  c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS\MSys_DF14\%CARTELLA_SALVATAGGI_S%
@ECHO. LA CARTELLA SALVATAGGI CREATA O ESISTENTE    =  c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS\MSys_DF14\AA_SALVATAGGI\
@ECHO. LA PATH DI PARTENZA                          =  c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS\MSys_DF14\
@ECHO. FILE 7ZIP, RAR DI SALVATAGGIO                =  ZIP_SALVATAGGI_Msys_DF14
@ECHO. LISTA FILE UTILIZZATA                        =  Zip_N70_ElencoFile.txt
@ECHO. --------------------------------------------------------------------------------------------------------
@ECHO.

@REM ================================================================================================
@REM  00.01  PARAMETRI GLOBALI (MODIFICABILI IN UN PUNTO SOLO)
@REM ================================================================================================
@SET "t=0"
@SET "CARTELLA_SALVATAGGI_S=AA_SALVATAGGI"
@SET "PATH_PART_S=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS\MSys_DF14\"
@SET "PATH_DEST_S=%PATH_PART_S%\%CARTELLA_SALVATAGGI_S%"
@SET "FILE_S=ZIP_SALVATAGGI_Msys_DF14"
@SET "LISTA_FILE_S=Zip_N70_ElencoFile.txt"

@CALL :LOG "PARAMETRI GLOBALI IMPOSTATI:"
@CALL :LOG "  t                     = %t%"
@CALL :LOG "  CARTELLA_SALVATAGGI_S = %CARTELLA_SALVATAGGI_S%"
@CALL :LOG "  PATH_PART_S           = %PATH_PART_S%"
@CALL :LOG "  PATH_DEST_S           = %PATH_DEST_S%"
@CALL :LOG "  FILE_S                = %FILE_S%"
@CALL :LOG "  LISTA_FILE_S          = %LISTA_FILE_S%"

@REM ================================================================================================
@REM  01.00  CREAZIONE CARTELLA SALVATAGGI (PATH ASSOLUTO)
@REM ================================================================================================
@CLS
@CALL :LOG "01.00 - CREO LA CARTELLA SALVATAGGI SE NON ESISTE (PATH ASSOLUTO)"

@IF NOT EXIST "%PATH_DEST_S%\" (
    @CALL :LOG "Cartella NON esiste, la creo con MKDIR: %PATH_DEST_S%"
    @MKDIR "%PATH_DEST_S%"
    @IF ERRORLEVEL 1 (
        @CALL :LOG "ERRORE: MKDIR fallito! ERRORLEVEL=%ERRORLEVEL%"
        @PAUSE
        @ENDLOCAL
        @EXIT /B 1
    )
)

@REM ================================================================================================
@REM  01.01  VERIFICA ESISTENZA CARTELLA DOPO MKDIR
@REM ================================================================================================
@IF NOT EXIST "%PATH_DEST_S%\" (
    @CALL :LOG "ERRORE FATALE: %PATH_DEST_S% non esiste dopo MKDIR"
    @PAUSE
    @ENDLOCAL
    @EXIT /B 1
)
@CALL :LOG "OK: cartella destinazione = %PATH_DEST_S%"
@DIR "%PATH_DEST_S%" >>"%ZIP_7ZIP_INCREMENTALE_FILE_LOG%" 2>&1
@TIMEOUT /T %t% /NOBREAK

@REM ================================================================================================
@REM  02.00  TITOLO COSTRUZIONE BAT INCREMENTALE
@REM ================================================================================================
@CLS
@CALL :LOG "02.00 - COSTRUZIONE BAT INCREMENTALE + IMPOSTAZIONE PARAMETRI"

@ECHO.
@ECHO.02.01 IMPOSTO LE VARIABILI GENERALI DI SEGUITO DENOMINATE
@ECHO.
@ECHO. le variabili da utilizzare:
@ECHO 1) Path di destinazione   ------------------------------ PATH_DEST_S
@ECHO 2) Path di partenza dove si trovano i dati ------------- PATH_PART_S
@ECHO 3) file di salvataggio compreso 7zip ------------------- FILE_S
@ECHO 4) Lista file dove prelevare i dati da comprimere ------ LISTA_FILE_S
@ECHO 5) La path corrente salvata con il ciclo for /f -------- PATH_CORR_S
@ECHO 6) variabile per la Sospensione del tempo -------------- t
@ECHO 7) variabile della cartella dei salvataggi ------------- CARTELLA_SALVATAGGI_S
@ECHO.

@REM ================================================================================================
@REM  02.01  IMPOSTAZIONE VARIABILI (GIA' FATTE IN 00.01, QUI SOLO CONFERMA)
@REM ================================================================================================
@CALL :LOG "02.01 - PATH_DEST_S = %PATH_DEST_S%"
@CALL :LOG "02.01 - PATH_PART_S = %PATH_PART_S%"
@CALL :LOG "02.01 - FILE_S      = %FILE_S%"

@REM Calcolo PATH_CORR_S con ciclo FOR (se CurrentDIR.bat non esiste, resta vuota)
@SET "PATH_CORR_S="
@FOR %%f IN ("CurrentDIR.bat") DO @SET "currDir_=%%~df%%~pf"
@SET "PATH_CORR_S=%currDir_%"
@CALL :LOG "02.01 - PATH_CORR_S = %PATH_CORR_S%"

@REM ================================================================================================
@REM  02.02  NOTE DI UTILITA (TUTORIAL, SUBLIME, LINK)
@REM ================================================================================================
@REM PROGETTO ZIP E 7ZIP VEDI DEFINIZIONI .BAT IN TUTTI I PROGETTI
@REM Per costruire un BAT incrementale denominato 7ZIP_INCREMENTALE.BAT
@REM occorre fare riferimento a questo progetto .BAT che si trova nel TUTORIAL ZIP E 7ZIP.
@REM Per individuare il progetto del bat incrementale occorre far riferimento al progetto
@REM .MD ZIP che si trova in questa path.
@REM
@REM TUTORIAL ZIP RAR O 7ZIP:
@REM   START "apri il progetto dei comandi PER IL TUTORIAL DI 7z" "c:\\CASA\\LINGUAGGI\ZIP\\ZIP.sublime-project"
@REM   START "apri il progetto dei comandi di TUTTI@PROGETTI" "c:\\CASA\\LINGUAGGI\\TROVA_PROGETTI\\TROVA_PROGETTI.sublime-project"
@REM
@REM SUBLIMETEXT: https://www.w3schools.io/editor/sublime-text-terminal/
@TIMEOUT /T %t% /NOBREAK

@REM ================================================================================================
@REM  03.00  CONTROLLO PARAMETRI GENERALI
@REM ================================================================================================
@CLS
@CALL :LOG "03.00 - CONTROLLO PARAMETRI GENERALI"

@REM ================================================================================================
@REM  03.01  STAMPA DI CONTROLLO DELLE VARIABILI
@REM ================================================================================================
@ECHO.03.02 STAMPA DI CONTROLLO DEL SETTAGGIO DELLE VARIABILI
@ECHO. controllo PATH di partenza...........PATH_PART_S             : %PATH_PART_S%
@ECHO. controllo PATH di DESTINAZIONE.......PATH_DEST_S             : %PATH_DEST_S%
@ECHO. controllo nome file Zip..............FILE_S                  : %FILE_S%
@ECHO. controllo elenco file salvati........LISTA_FILE_S            : %LISTA_FILE_S%
@ECHO. controllo della path corrente........PATH_CORR_S             : %PATH_CORR_S%
@ECHO. controllo della cartella ............CARTELLA_SALVATAGGI_S   : %CARTELLA_SALVATAGGI_S%

@CALL :LOG "03.01 - PATH_PART_S                 = %PATH_PART_S%"
@CALL :LOG "03.01 - PATH_DEST_S                 = %PATH_DEST_S%"
@CALL :LOG "03.01 - FILE_S                      = %FILE_S%"
@CALL :LOG "03.01 - LISTA_FILE_S                = %LISTA_FILE_S%"
@CALL :LOG "03.01 - CARTELLA_SALVATAGGI_S       = %CARTELLA_SALVATAGGI_S%"
@TIMEOUT /T %t% /NOBREAK

@REM ================================================================================================
@REM  04.00  TIPI FILE DA ARCHIVIARE (BLOCCATO - SOLO DOCUMENTAZIONE)
@REM ================================================================================================
@CLS
@CALL :LOG "04.00 - TIPI FILE DA ARCHIVIARE (BLOCCATO, NON USATO)"

@REM ================================================================================================
@REM  04.01  RAGGRUPPAMENTO ESTENSIONI
@REM ================================================================================================
@REM ATTENZIONE: niente spazi dopo il segno =
@SET TipoFile_TEXT_S=*.AUX *GZ *.LOG *.OUT *.TEX *.Tws
@SET TipoFile_JAVA_S=*.CLASS *.EXE *HTLM *.IML *.JAR *.JAVA *.LOG *.MF *.LNK *.XML
@SET TipoFile_TXT_S=*.TEX *.TWS *.TXT *BAT
@SET TipoFile_Office_S=*.MDB *.XLS *.PDF

@REM ================================================================================================
@REM  04.02  CONCATENAZIONE TIPO_FILE_S
@REM ================================================================================================
@SET TIPO_FILE_S=%TipoFile_TEXT_S% %TipoFile_JAVA_S% %TipoFile_TXT_S% %TipoFile_Office_S%
@CALL :LOG "04.02 - TIPO_FILE_S = %TIPO_FILE_S%"
@TIMEOUT /T %t% /NOBREAK

@REM ================================================================================================
@REM  05.00  GESTIONE DATA CORRENTE
@REM ================================================================================================
@CLS
@CALL :LOG "05.00 - GESTIONE DATA CORRENTE"

@REM ================================================================================================
@REM  05.01  CICLO FOR I CASO - wmic + fallback PowerShell
@REM ================================================================================================
@SET "MyDate="
@FOR /F "skip=1" %%x IN ('wmic os get localdatetime 2^>NUL') DO @IF NOT DEFINED MyDate @SET "MyDate=%%x"
@IF NOT DEFINED MyDate (
    @CALL :LOG "05.01 - wmic non disponibile, uso PowerShell come fallback"
    @FOR /F "delims=" %%x IN ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') DO @SET "MyDate=%%x"
)
@IF NOT DEFINED MyDate (
    @CALL :LOG "05.01 - ERRORE FATALE: impossibile ottenere la data"
    @PAUSE
    @ENDLOCAL
    @EXIT /B 1
)

@REM ================================================================================================
@REM  05.02  IMPOSTAZIONE ANNO_S, MESE_S, GIORNO_S, TODAY
@REM ================================================================================================
@SET "ANNO_S=%MyDate:~0,4%"
@SET "MESE_S=%MyDate:~4,2%"
@SET "GIORNO_S=%MyDate:~6,2%"
@SET "TODAY=%ANNO_S%_%MESE_S%_%GIORNO_S%"

@CALL :LOG "05.02 - MyDate  = [%MyDate%]"
@CALL :LOG "05.02 - ANNO_S  = [%ANNO_S%]"
@CALL :LOG "05.02 - MESE_S  = [%MESE_S%]"
@CALL :LOG "05.02 - GIORNO_S= [%GIORNO_S%]"
@CALL :LOG "05.02 - TODAY   = [%TODAY%]"

@REM ================================================================================================
@REM  05.03  CONTROLLO TODAY NON VUOTA
@REM ================================================================================================
@IF "%TODAY%"=="" (
    @CALL :LOG "05.03 - ERRORE FATALE: TODAY vuota"
    @PAUSE
    @ENDLOCAL
    @EXIT /B 1
)
@CALL :LOG "05.03 - TODAY valida"
@TIMEOUT /T %t% /NOBREAK

@REM ================================================================================================
@REM  06.00  CHIAMATA DECODIFICA (Zip_N70_DECODIFICA.bat)
@REM ================================================================================================
@CLS
@CALL :LOG "06.00 - CHIAMO DECODIFICA"

@REM ================================================================================================
@REM  06.01  CONTROLLO ANNO_S
@REM ================================================================================================
@CALL :LOG "06.01 - ANNO_S = [%ANNO_S%]"

@REM ================================================================================================
@REM  06.02  CALL Zip_N70_DECODIFICA.bat CON LOG ERRORLEVEL
@REM ================================================================================================
@CD /D "%PATH_PART_S%"
@CALL :LOG "06.02 - CWD = %CD%"

@IF NOT EXIST "Zip_N70_DECODIFICA.bat" (
    @CALL :LOG "06.02 - ERRORE: Zip_N70_DECODIFICA.bat NON trovato in %CD%"
    @PAUSE
) ELSE (
    @CALL :LOG "06.02 - Eseguo Zip_N70_DECODIFICA.bat"
    @CALL Zip_N70_DECODIFICA.bat
    @CALL :LOG "06.02 - Zip_N70_DECODIFICA.bat terminato. ERRORLEVEL=%ERRORLEVEL%"
)
@TIMEOUT /T %t% /NOBREAK

@REM ================================================================================================
@REM  07.00  SALVATAGGIO 7ZIP
@REM ================================================================================================
@CLS
@CALL :LOG "07.00 - SALVATAGGIO 7ZIP"

@REM ================================================================================================
@REM  07.01  POSIZIONAMENTO IN PATH_PART_S E CONTROLLO LISTA FILE
@REM ================================================================================================
@CD /D "%PATH_PART_S%"
@CALL :LOG "07.01 - CWD = %CD%"
@CALL :LOG "07.01 - PATH_DEST_S = %PATH_DEST_S%"
@CALL :LOG "07.01 - TODAY = %TODAY%"
@CALL :LOG "07.01 - FILE_S = %FILE_S%"

@IF NOT EXIST "%LISTA_FILE_S%" (
    @CALL :LOG "07.01 - ERRORE: %LISTA_FILE_S% NON trovato in %CD%"
    @PAUSE
    @ENDLOCAL
    @EXIT /B 1
)
@CALL :LOG "07.01 - Lista file %LISTA_FILE_S% trovata OK"

@SET "OUT_ZIP=%PATH_DEST_S%\%TODAY%_%FILE_S%"
@CALL :LOG "07.01 - OUT_ZIP = %OUT_ZIP%"

@REM ================================================================================================
@REM  07.02  COMANDO 7ZIP u -tzip -r CON GESTIONE ERRORLEVEL
@REM         INTERPRETAZIONE ERRORLEVEL:
@REM           0 = OK, lista pulita, nessun warning
@REM           1 = WARNING noto (tipico: righe // commento nella lista), archivio valido
@REM          >=2 = ERRORE reale, interrompo il bat
@REM ================================================================================================
@CALL :LOG "07.02 - Eseguo: 7z u -tzip -r \"%OUT_ZIP%\" @%LISTA_FILE_S%"
"C:\Program Files\7-Zip\7z.exe" u -tzip -r "%OUT_ZIP%" "@%LISTA_FILE_S%" >>"%ZIP_7ZIP_INCREMENTALE_FILE_LOG%" 2>&1
@SET "RC7Z=%ERRORLEVEL%"

@IF %RC7Z% GEQ 2 (
    @CALL :LOG "07.02 - ERRORE 7-Zip! ERRORLEVEL=%RC7Z%"
    @PAUSE
    @ENDLOCAL
    @EXIT /B %RC7Z%
) ELSE IF %RC7Z% EQU 1 (
    @CALL :LOG "07.02 - 7-Zip OK con WARNING noto (ERRORLEVEL=1) - righe // nella lista"
    @CALL :LOG "07.02 - I file sono stati archiviati correttamente, procedo"
) ELSE (
    @CALL :LOG "07.02 - 7-Zip OK (ERRORLEVEL=0) - lista 100%% pulita"
)

@REM ================================================================================================
@REM  07.03  CONTROLLO CONTENUTO CARTELLA DESTINAZIONE
@REM ================================================================================================
@CALL :LOG "07.03 - Contenuto %PATH_DEST_S% dopo 7z:"
@DIR /A "%PATH_DEST_S%" >>"%ZIP_7ZIP_INCREMENTALE_FILE_LOG%" 2>&1

@REM ================================================================================================
@REM  07.04  COMANDO 7ZIP l PER ESPORTARE LISTA CONTENUTO ARCHIVIO
@REM         NOTA: 7-Zip con -tzip aggiunge .zip in automatico al nome di output,
@REM               ma OUT_ZIP NON contiene .zip. Quindi qui aggiungo .zip esplicito
@REM               per far trovare l'archivio a 7z l.
@REM ================================================================================================
@CALL :LOG "07.04 - Esporto lista contenuto archivio (con .zip esplicito)"
"C:\Program Files\7-Zip\7z.exe" l "%OUT_ZIP%.zip" -bsp1 > "%PATH_DEST_S%\%TODAY%_%FILE_S%_LISTA.TXT" 2>>"%ZIP_7ZIP_INCREMENTALE_FILE_LOG%"
@SET "RC7ZL=%ERRORLEVEL%"

@IF %RC7ZL% GEQ 2 (
    @CALL :LOG "07.04 - ERRORE 7z l! ERRORLEVEL=%RC7ZL%"
) ELSE (
    @CALL :LOG "07.04 - 7z l OK (ERRORLEVEL=%RC7ZL%)"
)
@CALL :LOG "07.04 - Lista esportata in %PATH_DEST_S%\%TODAY%_%FILE_S%_LISTA.TXT"
@TIMEOUT /T %t% /NOBREAK

@REM ================================================================================================
@REM  08.00  CHIAMATA CRIPTA (Zip_N70_CRIPTA.bat)
@REM ================================================================================================
@CLS
@CALL :LOG "08.00 - CHIAMO CRIPTA"

@REM ================================================================================================
@REM  08.01  CALL Zip_N70_CRIPTA.bat CON LOG ERRORLEVEL
@REM ================================================================================================
@CD /D "%PATH_PART_S%"
@CALL :LOG "08.01 - CWD = %CD%"

@IF NOT EXIST "Zip_N70_CRIPTA.bat" (
    @CALL :LOG "08.01 - ERRORE: Zip_N70_CRIPTA.bat NON trovato in %CD%"
    @PAUSE
) ELSE (
    @CALL :LOG "08.01 - Eseguo Zip_N70_CRIPTA.bat"
    @CALL Zip_N70_CRIPTA.bat
    @CALL :LOG "08.01 - Zip_N70_CRIPTA.bat terminato. ERRORLEVEL=%ERRORLEVEL%"
)

@REM ================================================================================================
@REM  09.00  SOSPENSIONE ED USCITA
@REM ================================================================================================
@CLS
@CALL :LOG "09.00 - SOSPENSIONE ED USCITA"

@REM ================================================================================================
@REM  09.01  MESSAGGIO FINALE E USCITA
@REM ================================================================================================
@ECHO.
@ECHO.09.01
@ECHO."=================================================================="
@ECHO."            MSG - EXIT_PROCEDURA "
@ECHO.
@ECHO."ATTENZIONE '!!!' USCITA DALLA PROCEDURA : - USCITA - "
@ECHO."=================================================================="
@ECHO.
@ECHO.                        "**** fine ****"
@ECHO."=================================================================="

@CALL :LOG "==================== FINE BAT ===================="
@TIMEOUT /T %t% /NOBREAK

@ENDLOCAL
@EXIT /B 0

@REM ================================================================================================
@REM  A.00  SUBROUTINE :LOG (SCRIVE A VIDEO + SU FILE CON TIMESTAMP)
@REM ================================================================================================
:GOTO_EOF
:LOG
@SET "MSG=%~1"
@FOR /F "tokens=1-6 delims=/:., " %%a IN ("%DATE% %TIME%") DO @SET "TS=%%a/%%b/%%c %%d:%%e:%%f"
@ECHO [%TS%] %MSG%
@ECHO [%TS%] %MSG%>>"%ZIP_7ZIP_INCREMENTALE_FILE_LOG%"
@EXIT /B 0

@REM ================================================================================================
@REM  A.01  NOTE DOS DI UTILIZZO (DIR, PARAMETRI 7Z, CONCATENA STRINGHE)
@REM ================================================================================================
@REM ================================================================================================
@REM  PARAMETRI DOS - DIR
@REM ================================================================================================
@REM DIR in dos ha diversi parametri per visualizzare le cartelle ed i file:
@REM   /A:-d mostra solo i file
@REM   /O:n  mostra i file in ordine alfabetico
@REM   /W    elenco formato solo dai nomi dei file
@REM
@REM  PARAMETRI 7-ZIP
@REM ================================================================================================
@REM   -tzip  = parametro -t per tipo file processato (file zip)
@REM   -r     = iterazione delle sottocartelle
@REM   @file  = lista file da processare
@REM   path   = la path di salvataggio
@REM   -bsp1  = switch che permette il reindirizzamento dell'output su file
@REM
@REM  NOME DATA CORRENTE
@REM ================================================================================================
@REM   per il nome sulla data corrente occorre utilizzare la variabile tmp
@REM   che contiene il nome in AAMMGG_. Attenzione per espandere la variabile
@REM   occorre utilizzare ! ! altrimenti non funziona.
@REM
@REM  ATTENZIONE in @Zip_N70_ElencoFile.txt
@REM ================================================================================================
@REM   devi inserire solo le directory senza *.* e non le cartelle interne
@REM   perchè altrimenti salva solo le sottocartelle e non la cartella madre.
@REM   Quindi nel file.txt indicare le cartelle ORIGINE in questo modo:
@REM     c:\CASA\LINGUAGGI\ACCESS\
@REM     c:\CASA\LINGUAGGI\CPP\  ... ecc.
@REM
@REM   NOTA IMPORTANTE SU ERRORLEVEL 7-ZIP:
@REM     Se nella lista sono presenti righe che iniziano con // (commenti),
@REM     7-Zip le interpreta come nomi di file e restituisce ERRORLEVEL=1
@REM     (WARNING). Il bat e' configurato per ACCETTARE questo warning e
@REM     proseguire, perche' l'archivio viene comunque creato correttamente.
@REM     Se vuoi ERRORLEVEL=0, rimuovi le righe // dalla lista.
@REM
@REM ================================================================================================
@REM  DIR - ORDINAMENTO ALFABETICO DECRESCENTE PER DATA DI CREAZIONE
@REM ================================================================================================
@REM Sintassi: DIR [unità:][percorso][nomefile] [/P] [/W] [/O[[:]ordinamento]] [/S] [/B] [/L] [/V]
@REM   /A  Visualizza i file con gli attributi specificati
@REM       a:-d (-d) = non le directory
@REM       -h       = non i file nascosti
@REM   /O  Elenca file ordinandoli
@REM       o:-n (-n) = escluso ordine alfabetico
@REM   /T  Controlla campo data visualizzato o utilizzato per ordinare
@REM       t:c (:c) = ordina per creazione
@REM
@REM Esempio:
@REM   dir "c:\GESTIONI\GESTIONE_LLPP\02_SCANNER\" /a:-d -h /o:-n /t:c >>DOS_DIR_N01.txt
@REM
@REM ================================================================================================
@REM  OPZIONI DOS - ELENCO COMPLETO
@REM ================================================================================================
@REM   /p       per vedere l'elenco a schermate
@REM   /w       per vedere l'elenco formato solo dai nomi dei file
@REM   /a:h     mostra i file nascosti
@REM   /a:s     mostra i file di sistema
@REM   /a:d     mostra solo le subdirectory
@REM   /a:-d    mostra solo i file
@REM   /o:n     mostra in ordine alfabetico
@REM   /o:-n    mostra in ordine alfabetico inverso
@REM   /o:d     mostra in ordine di data
@REM   /o:-d    mostra in ordine di data inverso
@REM   /o:s     mostra in ordine di grandezza
@REM   /o:-s    mostra in ordine di grandezza inverso
@REM   /s       mostra tutto il disco
@REM   >prn     stampa l'elenco
@REM
@REM Esempio:
@REM   c:\> DIR c:\LETTERE\ROSSI /a:-d/o:n >prn
@REM   stampa l'elenco, in ordine alfabetico, di tutti i file contenuti
@REM   nella subdirectory \LETTERE\ROSSI, omettendo i nomi delle eventuali
@REM   subdirectory presenti.
@REM
@REM ================================================================================================
@REM  DOS STRINGHE CONCATENA
@REM ================================================================================================
@REM   set str1="Hello"
@REM   set str2="World"
@REM   set str3= "1"
@REM
@REM   set "str3=%str1% %str3% %str2%"
@REM   set "str4=%str1% %str2%"
@REM   set "str1=%str1% DOS %str2%"
@REM
@REM   echo "str3 concatenata ->" %str3%
@REM   echo "str4 concatenata ->" %str4%
@REM   echo "str1 concatenata ->" %str1%
@REM
@REM ================================================================================================
@REM  FINE FILE
@REM ================================================================================================
