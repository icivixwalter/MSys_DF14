ECHO OFF


@CLS
@echo.@@-------@_PROGETTO_BAT_DECODIFICA_@-----------------------

	@CLS
	@echo.01--------------------------------IMPOSTO LA VARIABILE T = Sospensione

		@ECHO.
		@ECHO.01.00 DECODIFICA, IMPOSTO LA VARIABILE DI SOSPENSIONE TEMPO
		@ECHO.
		@ECHO.

		@REM  ***************************************************************

		@REM     file batch : Salva-C ZIP
		@REM     directory = c:\CASA\CDM\ZIP_SALVATAGGI\ ; \DOC  e \STAMPE
		@REM     file WinZIP

		@REM  ***************************************************************

			@REM IMPOSTO LA VARIABILE PER LA SOSPENSIONE DEL TEMPO
				@REM .......................................................		
					@REM ---->	MODELLO timeout /t 2 /nobreak > NUL
					@REM        TIMEOUT /T %t% /NOBREAK
					@REM ---->	
					@SET t=2
					@echo Sospensione tempo per secondi: %t%
				@REM .......................................................		

	@CLS
	@echo.02--------------------------------FOR PER TROVARE LA PATH CORRENTE E DI SALVATAGGIO

		@ECHO.
		@ECHO.02.00 DECODIFICA, IMPOSTO LA PATH CORRENTE E QUELLA DEI SALVATAGGI 
		@ECHO.
		@ECHO.

			@REM CICLO FOR F PER TROVARE E SALVARE LA PATH CORRENTE
				@REM .......................................................
					@REM .......................................................		
						@for %%f in ("CurrentDIR.bat") DO @SET currDir_=%%~df%%~pf
						
						@REM alla fine del ciclo salvo la path corrente
						@REM per arrivare alla cartella dei salvataggi che viene 
						@REM creata dalla procedura zip oppure è gia esistente
						@SET PATH_DEST_S=%currDir_%AA_SALVATAGGI
						
						@ECHO.
						@ECHO. controllo della path di destinazione
						@ECHO. %PATH_DEST_S%
						@ECHO. 
							DIR %PATH_DEST_S%
						@REM PAUSE


						@REM SOSPENSIONE TEMPO IMPOSTATA CON T
						@REM ---->	timeout /t 2 /nobreak > NUL
						@REM ---->	
						@TIMEOUT /T %t% /NOBREAK
						@REM Pause

						@REM .......................................................


	@CLS
	@echo.03--------------------------------FOR GESTIONE DATA

		@ECHO.
		@ECHO.03.00 DECODIFICA, CICLO FOR PER LA DATA CORRENTE
		@ECHO.
		@ECHO.


		@REM CICLO FOR I E II CASO PER LA GESTIONE DELLA DATA
		@REM ========================================================================================================================
		:----------------------------CICLO FOR I CASO per la gestione della data con le sottostringhe ma aggiunge lo 0 se <10
		for /f "delims=" %%x in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do if not defined MyDate set MyDate=%%x
		echo solo il giorno:
		echo %MyDate:~6,2%

		echo I CASO la data con le sottostringhe con separataore l'undescore (_)
		set today=%MyDate:~0,4%_%MyDate:~4,2%_%MyDate:~6,2%

		echo.
		echo today in formato stringa: 
		echo %today%
		echo.

		:----------------------------CICLO FOR  II CASO cicolo for per per la data AAA MM GG senza sottostringhe

		ECHO E' possibile ottenere la data corrente in modo indipendente dalle impostazioni locali utilizzando
		ECHO SENZA armeggiare con le sottostringhe
		echo vedi il link: https://qastack.it/programming/10945572/windows-batch-formatted-date-into-variable
		echo .

		echo. II CASO la data senza le sottostringhe solo numerico e con separatore il trattino (-)

		@REM for /f %%x in ('wmic path win32_localtime get /format:list ^| findstr "="') do set %%x
		@REM set today=%Year%_%Month%_%Day%

		echo.
		ECHO %TODAY%
		echo.

				@REM SOSPENSIONE TEMPO IMPOSTATA CON T
				@REM ---->	timeout /t 2 /nobreak > NUL
				@REM ---->	
				@TIMEOUT /T %t% /NOBREAK
				@REM Pause


		@REM CICLO FOR I E II CASO PER LA GESTIONE DELLA DATA  *** FINE ***
		@REM ========================================================================================================================


	@CLS
	@echo.04--------------------------------VADO NELLA PATH DI SALVATAGGIO

		@ECHO.
		@ECHO.04.00 DECODIFICA, VADO NELLA PATH DI SALVATAGGIO PER IL CONTROLL DIR 
		@ECHO.
		@ECHO.



		@ECHO vado nella path di destinazione e faccio il controllo
		CD %PATH_DEST_S%
		DIR 

		@REM PAUSE

			@REM SOSPENSIONE TEMPO IMPOSTATA CON T
				@REM ---->	timeout /t 2 /nobreak > NUL
				@REM ---->	
				@TIMEOUT /T %t% /NOBREAK
				@REM Pause


	@CLS
	@echo.05--------------------------------DECODIFICO IN  ZIP

		@ECHO.
		@ECHO.05.00 DECODIFICO, RENAME DEL FILE DA .GE614 IN .ZIP
		@ECHO.
		@ECHO.


			@REM//CRIPTA i file .ZIP .zip in GE614

			@RENAME "%TODAY%*.GE614" "%TODAY%*.ZIP"



			@REM SOSPENSIONE TEMPO IMPOSTATA CON T
				@REM ---->	timeout /t 2 /nobreak > NUL
				@REM ---->	
				@TIMEOUT /T %t% /NOBREAK
				@REM Pause
