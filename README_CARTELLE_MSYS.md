# @PROGETTI@IN@LAVORAZIONE
   2025.10.12 = IL PROGETTO IN LAVORAZIONE è quello esporta ed importa oggetti, vedi codice
                @ESPORTA@IMPORTA@OGGETTI

# SCHEMA CARTELLE E ASPETTI GENERALI DI UN MULTIPROGETTO ACCESS
   Note
      schema delle cartelle e dei file sul percorso del progetto:
            c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\
      Un PROGETTO ACCESS è composto da varie parti divisi fisicamente in cartelle.
      La cartella principale e le cartelle secondarie che dividono il progetto in questo modo:
            PROGETTO MASTER
               Contiene il database MULTIPROGETTO denominati
                  MULTIPROGETTO_MASTER.MDB
            MINI PROGETTI
               GESTIONE_PROGETTO_MINI.mdb
               ProgettiDefinizioni.mdb
               ProgettiArchivio.mdb
      Esempio di questa divisione puo essere questa:
         MSYS_ATTIVA_GEST_OGGETTI.mdb
            │__GE_MSys_DF01.mdb
                  │__MSys_DF01.mdb
   Vantaggi
      con questa divisione si possono costruire i proggetti in modo separato e modulare
      e con prove di gestione sia nel mini progetto che nel progetto master, essendo
      facilmente manutenibili.
   Accortezze
      Nel mini progetto BASE.MDB viene costruito un GESTORE DI OGGETTI che ha come unica
      funzione quella di IMPORTARE GLI OGGETTI direttamente dai mini progetti escluso dal
      proprio progetto sorgente.
      Quindi si hanno 2 tabelle di gestione per questa attivita:
         1) TABELLA OGGETTI     = che contiene path+database e gli oggetti che devono essere importati
         2) TABELLA SORGENTI    = contiene i database archivio e database definizioni che non possono 
         3)                         attivare l'importazione degli oggetti per evitare le cancellazioni
                                    inavvertite.



   ALBERO CARTELLE E FILE  - @albero@progetto_(il Progetto master ed i sub progetti)_@albero@cartelle
                           tutte da lavorare.
                           codice ----> $Project$Msys.DF14.01_(IN DF14 L'ALBERO DELLE Le cartelle del progetto Msys)

         MSYS/
            │
            │  --------------------------------------------------------------------------------------------------------------------------
            │           PROJECT                          CODICE_PROJECT                    ATTIVITA
            │  --------------------------------------------------------------------------------------------------------------------------
            │            │___MSYS_BASE/                            │  CODICE =BASE              │    = @DB@BASE da utilzzare per tutti i mini progetti 
            │            │___MSys_DF14/                            │  CODICE =DF14              │    = MODELLO BASE PER I PROGETTI MSYS                         - $Msys$DF14_(DF14 la base di tutto i progetti msys) 
            │            │___MSys_DF01/                            │  CODICE =DF01              │    = DEFINIZIONE DEI COMANDI DEL MENU                         - @comandi@menu_(di tutto il @superprogetto) 
            │            │___MSys_DF02/                            │  CODICE =DF02              │    = DEFINIZIONE DEI TIPI DI OGGETTO                          - @TIPO@DI@OGGETTO_(vengono definiti i tipi di oggetto gesti, FORM, QUERY TABELLE ECC..) 
            │            │___MSys_DF05/                            │  CODICE =DF05              │    = DEFINIZIONE DELLE QUOTE DEGLI OGGETTI                    - @QUOTE@DI@PROGETTO_(con le quote per ogni subprogetto puoi definire i gruppi di oggetti utilizzati) TODO: fose inutile dupelicato controllare o sostituire con CODICE PROGETTO 
            │            │___MSys_DF10/                            │  CODICE =DF10              │    = DEFINIZIONE DEI DATABASE UTILIZZATI                      - @DATABASE@UTILIZZATI_(i vari database utilizzati per la gestione del progetto di importazone ed esportazione) todo: COME UTILIZZARLI? 
            │            │___MSys_DF11/                            │  CODICE =DF11              │    = DEFINIZIONE DEI CODICI DI PROGETTO                       - @CODICI@PROGETTO_(con la TABELLA @DF11 ad ogni sub progetto viene attribuito un @codice@progetto, anche al MASTER) 
            │            │___MSys_DF12/                            │  CODICE =DF12              │    = DEFINIZIONE DEGLI OGGETTI NECESSARI AL PROGETTO          - 8 oggetti necessari per oggi progetto @oggetti@object_(per ogni progetto occorrono 8 oggetti, QURY, FORM REPORT ECC.) TODO: come utilizzarli? 
            │            │___MSys_DF13/                            │  CODICE =DF13              │    = DEFINIZIONI DELL LIBRERIE DLL DEL PROGETTO               - @DLL_(per ogni progetto occorrono le librerie DLL da stabilire) 
            │            │___MSys_DF14/                            │  CODICE =DF14              │    = PATH DI SALVATAGGIO DELLE LIBRERIE ACCESS                - dove sono state salve @librerie_(dove si trovano o dove sono state salvate) 
            │            │___MSys_ELENCO/                          │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSys_ESPORTA/                         │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSys_FORMS/                           │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSys_FORMS_MASTER/                    │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSys_GE_FILE/         **              │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSys_MACRO/                           │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSYS_MENU/                            │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSys_MODULI/                          │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSYS_OBJECT_DB_EST/                   │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSYS_OGGETTI_OLD/                     │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSys_PAGINE/                          │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSys_QUERY/                           │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSys_REPORT/                          │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSys_TABELLE/                         │  CODICE =123456            │    = da definire l'utilizzo??
            │            │___MSys_TB01_PROGETTI/                   │  CODICE=                   │    = I CODICE DI PROGETTO E LA LORO DEFINIZIONE @CODICI@PROGETTI_(dove sono definiti i codice dei progetti la denominazione e cosa fanno)
            │            │___MSys_TB02_TIPO_OGGETTI/               │  CODICE=                   │    = IL GRUPPO DI OGGETTI NECESSARI AL FUNZIONAMENTO DEI PROGETTI @gruppo@oggetti_(raggruppamento degli oggetti per ogni progetto)
            │            │___MSys_TB03_ELENCO_OGGETTI/             │  CODICE=                   │    = ELENCO DEGLI OGGETTI ASSEGNATI ad ogni progetto @eleco@project_(tutti gli oggetti necessari)
            │            │___Msys_TB05_FORMS/                      │  CODICE=                   │    = MSYS PER LA GESTIONE DI TUTTE LE FORMS *** IN RICOSTRUZIONE   
            │            │___Msys_TB12_FILES/                      │  CODICE= TB12_FILES        │    = MSYS PER LA GESTIONE DEI FILE                           - @GESTIONE@FILE_(la gestione dei file e delle carelle con le classi syste e le @api@windows) 
            │            │___Msys_TB30_UTIL/                       │  CODICE= TB30_UTIL *       │    = UTILITA IMPORTA PROGETTI ED I SERVIZI *** IN RICOSTRUZIONE
            │            │___Msys_TB40_PROG_MASTER/                │                            │    = LE FORM MASTER E LE SOTTOFORM MASTER
            │            │___MSys_TB41_VISUAL_PAG_MASTER/          │                            │    = LA VISUALIZZAZIONE DELLE PAGINE
            │            │___MSys_TUTTI_MODELLI/                   │                            │    = da studiare come ridefinire queti mini progetti
            │            │___TAB_CONTROL/                          │                            │    = da studiare come ridefinire queti mini progetti
            │            │___TAB_CONTROL_MASTER_(401_402_501_502)/ │                            │    = da studiare come ridefinire queti mini progetti
            │            │___TMP_IMPORTA_MODULI/                   │                            │    = da studiare come ridefinire queti mini progetti
            │            │___TMP_IMPORTA_MODULIOBJECT/             │                            │    = da studiare come ridefinire queti mini progetti
            │            │___TMP_OGGETTI_DA_CANCELLARE/            │                            │    = da studiare come ridefinire queti mini progetti
            │            │___TREVIEW/                              │                            │    = da studiare come ridefinire queti mini progetti
            │            │___UTIL/                                 │                            │    = da studiare come ridefinire queti mini progetti
            │           
            ├─OBJECT/            
            ├─XLS/            
            ├─.gitignore            
            ├─AA________________________________________________________________________AA.txt
            ├─ATTIVA_SALVATAGGI_COLLETTIVI_MSYS_OGGETTI+MENU+IMPEGNI.BAT
            ├─CANCELLA_{MDB+OBJECT+PROJECT}.BAT
            ├─git_OPEN_OVERLEAF.BAT
            ├─git_OpenGitHub.bat
            ├─git_PULL.BAT
            ├─git_STATUS.BAT
            ├─git_STATUS+PULL+ADD+COMMIT+PUSH.BAT
            ├─MSYS_N02________________________________________________________________MSYS.txt
            ├─Project_MSYS.sublime-project
            ├─Project_MSYS.sublime-workspace
            ├─README.md
            ├─ZIP_7ZIP_________________________________________________________________ZZ.txt
            ├─ZIP_7ZIP_INCREMENTALE_{CRIPTA+DECODIFICA_INTERNO}_CASA_C.BAT
            ├─ZIP_7ZIP_INCREMENTALE_{CRIPTA+DECODIFICA_INTERNO}_SAN_GIORGIO_C.BAT
            ├─ZIP_7ZIP_INCREMENTALE_{CRIPTA+DECODIFICA_INTERNO}_UFFICIO_C.BAT
            ├─Zip_N70_CRIPTA.bat
            ├─Zip_N70_DECODIFICA.bat
            ├─Zip_N70_ElencoFile.txt
            ├─Zip_N70_ElencoFileESCLUSI.txt
            └─ZZ________________________________________________________________________ZZ.txt

   ALBERO PROGETTO MSYS
      

# HELP IN HTML
## COME COSTRUIRE UN HELP CON LA PAGINA HTML
codice -----> @attivo@pagina@htlm
occorre inserire un un campo l'evento KeyDown o @Tasto@giu e si attiva l'evento
per chiamare dall'esterno la pagina html


   '//==================================================================================================//
   '//             EVENTI CASELLA DI TESTO @MODELLO@HELP@HTML_(EVENTI CON KEY DOWN  )   *** INIZIO ***
   '//==================================================================================================//
   '//EVENTI: _
       '//01_?                             = ...........
       '//02_MODELLO_HELP_s_TXT_KeyDown     = TASTO GIU CON KEY DOWN
       '//'
       '//codice -----> @attivo@pagina@htlm_(chiamo un evento tasto giu ed attivo la @pagina@html)'
       '//              puoi attivarlo anche per click in tal caso devi disattivare gli if e Keycode'
   
   
   
   '//@HELP@HTML@MODELLO
   Private Sub MODELLO_HELP_s_TXT_KeyDown(KeyCode As Integer, Shift As Integer)
   
   
   
       
       ' Se l'utente preme F1 (codice 112)
       If KeyCode = vbKeyF1 Then  ' vbKeyF1 è una costante VBA = 112
           ' Percorso assoluto del file HTML
           Dim percorsoHelp As String
           Dim FileHelp As String
           Dim HelpHtml_s  As String
           '//il percorso help + il file help
           percorsoHelp = "c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB03_ELENCO_OGGETTI\HELP\FORM\PROGETTI_Msys_TB02Frm01_01_TIPO_OGGETTI\"
           FileHelp = "HELP_MODELLO_HELP_s_TXT.html"
           HelpHtml_s = percorsoHelp & FileHelp
           
           ' Apri il file HTML
           Application.FollowHyperlink HelpHtml_s
           
           ' Annulla l'azione predefinita di F1
           KeyCode = 0
       End If
   
   
   
   End Sub
   
   
   '//==================================================================================================//

# RICOSTRUIRE LA REPOSITORY LOCALE ALLINEATA ALLA REMOTA
   Note
      devi svuotare completamente la cartella MSYS anche con i dati della
      repository locale .git ed applicare i seguenti comandi in seguenza.
      Nota bene è valita solo per la repository REMOTA MSYS.git

   RICOSTRUIRE LA REPOSITORY LOCALE DI GIT 
         per la repository REMOTA:  https://github.com/icivixwalter/MSYS.git
         
         Tutti i passaggi per ricostruire la repository locale allineata con quella remota :
         
        01) git init → creata la repository locale vuota.
        02) git remote add origin ... → collegato il repository remoto.
        03) git remote -v → confermato che il remote è registrato correttamente.
        04) git fetch origin → scaricati tutti i branch e commit remoti senza modificare il tuo branch locale.
        05) git checkout -b calcolo origin/calcolo → creato il branch locale calcolo e impostato il tracking con il remoto.
        06) git pull → niente da aggiornare perché ora il tuo branch locale è già allineato con origin/calcolo.
      
      Ora la tua repository locale è perfettamente sincronizzata con il remoto e pronta per lavorare.
         
         TUTTI I COMANDI DA ESEGUIRE:  @APRI@GIT@REMOTE
         
         
            cd c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS
            git init
            git remote add origin https://github.com/icivixwalter/MSYS.git
            git remote -v
            git fetch origin
            git checkout -b calcolo origin/calcolo
            git pull

      …or create a new repository on the command line
         echo "# MSys_GE_FILE" >> README.md
         git init
         git add README.md
         git commit -m "first commit"
         git branch -M calcolo
         git remote add origin https://github.com/icivixwalter/MSys_GE_FILE.git
         git push -u origin calcolo

            GitHub repository
            └── icivixwalter/MSys_GE_FILE
                └── calcolo   ← appena pubblicato


# RICOSTRUIRE LA PATH MSYS CON IL FILE .BAT
   Note
      la path msys puo essere ricostruita con il comando dos di seguito indicato.
      Essa ricalca lo schema delle cartelle sopra indito:

   DOS

         @REM FILE ----> BAT_RICREA_PATH_MSYS.BAT
            @echo off
            setlocal enableextensions
            
            rem Percorso completo da ricostruire
            set "TARGET=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS"
            
            if exist "%TARGET%" (
                echo Esiste già: "%TARGET%"
            ) else (
                echo Creo: "%TARGET%"
                mkdir "%TARGET%"
                if errorlevel 1 (
                    echo ERRORE: impossibile creare "%TARGET%".
                    exit /b 1
                ) else (
                    echo Creato con successo.
                )
            )
            
            endlocal

# MSYS_OGGETTI _(ANALISI PRINCIPALE)

@ UTILIZZO GIORNALIER0
	dove il github:           git : icivixwalter/MSYS_OGGETTI
	COMANDO PLURIMO               : 
               git pull & git status & git add . & git commit -m "agg casa" & git push & git pull

# MODIFICHE
   2025_05_12_EFFICIENTATO_LA GESTIONE DEI FILE 
      nel progetto GEFILE_Frm01_GESTIONI ho efficientato la gestione dei file, sulla 
         PAG_01 = il button RECUPERA PATH  è attivo e salva nella casella di testo
                  Percorso_Txt

         PAG_02 =    IL COMANDO APRI TUTTI I FILE CON 3 PARAMETRI è stato
               sistemato ed ora è attivo come button e sia come doppio click sia 
               sul campo testo path che su file. 

   2025_07_25_MSYS_ATTIVA_GEST_OGGETTI = CREO FUNZIONE PER IMPORTAZIONE LINK TABELLE
      Note

            DATABASE DI PROVA
               il db di prova in cui testo la nuova procedur si trova in questa path:

                  START "apro DB TEST" c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\TMP_IMPORTA_MODULI\MSYS_MODELLO.mdb

                     @total@commader_(apro la path test con il totalcommander)
                  START "APRI PATH TEST" "C:\Program Files\totalcmd\TOTALCMD64.EXE" /L="c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\TMP_IMPORTA_MODULI\" /R="c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\TMP_IMPORTA_MODULI\"

            per la gestione del database MSYS_ATTIVA_GEST_OGGETTI.mdb e delle sue
            form e query occorre gestione il collegamento di diverse tabelle.
            Il modulo che gestisce il link si chiama UTILITA_MsysDF14Mdl05_IMPORTAZIONE_SEMPLICE_DI_OGGETTI.
            Per ora viene utilizzata la routine di attivazione delle importazione denominata
            InizializzaCollectionTABELLE con la quale vengono gestite le seguenti importazioni
            o link codificate con :
               questo codice----> MSYS_ATTIVA_GEST_OGGETTI_Link_Tables.

            I link di seguito indicato sono rappresentati in gruppi di definizioni e quindi
            possono riguardare piu tabelle e db es. gruppo df13:
                  tbl.Add "Nome", "Msys_DF13_}----------------------------------------------------@"
                  "Msys_DF13_}----------------------------------------------------@"

            per attivare la procedura di collegamento chiamare la sub:
                  ImportaTabelle()


         GRUPPO LINK EFFETTUATI:
            01)_DF01
            02)_DF02 *     = correggi la path  ... OK CORRETTA
            04)_DF14
            05)_DF11
            06)_DF12
            07)_DF13
            08)_DF14

               RISULTATI DEI COLLEGAMENTI

                  Tabella 1: MSys_DF01_}----------------------------------------------------@
                  Tabella 2: MSys_DF01_COMANDI
                  Tabella 3: MSys_DF02_}----------------------------------------------------@
                  Tabella 4: MSys_DF02_TIPO_OGGETTO
                  Tabella 5: MSys_DF05_}----------------------------------------------------@
                  Tabella 6: MSys_DF05_ATTRIBUTI_TABELLA
                  Tabella 7: MSys_DF11_{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}_Tab
                  Tabella 8: MSys_DF11_}----------------------------------------------------@
                  Tabella 9: Msys_DF11_PROGETTI
                  Tabella 10: Msys_DF12_}----------------------------------------------------@
                  Tabella 11: Msys_DF12_GE_ObjProgetti
                  Tabella 12: Msys_DF13_}----------------------------------------------------@
                  Tabella 13: Msys_DF13_DLL_PROGETTO
                  Tabella 14: Msys_DF14_}----------------------------------------------------@
                  Tabella 15: Msys_DF14_DLL_LIBRERIE




OGGETTI CREATI MODIFICATI O MIGLIORATI
   DB MSys_MODULI.mdb
      2025.08.05
         START "APRI CARTELLA" "c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_MODULI\MDB\"
         Ho creato un modulo che esporta tutti gli oggetti in un file.txt
         per ora ESPORTA TUTTE LE QUERY del db corrente.
         Il modulo si chiama :
            ESPORTA_Mdl00_}------------------------------------------------@
            ESPORTA_Mdl01_TUTTI_GLI_OGGETTI_IN_FILE_LOG


   DB MSys_MODULI.mdb
      codice ---> 2025.08.05_MSys_MODULI.mdb_(vedi REAME per le modifiche e miglioramenti nel modulo)

         START "APRI CARTELLA" "c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_MODULI\MDB\"

         Sul progetto ho fatto le seguenti modifiche e migliramenti e creazioni di oggetti:
         Ho creato 4 macro per la cancellazione e la importazione degli oggetti moduli e tabelle:
            UTILITA_MsysDF14Mcr05_ATTIVA_CancellaModuli
            UTILITA_MsysDF14Mcr05_ATTIVA_CancellaTabelle
            UTILITA_MsysDF14Mcr05_ATTIVA_ImportaTabelle

         Ho migliorato il modulo di importazione semplice:
            UTILITA_MsysDF14Mdl05_}----------------------------------------@
            UTILITA_MsysDF14Mdl05_IMPORTAZIONE_SEMPLICE_DI_OGGETTI

   DB MSys_MODULI.mdb 06.08.2025
         CREATO MODULO: ESPORTA_Mdl01_TUTTI_GLI_OGGETTI_IN_FILE_HTML

            Sul db moduli ho fatto questi miglioramenti:
               c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TABELLE\MDB\MSys_TABELLE.mdb
               sul modulo:
                  ESPORTA_Mdl01_TUTTI_GLI_OGGETTI_IN_FILE_HTML, ho creato
               tutte le funzione per l'esportazione degli oggetti, TABELLE, QUERY, FORM, MODULI
               REPORT in fomato HTML VEDI CODICE ----> @esporta@query@HTML
               Con la macro SALVA_Mcr01_TUTTI_GLI_OGGETTI_IN_HTML, salvo tutti gli oggetti del db
               in OBJECT in formato html e quindi vale come salvataggi visibili e ricopiabili e
               quindi ricostruibili come codice. UNICA NOTA DA FINIRE sono i REPORT dove salva
               i dati in formato report  ma non la classe del report; quindi da rivedere.
               ATTENZIONE L'ESPORTAZIONE DELLA FORM MASTER deve essere duplicata, esportata e cancellata
               perche quella originale essendo aperto non puo essere esportata.
         MODIFICA MODULI 2025.08.25
            l'ulteriore modifica effettuata sul db moduli riguarda la FORM
               UTILITA_MsysDF14Frm05_ATTIVA_FUNZIONI
            la form vie utilizzata per la gestione MSYS_ATTIVA_GEST_OGGETTI.mdb è cioè per 
            il db principale; ho creato nella stessa almeno 3 tab con questo significato:
               TAB_PAG_01 = 01) CANCELLA ED IMPORTA OGGETTI UTILITA
                  serve per importare gli oggetti necessari per il funzionamento della
                  form master MSYS_ATTIVA_GEST_OGGETTI.mdb
                  con 4 button importa e cancella.

                  
                  



          TODO: rimande da controllare se questa esportazione funzona:

               1) COLLEGARE QUESTE TABELLE
                  MSys_TAB_}-----------------------------------------------------@
                  MSys_TABELLE
                  MSys_TABELLE_TMP
               2) IMPORTARE LE QUERY
                  MSys_TABELLE_Qry01_01_SELECT_TUTTE
                  MSys_TABELLE_Qry01_01_SELECT_TUTTE_TMP
               3) IMPORTARE LA FORM
                  MSys_TABELLE_Frm01_}-------------------------------------------@
                  MSys_TABELLE_Frm01_S01_TUTTE
                  MSys_TABELLE_Frm01_S01_TUTTE_TMP

# TOTAL COMMANDER CASA IMPOSTAZIONI
### Le impostazioni TotalCommander
   [Configuration]
   InstallDir=C:\Program Files\totalcmd
   languageini=wcmd_ita.lng
   Mainmenu=wcmd_ita.mnu
   UseNewDefFont=1
   SetEncoding=äö.do.not.remove
   firstmnu=1896
   FirstTime=0
   FirstTimeIconLib=0
   test=33
   MinIconWidth=-2
   MinLineHeight=-1
   FirstTimeUnpack=0
   FirstTimeZIP=0
   AutoSizeDialogs=1
   SeparateTree=0
   PanelsVertical=0
   TabDir=C:\Program Files\totalcmd\BARRA_PERSONALE\
   DirTabOptions=827
   DirTabLimit=32
   DirTabRevert=0
   DirTabFilters=0
   DirTabIcons=254
   Aligned extension=1
   Viewer=none
   Editor=""C:\Program Files\TextPad 8\TextPad.exe""
   Viewertype=1
   ShowHiddenSystem=1
   UseLongNames=1
   Small83Names=0
   OldStyleTree=0
   autotreechange=0
   DirBrackets=1
   ShowParentDirInRoot=0
   SortDirsByName=1
   Tips=3
   FileTipWindows=0
   Win32TipWindows=0
   SortUpper=0
   AssociationMultiVerbs=0
   LastSearchOptions=32
   UseEverything=0
   DarkMode=0
   CheckUsbHdd=0
   CompareCaseSensitive=0
   CompareIgnoreRepSpace=1
   CompareIgnoreRepeatedLines=1
   CompareVertical=0
   CompareBytesPerLine=8
   QuickSearchAutoFilter=1
   onlyonce=0
   TrayIcon=0
   UseRightButton=1
   Savepath=1
   Savepanels=1
   MarkDirectories=1
   AlwaysToRoot=0
   SingleClickStart=0
   RenameSelOnlyName=0
   SaveCommands=1
   EverythingForSize=0
   GetDirSize=0
   CountSpace=1
   CountMarked=1
   1hourdif=0
   AutoUpdateCheck=0
   CopyComments=6
   CommentPreferredFormat=4
   IconClickSelection=1
   AltSearch=2
   QuickSearchMatchBeginning=1
   QuickSearchExactMatch=0
   LogOptions=7198
   LogRotateLimit=0
   LogKeepCount=30
   ExplorerForCopy=0
   Win95Delete=0
   UseTrash=1
   DirMenuLast=1
   [ButtonbarCache]
   IconDll_default.bar=
   IconDll_vertical.bar=
   IconDll_DEFAULT_BAR_WR.BAR=
   [FileSystemPlugins64]
   $checksum$=3014672
   [Buttonbar]
   Buttonheight=29
   Buttonheight120=29
   FlatIcons=1
   SmallIcons=0
   XPstyle=0
   Buttonbar=C:\Users\icivi\AppData\Roaming\GHISLER\default.bar
   [1920x1080 (10x20)]
   Iconsize32=32
   Iconsize32_dpi=120
   FontSize=14
   FontName=Arial
   FontSizeWindow=14
   FontNameWindow=Times New Roman
   FontWeight=400
   FontWeightWindow=400
   FontNameDialog=Arial
   FontSizeDialog=14
   MenuChangeX=559
   MenuChangeY=260
   MenuChangeDX=800
   MenuChangeDY=500
   MenuChangeMax=0
   CmdSelX=555
   CmdSelY=272
   CmdSelDX=1102
   CmdSelDY=464
   CmdSelMax=0
   maximized=1
   x=272
   y=20
   dx=1375
   dy=980
   Divider=500
   DividerQuickView=500
   DividerComments=500
   Tabstops=315,319,380,256,596,94
   monitor(0,0,1920,1080;120)=272,20,1375,980
   SearchX=622
   SearchY=317
   SearchDX=1205
   SearchDY=333
   SearchMax=1
   RenameX=552
   RenameY=412
   RenameDX=900
   RenameDY=600
   RenameMax=1
   RenameTabs=144,181,931,1006,1156
   ConnectX=706
   ConnectY=240
   ConnectDX=606
   ConnectDY=500
   ConnectMax=0
   CompareX=382
   CompareY=254
   CompareDX=1174
   CompareDY=618
   CompareMax=0
   CompareDivider=500
   CustColumnX=549
   CustColumnY=259
   CustColumnDX=820
   CustColumnDY=500
   CustColumnMax=0
   PluginSelX=659
   PluginSelY=209
   PluginSelDX=600
   PluginSelDY=600
   PluginSelMax=0
   PrintX=554
   PrintY=197
   PrintDX=810
   PrintDY=625
   PrintMax=0
   FontCharsetDialog=1
   [AllResolutions]
   FontSize=14
   FontName=Arial
   FontSizeWindow=14
   FontNameWindow=Times New Roman
   FontWeight=400
   FontWeightWindow=400
   FontNameDialog=Arial
   FontSizeDialog=14
   FontCharsetDialog=1
   [left]
   path=c:\Casa\
   ViewMode=0
   activepanelcolor=-1
   activepanelcolor2=-1
   activepanelcolordark=-1
   activepanelcolordark2=-1
   ShowAllDetails=1
   SpecialView=0
   show=1
   negative Sortorder=0
   sortorder=0
   [right]
   path=c:\
   ViewMode=0
   activepanelcolor=-1
   activepanelcolor2=-1
   activepanelcolordark=-1
   activepanelcolordark2=-1
   ShowAllDetails=1
   SpecialView=0
   show=1
   negative Sortorder=0
   sortorder=1
   [Command line history]
   0=dir *.* /o >a.txt
   1=dir *.* /o/w >a.txt
   2=dir *.* >a.txt
   3=dir *.* > a.txt
   4=DIR /D *.* >A.TXT
   5=dir *.* >>a.txt
   6=dir /s /b | findstr /i /v "\\node_modules\\" > panoramica_progetto.txt
   7=dir *.* >> a.txt
   8=DIR *.* /S >>STRUTTURA_FILE.TXT
   9=dir *.* /s /w >>a.txt
   10=DIR *.* /S >> A.TXT
   11=DIR *.* /S >>FILE.TXT
   12=DIR *.* /S FILE.TXT
   13=dir *.* /s >a.txt
   14=dir *.* /s a.txt
   15=DIR *.* /S /D>A.TXT
   16=DIR *.* /S /D/W>A.TXT
   17=DIR *.* /S >A.TXT
   18=DIR /D/S *.* >A.TXT
   19=dir /d *.* >>prova.txt
   [MkDirHistory]
   0=MDB
   1=Msys_TB12_FILES
   2=PAGATO
   3=PAGATO_PETTULLI_TMP
   4=TMP
   5=QUANTI_CARATTERI_HA_QUESTA_PAROLA_CHE_DEVE_ESSERE_UTILIZZATA_PER_UN_TEST_PER_LA_LUNGHEZZA_TOTALE
   6=Q U A N T I _ C A R A T T E R I _ H A _ Q U E S T A _ P A R O L A _ M O L T O _ L U N G A _ C H E _ D E V E _ E S S E R E _ S U P E R I O R E _ A _ Q U E L L E _ N O R M A L I _ E _ C O M U N Q U E _ D E V E _ E S S E R E _ P R E D I S P O S T A _ P E R _ U N _ T E S T
   7=QUANTI(6)_(1)CARATTERI(9)_(1)HA(2)_(1)QUESTA(6)_(1)PAROLA(6)_(1)MOLTO(5)_(1)LUNGA(5)_(1)CHE(3)_(1)DEVE(4)_(1)ESSERE(6)_(1)SUPERIORE(9)_(1)A(1)_(1)QUELLE(6)_(1)NORMALI(7)_(1)E(1)_(1)COMUNQUE(8)_(1)DEVE(4)_(1)ESSERE(6)_(1)PREDISPOSTA(11)_(1)PER(3)_(1)UN(2)_(1)TEST(4)
   8=2026
   9=Msys_GEFILE_FrmM01_GE_SERVIZI_TB99_LINK
   10=HELP_Msys_GEFILE_FrmM01_GE_SERVIZI
   11=HELP
   12=OBJECT
   13=EMAIL
   14=FERIE
   15=RIPARTO_FONDO_LEGALE_MOROSITA
   16=BACKUP
   17=MODULES
   18=Msys_TB30_UTIL
   19=ORIZZONTE
   [Tabstops]
   0=315
   1=319
   3=380
   4=256
   6=596
   5=94
   AdjustWidth=1
   [Selection]
   0=*.*
   1=*.BAT
   2=*.7z
   3=*.odt
   4=*.doc
   5=*.zip
   6=*.pdf
   [Packer]
   ZIPlikeDirectory=0
   InternalUnarj=0
   ARJlongnames=0
   InternalUnlzh=0
   InternalUnrar=1
   LinuxCompatible=1
   ARJ=arj32.exe
   LHA=lha32.exe
   RAR=""C:\Program Files\7-Zip\7zFM.exe""
   UC2=uc.exe
   ACE=winace.exe
   InternalZip=1
   InternalUnzip=1
   zipnt=0
   zip7z=0
   ZIP=""C:\Program Files\7-Zip\7zFM.exe""
   UnZIP=""C:\Program Files\7-Zip\7zFM.exe""
   InternalZipRate=6
   Zip83Name=0
   ZipSetDateToNewest=0
   nodelete=0
   OpenPartial=0
   [ContentPlugins64]
   $checksum$=3014672
   [SearchName]
   0=sqllite
   1=icon*.*
   2=dao360.dll
   3=msacc
   4=*TORRI*.EXE
   5=*.EXE
   6=*2022*
   7=*2023*
   8=*2021*
   9=*mso9*
   10=*ms09*
   11=*MSCOMCTL.OCX*
   12=*MS09*
   13=MS09
   14=msac
   15=shared
   16=scrrun
   17=scrun
   18=scruntime
   19=msado21
   [SearchIn]
   0=c:\windows\System32
   1=c:\Casa\LINGUAGGI\HTML\HTML_PROGETTI\HTML_MULTIPROGETTO_WEB6\node_modules
   2=c:\CASA\PROGRAMMI\OFFICE_2000\Office_2000_Disco_01\O9PROCD01
   3=c:\CASA\LINGUAGGI\ACCESS\DLL_LIBRERIE
   4=c:\CASA\CDM\LeTorri\RUST
   5=f:\CASA\GE_CASA\BANCA\POSTA
   6=c:\CASA\GE_CASA\BANCA\BANCO_POSTA\ESTRATTI_CONTO\2024
   7=c:\Program Files (x86)\microsoft office\Office
   8=c:\Program Files\Microsoft Office\root\Office16
   9=c:\Program Files
   10=c:\Program Files (x86)
   11=c:\Program Files (x86)\Microsoft Office\Office
   12=C:\Program Files (x86)\Microsoft Office\Office
   13=C:\Program Files (x86)
   14=C:\Windows\System32
   15=C:\
   16=C:\CASA\PROGRAMMI\OFFICE_2000\Office_2000_Disco_01\O9PROCD01\PFILES\COMMON\SYSTEM\ADO
   17=c:\
   18=c:\CASA\PROGRAMMI\OFFICE_2000\Office_2000_Disco_02\O9PRMCD02\PFILES\COMMON\MSSHARED\VBA\VBA6
   19=d:\CASA\LINGUAGGI\ACCESS\2024_06_04_ZIP_SALVATAGGI_archivi_ACCESS.GE614
   [RenameTemplates]
   0=[N]
   [RenameSearchFind]
   0=IMU_ROMA_2025
   1=sqllite
   2=*.js
   3=_PRES
   4=_POSTA
   5=_MASTER
   6=MSYS_DF11
   7=FINECO_2024
   8=2024_
   9=2025
   10=2024
   11=_01
   12=_06
   13=_07
   14=2022
   15=2023
   16=06.00
   17=06.01
   18=CERRUTI)
   [RenameSearchReplace]
   0=IMU_ROMA_2026
   1=<Cancella>
   2=*.json
   3=_LLPP
   4=_PRES
   5=_POSTA
   6=MSYS_DF02
   7=FINECO_EECC_2024_
   8=FINECO_2024_
   9=2026
   10=2025
   11=_07
   12=_08
   13=_09
   14=06.01
   15=06.02
   16=2024
   17=CIRULLI)
   [DirMenu]
   menu1=C_IMPEGNI_DI_SPESA
   cmd1=cd c:\GESTIONI\GESTIONE_LLPP\25_GESTIONE_LLPP\LLPP_ARCHIVI_MDB\IMPEGNI_DI_SPESA\MDB\
   menu2=C_MSYS_MDB
   cmd2=cd c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB
   menu3=ENTRATEL_documenti
   cmd3=cd C:\CASA\LUIGINA\LUISA\entratel\documenti
   path3=c:\Casa\CDM\ViaBassini\
   menu4=DESKTOP_ROOT_PRINCIPALE
   cmd4=cd C:\CASA\LUIGINA
   path4=c:\Casa\CDM\ViaBassini\
   [ListerPlugins64]
   $checksum$=3014672
   [Associations]
   Filter1=*.pdf
   Filter1_open=""C:\Program Files\Tracker Software\PDF Viewer\PDFXCview.exe" "%1""
   Filter2=*.BAT
   Filter2_open=""C:\Program Files\Sublime Text\sublime_text.exe" "%1""
   Filter2.icon=C:\Program Files\Sublime Text\sublime_text.exe
   Filter3=*.7z
   Filter3_open=""C:\Program Files\7-Zip\7zFM.exe" "%1""
   Filter4=*.odt
   Filter4_open=""C:\Program Files\LibreOffice\program\swriter.exe" "%1""
   Filter5=*.doc
   Filter5_open=C:\Windows\Installer\{00010410-78E1-11D2-B60F-006097C998E7}\wordicon.exe "%1"
   Filter6=*.zip
   Filter6_open=""C:\Program Files\7-Zip\7zFM.exe" "%1""
   [CustomFields]
   AutoLoad=0
   Widths1=141,40,-40,67,69
   Contents1=[=tc.size]\n[=tc.writedate]\n[=tc.creationdate.D/M/Y]
   Options1=1906|1|120
   Titles=Visualizzazione valter
   Headers1=Dimensione\ndt modifica\ndt creazione
   [ViewModes]
   0_name=<Predefinito/a>
   0_icon=
   0_options=1|-1|0||-1|-1|-1|-1|-1
   [PrintDir]
   FontName=Arial
   FontSize=9
   FontFlags=
   [user]
   [RightHistory]
   0=c:\
   1=c:\CASA\CDM\ViaBassini\2025\EMAIL\
   2=c:\CASA\CDM\ViaBassini\2025\   #03,EMAIL
   3=c:\CASA\CDM\ViaBassini\  #03,2025
   4=c:\CASA\CDM\ #06,ViaBassini
   5=c:\CASA\CDM\ViaBassini\2026\2025_05_19_ASSEMBLEA_ORDINARIA\RIPARTO_FONDO_LEGALE_MOROSITA\
   6=c:\CASA\CDM\ViaBassini\2026\2025_05_19_ASSEMBLEA_ORDINARIA\  #02,RIPARTO_FONDO_LEGALE_MOROSITA
   7=c:\CASA\CDM\ViaBassini\2026\2025_05_19_ASSEMBLEA_ORDINARIA\DOCUMENTI_ASSEMBLEA\   #0
   8=c:\CASA\CDM\ViaBassini\2026\2025_05_19_ASSEMBLEA_ORDINARIA\  #01,DOCUMENTI_ASSEMBLEA
   9=c:\CASA\CDM\ViaBassini\2026\   #01,2025_05_19_ASSEMBLEA_ORDINARIA
   10=c:\CASA\CDM\ViaBassini\2026\VERSAMENTI\   #01,2026_01_09_ViaBassini_ARCIERO_LUIGINA_1RATA_2026_avviso_11861R411_242,00.zip
   11=c:\TEMP\ #01,Test260
   12=c:\TEMP\Test260\  #01,QUANTI_CARATTERI_HA_QUESTA_PAROLA_CHE_DEVE_ESSERE_UTILIZZATA_PER_UN_TEST_PER_LA_LUNGHEZZA_TOTALE
   13=c:\TEMP\Test260\QUANTI_CARATTERI_HA_QUESTA_PAROLA_CHE_DEVE_ESSERE_UTILIZZATA_PER_UN_TEST_PER_LA_LUNGHEZZA_TOTALE\ #0
   14=c:\   #011,TEMP
   15=c:\TMP\  #0
   16=c:\   #012,TMP
   17=c:\TMP\
   18=c:\TMP\FERIE\  #01,BACKUP_FERIE_2026
   19=c:\TMP\  #1,FERIE
   20=c:\   #11,TMP
   21=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\PAGATO_MATTIOLI_TMP\
   22=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\ #1,PAGATO_MATTIOLI_TMP
   23=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\PAGATO_PETTULLI_TMP\  #1,IMU_ROMA_2026_02_PETTULLI_EMILIA_(ACCONTO_295,00).zip
   24=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\ #2,PAGATO_PETTULLI_TMP
   25=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\PAGATO_MATTIOLI_TMP\  #3,F24_IMU_SANTACROCE_DI_MAGLIANO_2026_01_PETTULLI_EMILIA_(ACCONTO_78,00).pdf
   26=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\PAGATO_PETTULLI_TMP\
   27=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\PAGATO_MATTIOLI_TMP\  #2,F24_IMU_ROMA_2026_02_PETTULLI_EMILIA_(ACCONTO_295,00).PDF
   28=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\PAGATO_MATTIOLI_TMP\  #1,F24_IMU_ROMA_2026_01_MATTIOLI_VITTORIO_(ACCONTO_295,00).pdf
   29=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\TMP\   #1,IMU_ROMA_2026_01_MATTIOLI_VITTORIO_(ACCONTO_295,00).zip
   30=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\ #1,TMP
   31=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\TMP\
   32=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\   #010,2026
   33=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\ #7,PETTULLI_EMILIA_F24_SALDO_IMU_2026_(DA_PAGARE).pdf
   34=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\ #01,IMU
   35=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\  #01,MATTIOLI_VITTORIO_PETTULLI_EMILIA
   36=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ #09,ROMA
   37=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\ #02,PETTULLI_EMILIA
   38=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\PETTULLI_EMILIA\   #01,IMU
   39=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\PETTULLI_EMILIA\IMU\  #05,2026
   40=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\PETTULLI_EMILIA\IMU\2026\   #0
   41=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\MDB\LOGS\
   42=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\MDB\  #1,LOGS
   43=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\MDB\LOGS\   #2,20260607_112352_TB99_Link_Rebuild_Log.txt
   44=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\  #0
   45=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_12_ZIP_SALVATAGGI_MSYS_CASA.GE614/  #02,MDB
   46=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_12_ZIP_SALVATAGGI_MSYS_CASA.GE614/MDB\ #015,MDB\MSys_TB99_LINK
   47=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_12_ZIP_SALVATAGGI_MSYS_CASA.GE614/MDB\MSys_TB99_LINK\ #03,MDB\MSys_TB99_LINK\MDB
   48=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_12_ZIP_SALVATAGGI_MSYS_CASA.GE614/MDB\MSys_TB99_LINK\MDB\   #2,MDB\MSys_TB99_LINK\MDB\MSys_TB99_LINK.mdb
   49=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_12_ZIP_SALVATAGGI_MSYS_CASA.GE614/MDB\ #014,MDB\MSys_TB99_LINK
   50=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\  #07,2026_06_12_ZIP_SALVATAGGI_MSYS_CASA.GE614
   51=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_07_ZIP_SALVATAGGI_MSYS_CASA.GE614/  #02,MDB
   52=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_07_ZIP_SALVATAGGI_MSYS_CASA.GE614/MDB\ #09,MDB\MSys_TB99_LINK
   53=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_07_ZIP_SALVATAGGI_MSYS_CASA.GE614/MDB\MSys_TB99_LINK\ #02,MDB\MSys_TB99_LINK\MDB
   54=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_07_ZIP_SALVATAGGI_MSYS_CASA.GE614/MDB\MSys_TB99_LINK\MDB\   #2,MDB\MSys_TB99_LINK\MDB\MSys_TB99_LINK.mdb
   55=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_07_ZIP_SALVATAGGI_MSYS_CASA.GE614/MDB\ #017,MDB\MSys_TB99_LINK
   56=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\  #14,2026_06_07_ZIP_SALVATAGGI_MSYS_CASA.GE614
   57=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_05_ZIP_SALVATAGGI_MSYS_CASA.GE614/  #02,MDB
   58=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_05_ZIP_SALVATAGGI_MSYS_CASA.GE614/MDB\ #015,MDB\MSys_TB99_LINK
   59=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_05_ZIP_SALVATAGGI_MSYS_CASA.GE614/MDB\MSys_TB99_LINK\ #2,MDB\MSys_TB99_LINK\MSys_TB99_LINK.mdb
   60=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_05_ZIP_SALVATAGGI_MSYS_CASA.GE614/MDB\ #14,MDB\MSys_TB99_LINK
   61=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\  #016,2026_06_05_ZIP_SALVATAGGI_MSYS_CASA.GE614
   62=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_04_11_ZIP_SALVATAGGI_MSYS_CASA.GE614/  #02,MDB
   63=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_04_11_ZIP_SALVATAGGI_MSYS_CASA.GE614/MDB\ #5,MDB\MSys_TB03_ELENCO_OGGETTI
   64=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\  #011,2026_04_11_ZIP_SALVATAGGI_MSYS_CASA.GE614
   65=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\2026_06_12_ZIP_SALVATAGGI_MSYS_CASA.GE614/MDB\ #8,MDB\MSys_TB99_LINK
   66=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\AA_SALVATAGGI\  #6,2026_06_12_ZIP_SALVATAGGI_MSYS_CASA.GE614
   67=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\ #02,AA_SALVATAGGI
   68=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\   #041,MSys_TB99_LINK
   69=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\   #04,MDB
   70=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\MDB\  #02,MSys_TB99_LINK.ldb
   71=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\HELP\Msys_GEFILE_FrmM01_GE_SERVIZI_TB99_LINK\
   72=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\HELP\ #01,Msys_GEFILE_FrmM01_GE_SERVIZI_TB99_LINK
   73=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\   #2,HELP
   74=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\HELP\Msys_GEFILE_FrmM01_GE_SERVIZI_TB99_LINK\   #1,HELP_FrmM01_GE_SERVIZI_TB99_LINK.html
   75=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\   #02,HELP
   76=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\HELP\ #1,Msys_GEFILE_FrmM01_GE_SERVIZI_TB99_LINK
   77=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\HELP\Msys_GEFILE_FrmM01_GE_SERVIZI_TB99_LINK\   #1,HELP_GE_SERVIZI_TB99_LINK.html
   78=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\HELP\Msys_GEFILE_FrmM01_GE_SERVIZI_TB99_LINK\   #1,HELP_PROGETTI_Msys_TB02Frm01_01_TIPO_OGGETTI.html
   79=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\HELP\Msys_GEFILE_FrmM01_GE_SERVIZI_TB99_LINK\   #0
   80=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\   #013,MSys_TB99_LINK
   81=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB02_TIPO_OGGETTI\ #01,MDB
   82=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB02_TIPO_OGGETTI\MDB\   #02,Msys_TB02_TIPO_OGGETTI.MDB
   83=c:\TMP\FERIE\
   84=C:\Users\icivi\
   85=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_DF11\
   86=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_DF11\MDB\ #6,CANC_TutteTabelleCollegate_PFunct_LOG.txt
   87=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_DF11\  #02,MDB
   88=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\   #1,MSys_DF11
   89=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\Msys_TB30_UTIL\   #1,MDB
   90=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\Msys_TB30_UTIL\MDB\  #1,GE_Msys_TB30_UTIL.mdb
   91=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\Msys_TB30_UTIL\   #01,MDB
   92=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\Msys_TB30_UTIL\MDB\  #1,Msys_TB30_UTIL.mdb
   93=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\   #14,Msys_TB30_UTIL
   94=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_DF11\MDB\ #1,MSys_DF11.mdb
   95=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\Msys_TB30_UTIL\MDB\  #01,Msys_TB30_UTIL.ldb
   96=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\
   97=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\   #02,MSYS
   98=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\ #0
   99=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\   #2,MSYS
   100=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\   #04,MDB
   101=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #5,MSys_TB03_ELENCO_OGGETTI
   102=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\Msys_TB30_UTIL\
   103=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #015,Msys_TB30_UTIL
   104=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\Msys_TB30_UTIL\MDB\ #0
   105=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\Msys_TB30_UTIL\MDB\ #1,Msys_TB30_UTIL_nw.mdb
   106=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #9,Msys_TB30_UTIL
   107=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\  #01,LOGS
   108=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\
   109=C:\TMP\ #1,MSys_TB99_LINK.mdb
   110=c:\GESTIONI\GESTIONE_LLPP\25_GESTIONE_LLPP\LLPP_ATTI_TB05_PER_ISTRUTTORE\MDB\
   111=c:\GESTIONI\GESTIONE_LLPP\25_GESTIONE_LLPP\LLPP_ATTI_TB05_PER_ISTRUTTORE\ #01,MDB
   112=c:\GESTIONI\GESTIONE_LLPP\25_GESTIONE_LLPP\ #06,LLPP_ATTI_TB05_PER_ISTRUTTORE
   113=c:\GESTIONI\GESTIONE_LLPP\25_GESTIONE_LLPP\MSYS_OGGETTI\   #03,MDB
   114=c:\GESTIONI\GESTIONE_LLPP\25_GESTIONE_LLPP\MSYS_OGGETTI\MDB\  #0
   115=c:\GESTIONI\GESTIONE_LLPP\25_GESTIONE_LLPP\ #10,MSYS_OGGETTI
   116=c:\GESTIONI\GESTIONE_LLPP\   #01,25_GESTIONE_LLPP
   117=c:\GESTIONI\  #02,GESTIONE_LLPP
   118=c:\  #05,GESTIONI
   119=c:\CASA\   #02,GE_CASA
   120=c:\CASA\CDM\  #5,NORMATIVA
   121=c:\Casa\Pres3000\
   122=c:\CASA\CDM\ViaBassini\2026\2025_05_19_ASSEMBLEA_ORDINARIA\
   123=c:\Casa\   #01,CDM
   124=c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSYS_MENU\
   125=c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSYS_MENU\MDB\   #0
   126=c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSYS_MENU\ #01,MDB
   127=c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #014,MSYS_MENU
   128=c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_MODULI\  #0
   129=c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #7,MSys_MODULI
   130=c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\TMP_IMPORTA_MODULI_NUOVO_TEST\MsysUTIL\MDB\
   131=c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\TMP_IMPORTA_MODULI_NUOVO_TEST\MsysUTIL\  #01,MDB
   132=c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\TMP_IMPORTA_MODULI_NUOVO_TEST\  #1,MsysUTIL
   133=c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #13,TMP_IMPORTA_MODULI_NUOVO_TEST
   134=c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\TMP_IMPORTA_MODULI\ #08,LOG_ImportaModuli_PFunct.txt
   135=C:\CASA\LINGUAGGI\
   136=C:\CASA\LINGUAGGI\DOS\ #06,GIT_BAT
   137=C:\CASA\LINGUAGGI\DOS\GIT_BAT\  #2,git_STATUS+ADD+COMMIT+PUSH.BAT
   138=C:\CASA\LINGUAGGI\DOS\ #6,GIT_BAT
   139=C:\CASA\LINGUAGGI\  #03,DOS
   140=C:\CASA\   #03,LINGUAGGI
   141=C:\CASA\LINGUAGGI\ACCESS\
   142=C:\CASA\LINGUAGGI\  #2,ACCESS
   143=C:\CASA\LINGUAGGI\DOS\ #2,COMANDI_DOS
   144=C:\  #03,CASA
   145=C:\CASA\LINGUAGGI\  #07,POWERSHELL
   146=C:\CASA\LINGUAGGI\POWERSHELL\   #4,README_POWERSHELL.md
   147=C:\CASA\LINGUAGGI\DOS\ #04,DOS_PROGETTI
   148=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\   #7,CRIPTA_SHA256
   149=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\AA_SALVATAGGI\
   150=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\   #1,AA_SALVATAGGI
   151=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\ATTIVITA_PIANIFICATE\   #1,GE_Analisi_Attivita.mdb
   152=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\   #03,ATTIVITA_PIANIFICATE
   153=C:\CASA\LINGUAGGI\DOS\ #4,DOS_PROGETTI
   154=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\   #3,ATTIVITA_PIANIFICATE
   155=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\ATTIVITA_PIANIFICATE\   #1,Lista_Attivita_Pianificate.txt
   156=C:\CASA\LINGUAGGI\DOS\COMANDI_DOS\ #0
   157=C:\CASA\LINGUAGGI\DOS\ #02,COMANDI_DOS
   158=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\   #05,COMPRESSIONE_CARTELLE
   159=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\COMPRESSIONE_CARTELLE\  #1,DOS_FOR_N02_00_TOKEN_(Prova).bat
   160=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\BROWSER\ #02,Browser.zip
   161=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\   #04,BROWSER
   162=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\ATTIVITA_PIANIFICATE\   #0
   163=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\APRI_FILE\  #01,APRI_FILE.md
   164=C:\CASA\LINGUAGGI\DOS\DOS_PROGETTI\   #02,APRI_FILE
   165=C:\CASA\LINGUAGGI\DOS\DATE_DOS\ #0
   166=C:\CASA\LINGUAGGI\DOS\ #03,DATE_DOS
   167=C:\TMP\ #6,2026_05_07_ENI_GASA_(2619492663)_(Marino)_0,00.pdf
   168=C:\  #010,TMP
   169=C:\Gestioni\  #0
   170=c:\Casa\
   171=C:\Gestioni\
   172=C:\  #016,TMP
   173=C:\CASA\   #0
   174=c:\Casa\CDM\LeTorri\2023\ASSEMBLEA_ORDINARIA\2023_06_09\CONSUNTIVO_2021_PAGLIUCA\
   175=c:\Casa\CDM\LeTorri\2023\ASSEMBLEA_ORDINARIA\2023_06_09\   #6,CONSUNTIVO_2021_PAGLIUCA
   176=c:\Casa\CDM\LeTorri\2023\ASSEMBLEA_ORDINARIA\  #01,2023_06_09
   177=c:\Casa\CDM\LeTorri\2023\ #5,ASSEMBLEA_ORDINARIA
   178=c:\Casa\CDM\LeTorri\   #015,2023
   179=c:\Casa\CDM\  #04,LeTorri
   180=c:\Casa\CDM\LeTorri\   #016,2026
   181=c:\Casa\CDM\LeTorri\2026\ #01,2026_03_12_SICUREZZA_ANTINCENDIO
   182=c:\Casa\CDM\LeTorri\2026\2026_05_08_ASSEMBLEA_ORDINARIA\   #01,Invio Bilanci Le Torri 20260426
   183=c:\Casa\CDM\LeTorri\2026\2026_05_08_ASSEMBLEA_ORDINARIA\Invio Bilanci Le Torri 20260426\ #6,008.1 LE TORRI - Prospetto rate per anagrafica Gestione 2026_signed.pdf
   184=c:\Casa\CDM\LeTorri\2026\ #02,2026_05_08_ASSEMBLEA_ORDINARIA
   185=c:\Casa\CDM\LeTorri\2026\2026_05_08_ASSEMBLEA_ORDINARIA\Invio Bilanci Le Torri 20260426\ #2,007 LE TORRI - Preventivo ripartizioni per unità 2026_signed.pdf
   186=c:\Casa\CDM\LeTorri\2026\2026_05_08_ASSEMBLEA_ORDINARIA\   #1,Invio Bilanci Le Torri 20260426
   187=c:\Casa\CDM\LeTorri\2026\2026_05_08_ASSEMBLEA_ORDINARIA\   #02,2026_05_08_VERBALE_ASSEMBLEA_ORDINARIA.odt
   188=C:\  #13,TMP
   189=C:\  #013,TMP
   190=C:\TMP\ #1,2026_03_19_COMMERCIALISTI_RINNOVO_2026_(400,00).pdf
   191=C:\TMP\ #1,03_Rampa+fogneGarage_01.tif
   192=c:\Casa\GE_CASA\GE_MARINO\BANCA\POCKET_OPTION\
   193=c:\Casa\GE_CASA\GE_MARINO\BANCA\   #04,POCKET_OPTION
   194=c:\Casa\GE_CASA\GE_MARINO\   #1,BANCA
   195=c:\Casa\GE_CASA\ #02,GE_MARINO
   196=c:\Casa\   #2,GE_CASA
   [LeftHistory]
   0=C:\ #0
   1=C:\Users\ #04,icivi
   2=C:\Users\icivi\ #6,AppData
   3=C:\Users\icivi\AppData\  #03,Roaming
   4=C:\Users\icivi\AppData\Roaming\   #013,Microsoft
   5=C:\Users\icivi\AppData\Roaming\Microsoft\  #01,Access
   6=C:\Users\icivi\AppData\Roaming\Microsoft\Access\ #0
   7=C:\Users\icivi\AppData\Roaming\Microsoft\  #1,Access
   8=C:\Users\icivi\AppData\Roaming\Microsoft\Windows\   #09,Start Menu
   9=C:\Users\icivi\AppData\Roaming\Microsoft\Windows\Start Menu\ #02,Programs
   10=C:\Users\icivi\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\
   11=C:\Users\icivi\   #05,Menu Avvio
   12=C:\Users\icivi\Videos\  #01,Captures
   13=C:\Users\icivi\Videos\Captures\  #0
   14=C:\Users\icivi\Videos\Registrazioni dello schermo\
   15=C:\Users\icivi\Videos\  #02,Registrazioni dello schermo
   16=C:\Users\icivi\   #5,Videos
   17=C:\Users\icivi\AppData\ #01,Local
   18=C:\Users\icivi\AppData\Local\ #15,Temporary Internet Files
   19=C:\Users\icivi\AppData\Local\HTML_MULTIPROGETTO_WEB2\ #01,WebView2Cache
   20=C:\Users\icivi\AppData\Local\HTML_MULTIPROGETTO_WEB2\WebView2Cache\  #01,EBWebView
   21=C:\Users\icivi\AppData\Local\HTML_MULTIPROGETTO_WEB2\WebView2Cache\EBWebView\ #0
   22=C:\Users\icivi\AppData\Local\ #10,HTML_MULTIPROGETTO_WEB2
   23=C:\Users\icivi\AppData\Local\Microsoft\   #016,Vault
   24=C:\Users\icivi\AppData\Local\Microsoft\Vault\   #0
   25=C:\Users\icivi\AppData\Local\Microsoft\   #11,Vault
   26=C:\Users\icivi\AppData\Local\Microsoft\Edge\ #01,User Data
   27=C:\Users\icivi\AppData\Local\Microsoft\Edge\User Data\   #15,RecoveryImproved
   28=C:\Users\icivi\AppData\Local\Microsoft\   #6,Edge
   29=C:\Users\icivi\AppData\Local\Microsoft\Windows\ #6,SettingBackup
   30=C:\Users\icivi\AppData\Local\Microsoft\Windows\IECompatUaCache\   #01,Low
   31=C:\Users\icivi\AppData\Local\Microsoft\Windows\IECompatUaCache\Low\  #0
   32=C:\Users\icivi\AppData\Local\Microsoft\Windows\ #015,IECompatUaCache
   33=C:\Users\icivi\AppData\Local\Microsoft\Windows\IEDownloadHistory\ #0
   34=C:\Users\icivi\AppData\Local\Microsoft\Windows\ #015,IEDownloadHistory
   35=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\   #02,Content.MSO
   36=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\Content.MSO\   #0
   37=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\Content.Word\  #0
   38=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\   #03,Content.Word
   39=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\Low\  #02,IE
   40=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\Low\IE\  #0
   41=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\   #05,Low
   42=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\Virtualized\   #0
   43=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\   #06,Virtualized
   44=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\IE\   #0
   45=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\   #01,Content.IE5
   46=C:\Users\icivi\AppData\Local\Microsoft\Windows\ #013,Temporary Internet Files
   47=C:\Users\icivi\AppData\Local\Microsoft\Windows\WinX\  #0
   48=C:\Users\icivi\AppData\Local\Microsoft\Windows\ #12,WinX
   49=C:\Users\icivi\AppData\Local\Microsoft\Windows\0\  #0
   50=C:\Users\icivi\AppData\Local\Microsoft\Windows\ #1,0
   51=C:\Users\icivi\AppData\Local\Microsoft\Windows\Caches\   #3,cversions.3.db
   52=C:\Users\icivi\AppData\Local\Microsoft\Windows\ #07,Caches
   53=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\IE\   #01,container.dat
   54=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\   #04,IE
   55=C:\Users\icivi\AppData\Local\Microsoft\Windows\INetCache\IE\   #1,container.dat
   56=c:\Casa\
   57=c:\CASA\CDM\
   58=c:\CASA\CDM\ViaBassini\ #016,2026
   59=c:\CASA\CDM\ViaBassini\2026\  #3,VERSAMENTI
   60=c:\CASA\CDM\ViaBassini\2026\VERSAMENTI\   #3,2026_06_04_ViaBassini_ARCIERO_LUIGINA_CONSUNTIVO_2025_514,80.zip
   61=c:\CASA\CDM\ViaBassini\2026\  #03,VERSAMENTI
   62=c:\CASA\CDM\ViaBassini\2026\2025_05_19_ASSEMBLEA_ORDINARIA\ #5,2026_05_19_ViaBassini_ASSEMBLEA_ORDINARIA_Verbale Prot 10027_2026_0005ROSS...VALTER.zip
   63=c:\CASA\CDM\ViaBassini\2026\2025_05_19_ASSEMBLEA_ORDINARIA\RIPARTO_FONDO_LEGALE_MOROSITA\ #0
   64=c:\CASA\GE_CASA\
   65=c:\CASA\GE_CASA\TUTTI_SERVIZI_CASA\ #03,GE_MARINO
   66=c:\CASA\GE_CASA\TUTTI_SERVIZI_CASA\GE_MARINO\   #05,WALTER
   67=c:\CASA\GE_CASA\TUTTI_SERVIZI_CASA\GE_MARINO\WALTER\  #01,AGROTECNICI
   68=c:\CASA\GE_CASA\TUTTI_SERVIZI_CASA\GE_MARINO\WALTER\AGROTECNICI\  #0
   69=c:\CASA\GE_CASA\  #05,TUTTI_SERVIZI_CASA
   70=c:\CASA\GE_CASA\WALTER\ #08,UFFICIO
   71=c:\CASA\GE_CASA\  #06,WALTER
   72=c:\CASA\GE_CASA\GIACOMO\   #01,BANCA_ITALIA
   73=c:\CASA\GE_CASA\GIACOMO\BANCA_ITALIA\  #0
   74=c:\CASA\GE_CASA\  #03,GIACOMO
   75=c:\CASA\GE_CASA\GE_MARINO\ #01,BANCA
   76=c:\CASA\GE_CASA\GE_MARINO\BANCA\ #01,CSR
   77=c:\CASA\GE_CASA\GE_MARINO\BANCA\FINECO\   #01,ESTRATTI_CONTO
   78=c:\CASA\GE_CASA\GE_MARINO\BANCA\FINECO\ESTRATTI_CONTO\   #0
   79=c:\CASA\GE_CASA\GE_MARINO\BANCA\FINECO\FINECO_TUTORIAL\  #0
   80=c:\CASA\GE_CASA\GE_MARINO\BANCA\FINECO\   #02,FINECO_TUTORIAL
   81=c:\CASA\GE_CASA\GE_MARINO\BANCA\ #03,FINECO
   82=c:\CASA\GE_CASA\GE_MARINO\ #1,BANCA
   83=c:\CASA\GE_CASA\  #02,GE_MARINO
   84=c:\CASA\GE_CASA\TUTTI_SERVIZI_CASA\ #01,AUTOMOBILI
   85=c:\CASA\GE_CASA\TUTTI_SERVIZI_CASA\AUTOMOBILI\  #0
   86=c:\CASA\ #02,GE_CASA
   87=c:\CASA\CDM\   #0
   88=c:\CASA\ #01,CDM
   89=c:\   #00,CASA
   90=c:\TMP\
   91=c:\   #019,TMP
   92=c:\Casa\ #05,LUIGINA
   93=c:\CASA\CDM\ViaBassini\2026\VERSAMENTI\
   94=c:\CASA\CDM\ViaBassini\2026\2025_05_19_ASSEMBLEA_ORDINARIA\ #02,RIPARTO_FONDO_LEGALE_MOROSITA
   95=c:\CASA\CDM\ViaBassini\2026\2025_05_19_ASSEMBLEA_ORDINARIA\RIPARTO_FONDO_LEGALE_MOROSITA\ #1,2026_06_20_FONDO_LEGALE_boll_14061_225,50.pdf
   96=c:\CASA\CDM\ViaBassini\2026\  #01,2025_05_19_ASSEMBLEA_ORDINARIA
   97=c:\CASA\CDM\ViaBassini\2026\2025_05_19_ASSEMBLEA_ORDINARIA\ #01,DOCUMENTI_ASSEMBLEA
   98=c:\CASA\CDM\ViaBassini\2026\2025_05_19_ASSEMBLEA_ORDINARIA\ #7,2026_05_19_ViaBassini_ASSEMBLEA_ORDINARIA_Verbale Prot 10027_2026_0005ROSS...VALTER.zip
   99=c:\CASA\CDM\ViaBassini\ #8,2026
   100=c:\CASA\CDM\ViaBassini\2026\2025_05_19_ASSEMBLEA_ORDINARIA\   #2,RIPARTO_FONDO_LEGALE_MOROSITA
   101=c:\CASA\CDM\ViaBassini\2026\2025_05_19_ASSEMBLEA_ORDINARIA\RIPARTO_FONDO_LEGALE_MOROSITA\   #1,2026_06_20_FONDO_LEGALE_boll_14061.pdf
   102=c:\CASA\CDM\ViaBassini\2026\EMAIL\
   103=c:\CASA\CDM\ViaBassini\2026\ #02,EMAIL
   104=c:\CASA\CDM\ViaBassini\2026\VERSAMENTI\  #0
   105=c:\CASA\CDM\ViaBassini\   #4,2026
   106=c:\CASA\CDM\  #6,ViaBassini
   107=c:\  #3,CASA
   108=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\PETTULLI_EMILIA\IMU\2026\
   109=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\PETTULLI_EMILIA\IMU\2026\PAGATO\
   110=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\PETTULLI_EMILIA\IMU\2026\  #1,PAGATO
   111=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\PETTULLI_EMILIA\IMU\ #05,2026
   112=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\PETTULLI_EMILIA\  #01,IMU
   113=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\   #02,PETTULLI_EMILIA
   114=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\   #011,SANTA_CROCE_DI_MAGLIANO
   115=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\ #01,MATTIOLI_VITTORIO_PETTULLI_EMILIA
   116=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\   #01,IMU
   117=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\  #010,2026
   118=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\   #6,MATTIOLI_VITTORIO_REPORT_IMU_2026.pdf
   119=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\   #09,ROMA
   120=c:\CASA\   #07,TRIBUTI_LOCALI_E_SERVIZI_CASA
   121=c:\CASA\CDM\  #03,LaQuercia
   122=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_GE_FILE\MDB\
   123=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_GE_FILE\ #01,MDB
   124=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #6,MSys_GE_FILE
   125=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\   #04,MDB
   126=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\  #02,MSYS
   127=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\   #08,MSYS_OGGETTI
   128=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\GESTIONE_OGGETTI\ #02,MDB
   129=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\GESTIONE_OGGETTI\MDB\   #0
   130=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\   #07,GESTIONE_OGGETTI
   131=c:\CASA\LINGUAGGI\ACCESS\ #05,PROGETTI_MDB
   132=c:\CASA\LINGUAGGI\  #02,ACCESS
   133=c:\CASA\   #03,LINGUAGGI
   134=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\PETTULLI_EMILIA\IMU\2025\  #2,IMU_SANTACROCE_DI_MAGLIANO_2025_01_PETTULLI_EMILIA_(IMM)_AMM_COMUNALI.amn
   135=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\PETTULLI_EMILIA\IMU\ #4,2025
   136=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\PETTULLI_EMILIA\IMU\2025\  #0
   137=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\PETTULLI_EMILIA\IMU\ #04,2025
   138=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\CERRETO_DI_SPOLETO\  #01,MATTIOLI_VITTORIO
   139=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\CERRETO_DI_SPOLETO\MATTIOLI_VITTORIO\  #01,IMU
   140=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\CERRETO_DI_SPOLETO\MATTIOLI_VITTORIO\IMU\ #06,2023
   141=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\   #03,CERRETO_DI_SPOLETO
   142=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\   #01,MATTIOLI_VITTORIO
   143=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\MATTIOLI_VITTORIO\   #01,IMU
   144=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\SANTA_CROCE_DI_MAGLIANO\MATTIOLI_VITTORIO\IMU\  #0
   145=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2026\   #2,PETTULLI_EMILIA_F24_SALDO_IMU_2026.pdf
   146=c:\CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\   #9,ROMA
   147=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\
   148=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #0
   149=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\  #5,OBJECT
   150=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\OBJECT\ #01,MODULES
   151=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\OBJECT\MODULES\  #0
   152=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\  #05,OBJECT
   153=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\LOGS\
   154=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\  #03,LOGS
   155=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\HELP\   #0
   156=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\  #02,HELP
   157=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #016,MSys_TB99_LINK
   158=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\  #04,MDB
   159=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\MDB\ #1,LOGS
   160=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\  #4,MDB
   161=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #013,MSys_TB99_LINK
   162=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\TAB_CONTROL\  #0
   163=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #011,TAB_CONTROL
   164=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\   #4,MDB
   165=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\HELP\   #01,Msys_GEFILE_FrmM01_GE_SERVIZI_TB99_LINK
   166=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB99_LINK\HELP\Msys_GEFILE_FrmM01_GE_SERVIZI_TB99_LINK\  #0
   167=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB03_ELENCO_OGGETTI\MDB\
   168=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB03_ELENCO_OGGETTI\ #02,MDB
   169=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB03_ELENCO_OGGETTI\HELP\  #0
   170=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB03_ELENCO_OGGETTI\ #01,HELP
   171=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #014,MSys_TB03_ELENCO_OGGETTI
   172=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #19,MSys_TB03_ELENCO_OGGETTI\HELP\FORM\PROGETTI_Msys_TB02Frm01_01_TIPO_OGGETTI\HELP_PROGETTI_Msys_TB02Frm01_01_TIPO_OGGETTI.html
   173=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #016,MSys_TB03_ELENCO_OGGETTI
   174=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB03_ELENCO_OGGETTI\ #0
   175=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #017,MSys_TB03_ELENCO_OGGETTI
   176=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB02_TIPO_OGGETTI\   #0
   177=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #014,MSys_TB02_TIPO_OGGETTI
   178=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB01_PROGETTI\ #02,OBJECT
   179=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB01_PROGETTI\OBJECT\   #0
   180=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB01_PROGETTI\MDB\   #0
   181=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB01_PROGETTI\ #1,MDB
   182=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\  #016,MSys_TB01_PROGETTI
   183=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB01_PROGETTI\ #2,OBJECT
   184=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB01_PROGETTI\ #01,MDB
   [lefttabs]
   0_path=c:\
   0_options=1|1|0|0|0|2|0|
   1_path=c:\Casa\CDM\LeTorri\
   1_options=1|0|1|0|0|1|0|
   2_path=c:\Gestioni\TRIBUTI\TT_FILE\
   2_options=1|1|0|0|0|2|0|
   3_path=c:\Gestioni\TRIBUTI\TT_ARCH\
   3_options=1|1|0|0|0|2|0|
   4_path=c:\Gestioni\
   4_options=1|0|1|0|0|2|0|
   5_path=c:\Gestioni\GeTributi\GeTributi\TributiArchivi\
   5_options=1|0|0|0|0|2|0|
   6_path=c:\Casa\LTT\
   6_options=1|0|0|0|0|2|0|
   7_path=c:\Casa\CDM\LaQuercia\
   7_options=1|0|0|0|0|2|0|
   8_path=c:\Casa\CDM\
   8_options=1|4|1|0|0|1|0|
   9_path=c:\CASA\GE_CASA\TUTTI_SERVIZI_CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2025\
   9_options=1|0|0|0|0|0|0|
   10_path=c:\CASA\LINGUAGGI\RUST\RUST_PURO_COMMAND_DOS\cmd_menu\src\
   10_options=1|0|0|0|0|0|0|
   11_path=c:\CASA\GE_CASA\TUTTI_SERVIZI_CASA\TRIBUTI_LOCALI_E_SERVIZI_CASA\ROMA\MATTIOLI_VITTORIO_PETTULLI_EMILIA\IMU\2025\
   11_options=1|0|0|0|0|0|0|
   12_path=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSYS_ATTIVA_GEST_OGGETTI\MDB\
   12_options=1|0|0|0|0|0|0|
   13_path=c:\Casa\LINGUAGGI\
   13_options=1|0|0|0|0|0|0|
   14_path=c:\CASA\GE_CASA\
   14_options=1|0|0|0|0|0|0|
   15_path=c:\Casa\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_ESPORTA_IMPORTA\MDB\
   15_options=1|0|0|0|0|0|0|
   activetab=1
   activelocked=2
   [righttabs]
   0_path=c:\Casa\CDM\ViaBassini\
   0_options=1|0|0|0|0|2|0|
   1_path=c:\Casa\Pres3000\
   1_options=1|0|0|0|0|2|0|
   2_path=Y:\Valter\
   2_options=1|0|0|0|0|2|0|
   3_path=c:\Casa\LINGUAGGI\DOS\DOS_PROGETTI\CRIPTA_SHA256\
   3_options=1|0|1|0|0|0|0|
   4_path=c:\Casa\CDM\
   4_options=1|0|0|0|0|2|0|
   5_path=c:\Gestioni\LavoriPubblici\GestioneLpp\
   5_options=1|0|0|0|0|1|0|
   6_path=c:\CASA\LINGUAGGI\DOS\
   6_options=1|0|0|0|0|1|0|
   7_path=Y:\GIOVANNI\Scanner\
   7_options=1|3|1|0|0|1|0|
   8_path=C:\Gestioni\
   8_options=1|3|1|0|0|2|0|
   9_path=c:\Gestioni\LavoriPubblici\
   9_options=1|0|0|0|0|1|0|
   10_path=C:\TMP\
   10_options=1|3|1|0|0|1|0|
   11_path=f:\
   11_options=1|0|0|0|0|0|0|
   12_path=c:\Casa\CDM\ViaLiguriaGuidonia\
   12_options=1|0|0|0|0|0|0|
   13_path=c:\Casa\LINGUAGGI\HTML\HTML_PROGETTI\
   13_options=1|0|0|0|0|0|0|
   14_path=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\
   14_options=1|0|0|0|0|0|0|
   15_path=f:\CASA\CDM\ViaLiguriaGuidonia\CRONOLOGICO\
   15_options=1|0|1|0|0|0|0|
   16_path=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_TB01_PROGETTI\
   16_options=1|0|0|0|0|0|0|
   17_path=c:\CASA\LINGUAGGI\ACCESS\PROGETTI_MDB\MSYS_OGGETTI\MSYS\MDB\MSys_DF02\
   17_options=1|0|0|0|0|0|0|
   18_path=c:\Casa\GE_CASA\GE_MARINO\BANCA\POCKET_OPTION\
   18_options=1|0|1|0|0|0|0|
   19_path=c:\GESTIONI\GESTIONE_LLPP\25_GESTIONE_LLPP\LLPP_ATTI_TB05_PER_ISTRUTTORE\MDB\
   19_options=1|3|1|0|0|0|0|
   activetab=0
   activelocked=2
