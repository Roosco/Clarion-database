   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE

   MAP
     MODULE('APLIKACIJA_BC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('APLIKACIJA001.CLW')
Main                   PROCEDURE   !Glavni prozor
     END
   END

SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

!region File Declaration
MUSIC                FILE,DRIVER('TOPSPEED'),PRE(MSC),CREATE,BINDABLE,THREAD !                    
PK_Music_SifraPjesme     KEY(MSC:Sifra_pjesme),NOCASE,PRIMARY !                    
Record                   RECORD,PRE()
Sifra_pjesme                LONG                           !                    
Naziv_pjesme                CSTRING(21)                    !                    
Format_pjesme               CSTRING(6)                     !                    
Velicina_pjesme             CSTRING(20)                    !                    
Datum_kreiranja             DATE                           !                    
Bitrate                     STRING(20)                     !                    
Trajanje                    CSTRING(20)                    !                    
                         END
                     END                       

IMA_M                FILE,DRIVER('TOPSPEED'),PRE(IMA_M),CREATE,BINDABLE,THREAD !                    
PK_ImaM_SifraMobitela_SifraPjesme KEY(IMA_M:Sifra_mobitela,IMA_M:Sifra_pjesme),NOCASE,PRIMARY !                    
K_ImaM_SifraPjesme_SifraMobitela KEY(IMA_M:Sifra_pjesme,IMA_M:Sifra_mobitela),NOCASE !                    
Record                   RECORD,PRE()
Sifra_pjesme                LONG                           !                    
Sifra_mobitela              SHORT                          !                    
Download_sa                 CSTRING(21)                    !                    
Cijena_downloada            DECIMAL(7,2)                   !                    
Popust                      SHORT                          !                    
Cijena_s_popustom           DECIMAL(7,2)                   !                    
                         END
                     END                       

SDCard               FILE,DRIVER('TOPSPEED'),PRE(SDC),CREATE,BINDABLE,THREAD !                    
SK_SDCard_NazivKartice   KEY(SDC:Naziv_kartice),DUP,NOCASE !                    
SK_SDCard_FormatKartice  KEY(SDC:Format),DUP,NOCASE        !                    
SK_SDCard_Klasa          KEY(SDC:Klasa),DUP,NOCASE         !                    
SK_SDCard_Kapacitet      KEY(SDC:Kapacitet),DUP,NOCASE     !                    
PK_SDCard_SifraKartice   KEY(SDC:Sifra_kartice),NOCASE,PRIMARY !                    
Record                   RECORD,PRE()
Sifra_kartice               LONG                           !                    
Naziv_kartice               CSTRING(21)                    !                    
Kapacitet                   CSTRING(20)                    !                    
Format                      CSTRING(6)                     !                    
Klasa                       STRING(3)                      !                    
                         END
                     END                       

PHONE                FILE,DRIVER('TOPSPEED'),PRE(PHN),CREATE,BINDABLE,THREAD !                    
PK_Phone_SifraMobitela   KEY(PHN:Sifra_mobitela),NOCASE,PRIMARY !                    
VK_Phone_SifraKartice    KEY(PHN:Sifra_kartice),DUP,NOCASE !                    
Record                   RECORD,PRE()
Sifra_mobitela              SHORT                          !                    
Naziv_mobitela              CSTRING(21)                    !                    
Velicina_ekrana             CSTRING(21)                    !                    
Rezolucija                  CSTRING(11)                    !                    
OS                          CSTRING(26)                    !                    
Memorija                    CSTRING(20)                    !                    
Baterija                    CSTRING(16)                    !                    
Kolicina_glazbe             SHORT                          !                    
Kolicina_slika              SHORT                          !                    
Kolicina_videa              SHORT                          !                    
Sifra_kartice               LONG                           !                    
                         END
                     END                       

IMA_P                FILE,DRIVER('TOPSPEED'),PRE(IMA_P),CREATE,BINDABLE,THREAD !                    
PK_ImaP_SifraMobitela_SifraSlike KEY(IMA_P:Sifra_mobitela,IMA_P:Sifra_slike),NOCASE,PRIMARY !                    
K_ImaP_SifraSlike_SifraMobitela KEY(IMA_P:Sifra_slike,IMA_P:Sifra_mobitela),NOCASE !                    
Record                   RECORD,PRE()
Sifra_mobitela              SHORT                          !                    
Sifra_slike                 SHORT                          !                    
                         END
                     END                       

IMA_V                FILE,DRIVER('TOPSPEED'),PRE(IMA_V),CREATE,BINDABLE,THREAD !                    
PK_ImaV_SifraMobitela_SifraVidea KEY(IMA_V:Sifra_mobitela,IMA_V:Sifra_videa),NOCASE,PRIMARY !                    
K_ImaV_SifraVidea_SifraMobitela KEY(IMA_V:Sifra_videa,IMA_V:Sifra_mobitela),NOCASE !                    
Record                   RECORD,PRE()
Sifra_mobitela              SHORT                          !                    
Sifra_videa                 LONG                           !                    
                         END
                     END                       

PICTURES             FILE,DRIVER('TOPSPEED'),PRE(PIC),CREATE,BINDABLE,THREAD !                    
PK_Pictures_SifraSlike   KEY(PIC:Sifra_slike),NOCASE,PRIMARY !                    
Record                   RECORD,PRE()
Sifra_slike                 SHORT                          !                    
Naziv_slike                 CSTRING(21)                    !                    
Format_slike                CSTRING(20)                    !                    
Velicina_slike              STRING(20)                     !                    
Rezolucija                  CSTRING(11)                    !                    
Datum_kreiranja             DATE                           !                    
                         END
                     END                       

VIDEOS               FILE,DRIVER('TOPSPEED'),PRE(VID),CREATE,BINDABLE,THREAD !                    
PK_Videos_SifraVidea     KEY(VID:Sifra_videa),NOCASE,PRIMARY !                    
Record                   RECORD,PRE()
Sifra_videa                 LONG                           !                    
Naziv_videa                 CSTRING(21)                    !                    
Format_videa                CSTRING(20)                    !                    
Velicina_videa              STRING(20)                     !                    
Rezolucija                  CSTRING(11)                    !                    
Trajanje                    TIME                           !                    
Framerate                   STRING(20)                     !                    
Datum_kreiranja             DATE                           !                    
Film                        CSTRING(20)                    !                    
                         END
                     END                       

!endregion

Access:MUSIC         &FileManager,THREAD                   ! FileManager for MUSIC
Relate:MUSIC         &RelationManager,THREAD               ! RelationManager for MUSIC
Access:IMA_M         &FileManager,THREAD                   ! FileManager for IMA_M
Relate:IMA_M         &RelationManager,THREAD               ! RelationManager for IMA_M
Access:SDCard        &FileManager,THREAD                   ! FileManager for SDCard
Relate:SDCard        &RelationManager,THREAD               ! RelationManager for SDCard
Access:PHONE         &FileManager,THREAD                   ! FileManager for PHONE
Relate:PHONE         &RelationManager,THREAD               ! RelationManager for PHONE
Access:IMA_P         &FileManager,THREAD                   ! FileManager for IMA_P
Relate:IMA_P         &RelationManager,THREAD               ! RelationManager for IMA_P
Access:IMA_V         &FileManager,THREAD                   ! FileManager for IMA_V
Relate:IMA_V         &RelationManager,THREAD               ! RelationManager for IMA_V
Access:PICTURES      &FileManager,THREAD                   ! FileManager for PICTURES
Relate:PICTURES      &RelationManager,THREAD               ! RelationManager for PICTURES
Access:VIDEOS        &FileManager,THREAD                   ! FileManager for VIDEOS
Relate:VIDEOS        &RelationManager,THREAD               ! RelationManager for VIDEOS

FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
GlobalErrorStatus    ErrorStatusClass,THREAD
GlobalErrors         ErrorClass                            ! Global error manager
INIMgr               INIClass                              ! Global non-volatile storage manager
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END


  CODE
  GlobalErrors.Init(GlobalErrorStatus)
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  INIMgr.Init('.\Aplikacija.INI', NVD_INI)                 ! Configure INIManager to use INI file
  DctInit
  Main
  INIMgr.Update
  INIMgr.Kill                                              ! Destroy INI manager
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher


Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

