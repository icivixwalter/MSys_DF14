@REM  cd.. devi posizionarti su git_desktop
cd /d "%~dp0"

dir 

@REM  apro la pagina web Profilo di EDGE quello personale si trova qui:
@rem 	c:\Users\walter.rossi\AppData\Local\Microsoft\Edge\User Data\Personale\



rem start msedge https://www.overleaf.com/project/678766715c38d59052417047

rem start msedge --profile-directory="Personale" http://intranet/	

start msedge --profile-directory="Personale" https://www.overleaf.com/project/6755e159c2770881d5686966	

rem start msedge --profile-directory="Profilo 1" http://intranet/

@rem start msedge --user-data-dir="C:\Users\walter.rossi\AppData\Local\Microsoft\Edge\User Data\Personale"



@rem pausa di 2 secondi per consentire il commit

@REM 01)
@REM sospensione per 1 secondo con crononometro 
@REM ---->	timeout /t 2 /nobreak > NUL
@REM ---->
ECHO
ECHO
ECHO  pausa di 2 secondi per consentire il commit
ECHO
@TIMEOUT /T 2 /NOBREAK

