@CHCP 65001 >NUL
@ECHO OFF
REM ================================================================================================
REM  Zip_N70_CREA_ElencoFile.bat
REM ================================================================================================
REM  Rigenera Zip_N70_ElencoFile.txt (lista per ZIP_7ZIP_INCREMENTALE_{CRIPTA+DECODIFICA_INTERNO}.BAT)
REM  leggendo il contenuto della cartella in cui si trova questo bat:
REM    1) intestazione di commento (righe //)
REM    2) cartelle e file di primo livello in UN UNICO elenco alfabetico
REM       (cartelle nella forma  NOMECARTELLA\ , file con il solo nome)
REM  Sono escluse:
REM    - la cartella .git
REM    - la cartella dei salvataggi  (CARTELLA_SALVATAGGI_S)
REM    - le cartelle elencate in Zip_N70_ElencoFileESCLUSI.txt  (righe // ignorate, .\ facoltativo)
REM  Nessuna riga ha spazi finali. Il file precedente viene copiato in
REM  %CARTELLA_SALVATAGGI_S%\Zip_N70_ElencoFile_PRECEDENTE.txt
REM  NB: questo bat e' salvato in UTF-8 (per la "è" dell'intestazione): non convertirlo in ANSI.
REM ================================================================================================

SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION
CD /D "%~dp0"

SET "LISTA_FILE_S=Zip_N70_ElencoFile.txt"
SET "LISTA_ESCLUSI_S=Zip_N70_ElencoFileESCLUSI.txt"
SET "CARTELLA_SALVATAGGI_S=AA_SALVATAGGI"
SET "TMP_LISTA=%TEMP%\Zip_N70_ElencoFile_%RANDOM%%RANDOM%.tmp"

REM ---------------------------------------------------------------- 01 INTESTAZIONE
> "%TMP_LISTA%" (
    ECHO(//ATTENZIONE AGLI SPAZI DI FINE RIGA non ci devono essere altrimenti non salva
    ECHO(//questo è il secondo esempio con path e file liberi senza .\ e sembra che funziona
    ECHO(//............................................................................//
)

REM ---------------------------------------------------------------- 02-03 CARTELLE E FILE
REM  Un unico elenco in ordine alfabetico (cartelle e file mescolati):
REM  le cartelle sono scritte con la \ finale, i file con il solo nome.
SET /A N_DIR=0
SET /A N_FILE=0
FOR /F "delims=" %%X IN ('DIR /B /A /O:N 2^>NUL') DO (
    IF EXIST "%%X\" (
        CALL :AGGIUNGI_CARTELLA "%%X"
    ) ELSE (
        >> "%TMP_LISTA%" ECHO(%%X
        SET /A N_FILE+=1
    )
)

REM ---------------------------------------------------------------- 04 BACKUP + SOSTITUZIONE
IF EXIST "%LISTA_FILE_S%" IF EXIST "%CARTELLA_SALVATAGGI_S%\" (
    COPY /Y "%LISTA_FILE_S%" "%CARTELLA_SALVATAGGI_S%\Zip_N70_ElencoFile_PRECEDENTE.txt" >NUL
)
MOVE /Y "%TMP_LISTA%" "%LISTA_FILE_S%" >NUL
IF ERRORLEVEL 1 (
    ECHO ERRORE: impossibile scrivere %LISTA_FILE_S%
    PAUSE
    EXIT /B 1
)

ECHO.
ECHO --------------------------------------------------------------------------------
ECHO  %LISTA_FILE_S% rigenerato in %CD%
ECHO  Cartelle inserite: %N_DIR%    File inseriti: %N_FILE%
ECHO --------------------------------------------------------------------------------
TYPE "%LISTA_FILE_S%"
ECHO --------------------------------------------------------------------------------
PAUSE
EXIT /B 0

REM ================================================================================================
REM  :AGGIUNGI_CARTELLA "nome"  -> scrive  nome\  se non e' esclusa
REM ================================================================================================
:AGGIUNGI_CARTELLA
SET "D=%~1"
IF /I "%D%"==".git" EXIT /B 0
IF /I "%D%"=="%CARTELLA_SALVATAGGI_S%" EXIT /B 0
SET "ESCLUSA="
IF EXIST "%LISTA_ESCLUSI_S%" (
    FOR /F "usebackq eol=/ delims=" %%E IN ("%LISTA_ESCLUSI_S%") DO CALL :CONFRONTA "%%E"
)
IF DEFINED ESCLUSA EXIT /B 0
>> "%TMP_LISTA%" ECHO(%D%\
SET /A N_DIR+=1
EXIT /B 0

REM ------------------------------------------------------------------------------------------------
REM  :CONFRONTA "riga esclusi"  -> toglie .\ iniziale e \ finale, poi confronta con %D%
REM ------------------------------------------------------------------------------------------------
:CONFRONTA
SET "E=%~1"
IF "%E:~0,2%"==".\" SET "E=%E:~2%"
IF "%E:~-1%"=="\" SET "E=%E:~0,-1%"
IF /I "%E%"=="%D%" SET "ESCLUSA=1"
EXIT /B 0
