

   MEMBER('Aplikacija.clw')                                ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('APLIKACIJA002.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('APLIKACIJA001.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Form
!!! Azuriranje kartica
!!! </summary>
AzuriranjeKartica PROCEDURE 

ActionMessage        CSTRING(40)                           !
History::SDC:Record  LIKE(SDC:RECORD),THREAD
FormWindow           WINDOW('Azuriranje kartica...'),AT(,,128,136),CENTER,ICON('Slike\Sycamoreent-Storage-Sd.ico'), |
  GRAY,MDI,SYSTEM,IMM
                       PROMPT('Sifra kartice:'),AT(20,7,,11),USE(?SDC:Sifra_kartice:Prompt)
                       ENTRY(@N3),AT(66,7,22,10),USE(SDC:Sifra_kartice),RIGHT(1),REQ
                       PROMPT('Naziv kartice:'),AT(16,22,,11),USE(?SDC:Naziv_kartice:Prompt)
                       TEXT,AT(66,22,54,10),USE(SDC:Naziv_kartice,,?SDC:Naziv_kartice:2)
                       PROMPT('Kapacitet:'),AT(28,36,,11),USE(?SDC:Kapacitet:Prompt)
                       ENTRY(@P<#GBP),AT(66,36,27,10),USE(SDC:Kapacitet),REQ
                       OPTION('Format:'),AT(3,50,55,50),USE(SDC:Format),BOXED
                         RADIO('NTFS'),AT(13,63),USE(?SDC:Format:Radio1),VALUE('NTFS')
                         RADIO('FAT32'),AT(13,76),USE(?SDC:Format:Radio2),VALUE('FAT32')
                       END
                       OPTION('Klasa:'),AT(66,50,55,50),USE(SDC:Klasa),BOXED
                         RADIO('4'),AT(78,63),USE(?SDC:Klasa:Radio1),VALUE('4')
                         RADIO('10'),AT(78,76),USE(?SDC:Klasa:Radio2),VALUE('10')
                       END
                       STRING(@S40),AT(37,104,84),USE(ActionMessage)
                       BUTTON('Spremi'),AT(37,117,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Izlaz'),AT(81,117,40,12),USE(?Cancel)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'Pregled zapisa'
  OF InsertRecord
    ActionMessage = 'Zapis ce biti spremljen'
  OF ChangeRecord
    ActionMessage = 'Zapis ce biti izmijenjen'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeKartica')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?SDC:Sifra_kartice:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(SDC:Record,History::SDC:Record)
  SELF.AddHistoryField(?SDC:Sifra_kartice,1)
  SELF.AddHistoryField(?SDC:Naziv_kartice:2,2)
  SELF.AddHistoryField(?SDC:Kapacitet,3)
  SELF.AddHistoryField(?SDC:Format,4)
  SELF.AddHistoryField(?SDC:Klasa,5)
  SELF.AddUpdateFile(Access:SDCard)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:SDCard.Open                                       ! File SDCard used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:SDCard
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeKartica',FormWindow)             ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:SDCard.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeKartica',FormWindow)          ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! Azuriranje ImaM
!!! </summary>
AzuriranjeImaM PROCEDURE 

ActionMessage        CSTRING(40)                           !
History::IMA_M:Record LIKE(IMA_M:RECORD),THREAD
FormWindow           WINDOW('Pridruzivanje muzike mobitelu...'),AT(,,143,121),CENTER,ICON('Slike\Vargas21-Aq' & |
  'uave-Metal-Music.ico'),GRAY,MDI,SYSTEM,IMM
                       ENTRY(@s20),AT(73,24,60,10),USE(IMA_M:Download_sa),CAP
                       PROMPT('Sifra pjesme:'),AT(23,8),USE(?IMA_M:Sifra_pjesme:Prompt)
                       PROMPT('Download s:'),AT(25,24),USE(?IMA_M:Download_s:Prompt)
                       ENTRY(@N3),AT(73,8,18,10),USE(IMA_M:Sifra_pjesme),RIGHT(1)
                       PROMPT('Cijena downloada:'),AT(7,40),USE(?IMA_M:Cijena_downloada:Prompt)
                       ENTRY(@n7.2),AT(73,41,60,10),USE(IMA_M:Cijena_downloada),DECIMAL(12)
                       PROMPT('Popust:'),AT(40,57),USE(?IMA_M:Popust:Prompt)
                       ENTRY(@n3),AT(73,58,18,10),USE(IMA_M:Popust),RIGHT(1)
                       STRING('%'),AT(94,57,20,11),USE(?STRING1)
                       PROMPT('Cijena s popustom:'),AT(5,74),USE(?IMA_M:Cijena_s_popustom:Prompt)
                       ENTRY(@N7.2),AT(73,74,60,10),USE(IMA_M:Cijena_s_popustom),DECIMAL(12)
                       STRING(@S40),AT(14,88),USE(ActionMessage)
                       BUTTON('Spremi'),AT(48,101,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Izlaz'),AT(94,101,40,12),USE(?Cancel)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'Pregled zapisa'
  OF InsertRecord
    ActionMessage = 'Zapis ce biti spremljen'
  OF ChangeRecord
    ActionMessage = 'Zapis ce biti izmijenjen'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeImaM')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?IMA_M:Download_sa
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(IMA_M:Record,History::IMA_M:Record)
  SELF.AddHistoryField(?IMA_M:Sifra_pjesme,1)
  SELF.AddHistoryField(?IMA_M:Cijena_downloada,4)
  SELF.AddHistoryField(?IMA_M:Popust,5)
  SELF.AddHistoryField(?IMA_M:Cijena_s_popustom,6)
  SELF.AddUpdateFile(Access:IMA_M)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:IMA_M.SetOpenRelated()
  Relate:IMA_M.Open                                        ! File IMA_M used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:IMA_M
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeImaM',FormWindow)                ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:IMA_M.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeImaM',FormWindow)             ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  MSC:Sifra_pjesme = IMA_M:Sifra_pjesme                    ! Assign linking field value
  Access:MUSIC.Fetch(MSC:PK_Music_SifraPjesme)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PopisMuzike
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?IMA_M:Sifra_pjesme
      IF Access:IMA_M.TryValidateField(1)                  ! Attempt to validate IMA_M:Sifra_pjesme in IMA_M
        SELECT(?IMA_M:Sifra_pjesme)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?IMA_M:Sifra_pjesme
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?IMA_M:Sifra_pjesme{PROP:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE FIELD()
    OF ?IMA_M:Cijena_s_popustom
      IMA_M:Cijena_s_popustom=IMA_M:Cijena_downloada-(IMA_M:Cijena_downloada*(IMA_M:Popust/100))
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?IMA_M:Sifra_pjesme
      MSC:Sifra_pjesme = IMA_M:Sifra_pjesme
      IF Access:MUSIC.TryFetch(MSC:PK_Music_SifraPjesme)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          IMA_M:Sifra_pjesme = MSC:Sifra_pjesme
        END
      END
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! Azuriranje ImaP
!!! </summary>
AzuriranjeImaP PROCEDURE 

ActionMessage        CSTRING(40)                           !
History::IMA_P:Record LIKE(IMA_P:RECORD),THREAD
FormWindow           WINDOW('Pridruzivanje slika mobitelu...'),AT(,,112,52),CENTER,ICON('Slike\Vargas21-Aqua' & |
  've-Metal-Photos.ico'),GRAY,MDI,SYSTEM,IMM
                       BUTTON('Spremi'),AT(18,34,40,12),USE(?OK),DEFAULT,REQ
                       PROMPT('Sifra slike:'),AT(16,8),USE(?IMA_P:Sifra_slike:Prompt)
                       ENTRY(@N3),AT(60,8,42,10),USE(IMA_P:Sifra_slike),RIGHT(1)
                       STRING(@S40),AT(10,22,92),USE(ActionMessage)
                       BUTTON('Izlaz'),AT(62,34,40,12),USE(?Cancel)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'Pregled zapisa'
  OF InsertRecord
    ActionMessage = 'Zapis ce biti spremljen'
  OF ChangeRecord
    ActionMessage = 'Zapis ce biti izmijenjen'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeImaP')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(IMA_P:Record,History::IMA_P:Record)
  SELF.AddHistoryField(?IMA_P:Sifra_slike,2)
  SELF.AddUpdateFile(Access:IMA_P)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:IMA_P.Open                                        ! File IMA_P used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:IMA_P
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeImaP',FormWindow)                ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:IMA_P.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeImaP',FormWindow)             ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  PIC:Sifra_slike = IMA_P:Sifra_slike                      ! Assign linking field value
  Access:PICTURES.Fetch(PIC:PK_Pictures_SifraSlike)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PopisSlika
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    OF ?IMA_P:Sifra_slike
      IF Access:IMA_P.TryValidateField(2)                  ! Attempt to validate IMA_P:Sifra_slike in IMA_P
        SELECT(?IMA_P:Sifra_slike)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?IMA_P:Sifra_slike
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?IMA_P:Sifra_slike{PROP:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?IMA_P:Sifra_slike
      PIC:Sifra_slike = IMA_P:Sifra_slike
      IF Access:PICTURES.TryFetch(PIC:PK_Pictures_SifraSlike)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          IMA_P:Sifra_slike = PIC:Sifra_slike
        END
      END
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! Azuriranje ImaV
!!! </summary>
AzuriranjeImaV PROCEDURE 

ActionMessage        CSTRING(40)                           !
History::IMA_V:Record LIKE(IMA_V:RECORD),THREAD
FormWindow           WINDOW('Pridruzivanje videa mobitelu...'),AT(,,124,54),CENTER,ICON('Slike\Vargas21-Aqua' & |
  've-Metal-Movies.ico'),GRAY,MDI,SYSTEM,IMM
                       BUTTON('Spremi'),AT(26,34,40,12),USE(?OK),DEFAULT,REQ
                       PROMPT('Sifra videa:'),AT(8,8,,11),USE(?IMA_V:Sifra_videa:Prompt)
                       ENTRY(@N4),AT(50,8,60,10),USE(IMA_V:Sifra_videa),RIGHT(1)
                       STRING(@S40),AT(13,22,98),USE(ActionMessage)
                       BUTTON('Izlaz'),AT(70,34,40,12),USE(?Cancel)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'Pregled zapisa'
  OF InsertRecord
    ActionMessage = 'Zapis ce biti spremljen'
  OF ChangeRecord
    ActionMessage = 'Zapis ce biti izmijenjen'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeImaV')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(IMA_V:Record,History::IMA_V:Record)
  SELF.AddHistoryField(?IMA_V:Sifra_videa,2)
  SELF.AddUpdateFile(Access:IMA_V)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:IMA_V.Open                                        ! File IMA_V used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:IMA_V
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeImaV',FormWindow)                ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:IMA_V.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeImaV',FormWindow)             ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  VID:Sifra_videa = IMA_V:Sifra_videa                      ! Assign linking field value
  Access:VIDEOS.Fetch(VID:PK_Videos_SifraVidea)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PopisVidea
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    OF ?IMA_V:Sifra_videa
      IF Access:IMA_V.TryValidateField(2)                  ! Attempt to validate IMA_V:Sifra_videa in IMA_V
        SELECT(?IMA_V:Sifra_videa)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?IMA_V:Sifra_videa
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?IMA_V:Sifra_videa{PROP:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?IMA_V:Sifra_videa
      VID:Sifra_videa = IMA_V:Sifra_videa
      IF Access:VIDEOS.TryFetch(VID:PK_Videos_SifraVidea)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          IMA_V:Sifra_videa = VID:Sifra_videa
        END
      END
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Report
!!! Ispis slika - jednostavno izvjesce - 1 slika na stranicu
!!! </summary>
IspisSlika2 PROCEDURE 

Progress:Thermometer BYTE                                  !
Process:View         VIEW(PICTURES)
                       PROJECT(PIC:Datum_kreiranja)
                       PROJECT(PIC:Format_slike)
                       PROJECT(PIC:Naziv_slike)
                       PROJECT(PIC:Rezolucija)
                       PROJECT(PIC:Sifra_slike)
                       PROJECT(PIC:Velicina_slike)
                     END
ReportPageNumber     LONG,AUTO
ProgressWindow       WINDOW('Progress...'),AT(,,142,59),DOUBLE,VSCROLL,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

Report               REPORT,AT(1000,2000,6250,7688),PRE(RPT),PAPER(PAPER:A4),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(1000,1000,6250,1542),USE(?Header)
                         STRING('POPIS SLIKA'),AT(167,135,2562),USE(?STRING1),FONT(,20,,,CHARSET:EASTEUROPE)
                         STRING('Datum kreiranja:'),AT(167,562),USE(?ReportDatePrompt),TRN
                         STRING('<<-- Date Stamp -->'),AT(1229,562),USE(?ReportDateStamp),TRN
                         IMAGE('Slike\pic.png'),AT(4792,135,1292,1135),USE(?IMAGE1)
                       END
BreakPicsSifraSlike    BREAK(PIC:Sifra_slike),USE(?BREAK1)
                         HEADER,AT(0,0,6250,1000),USE(?GROUPHEADER1),PAGEBEFORE(1)
                           STRING('#Slike'),AT(208,417,562),USE(?STRING2)
                           STRING('Naziv'),AT(833,417,656),USE(?STRING3)
                           STRING('Format'),AT(2427,417,531),USE(?STRING4)
                           STRING('Velicina'),AT(3094,417,656),USE(?STRING5)
                           IMAGE('Slike\bannerdesign1.jpg'),AT(167,677,5917,146),USE(?IMAGE3)
                           STRING('Rezolucija'),AT(3906,417,823),USE(?STRING6)
                           STRING('Datum kreiranja'),AT(4792,417,1094,198),USE(?STRING7)
                         END
Detail                   DETAIL,AT(0,0,6250,469),USE(?Detail)
                           STRING(@N3),AT(240,135),USE(PIC:Sifra_slike),LEFT(1)
                           STRING(@s20),AT(833,135),USE(PIC:Naziv_slike),LEFT
                           STRING(@s19),AT(2427,135,531),USE(PIC:Format_slike),LEFT
                           STRING(@P<<<#MBP),AT(3094,135),USE(PIC:Velicina_slike),LEFT
                           STRING(@s10),AT(3906,135),USE(PIC:Rezolucija),LEFT
                           STRING(@D6),AT(4792,135),USE(PIC:Datum_kreiranja),LEFT(12)
                         END
                       END
                       FOOTER,AT(1000,9688,6250,312),USE(?Footer)
                         STRING(@N3),AT(2948,31),USE(ReportPageNumber)
                       END
                       FORM,AT(1000,1000,6250,9688),USE(?Form)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepLongClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('IspisSlika2')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:PICTURES.Open                                     ! File PICTURES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IspisSlika2',ProgressWindow)               ! Restore window settings from non-volatile store
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:PICTURES, ?Progress:PctText, Progress:Thermometer, ProgressMgr, PIC:Sifra_slike)
  ThisReport.AddSortOrder(PIC:PK_Pictures_SifraSlike)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:PICTURES.SetQuickScan(1,Propagate:OneMany)
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:PICTURES.Close
  END
  IF SELF.Opened
    INIMgr.Update('IspisSlika2',ProgressWindow)            ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp{PROP:Text} = FORMAT(TODAY(),@D17)
  END
  IF ReturnValue = Level:Benign
    Report$?ReportPageNumber{PROP:PageNo} = True
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Report
!!! Ispis slika - jednostavno izvjesce na gumb
!!! </summary>
StavkeOdabraneSlike PROCEDURE 

Progress:Thermometer BYTE                                  !
Process:View         VIEW(PICTURES)
                       PROJECT(PIC:Datum_kreiranja)
                       PROJECT(PIC:Format_slike)
                       PROJECT(PIC:Naziv_slike)
                       PROJECT(PIC:Rezolucija)
                       PROJECT(PIC:Sifra_slike)
                       PROJECT(PIC:Velicina_slike)
                     END
ReportPageNumber     LONG,AUTO
ProgressWindow       WINDOW('Progress...'),AT(,,142,59),DOUBLE,VSCROLL,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

Report               REPORT,AT(1000,2000,6250,7688),PRE(RPT),PAPER(PAPER:A4),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(1000,1000,6250,1521),USE(?Header)
                         STRING('OPIS ODABRANE SLIKE'),AT(167,135),USE(?STRING1),FONT(,20,,,CHARSET:EASTEUROPE)
                         STRING('Datum kreiranja:'),AT(167,562),USE(?ReportDatePrompt),TRN
                         STRING('<<-- Date Stamp -->'),AT(1229,562),USE(?ReportDateStamp),TRN
                         IMAGE('Slike\pic.png'),AT(4792,135,1292,1135),USE(?IMAGE1)
                       END
break1                 BREAK(PIC:Sifra_slike),USE(?BREAK1)
                         HEADER,AT(0,0,6250,885),USE(?GROUPHEADER1)
                           STRING('#Slike'),AT(167,344,479,198),USE(?STRING2),FONT(,10,,FONT:bold,CHARSET:EASTEUROPE)
                           STRING('Naziv'),AT(760,344,406),USE(?STRING3),FONT(,10,,FONT:bold,CHARSET:EASTEUROPE)
                           STRING('Format'),AT(2344,344,552),USE(?STRING4),FONT(,10,,FONT:bold,CHARSET:EASTEUROPE)
                           STRING('Velicina'),AT(3250,344,677),USE(?STRING5),FONT(,10,,FONT:bold,CHARSET:EASTEUROPE)
                           STRING('Rezolucija'),AT(3990,344,802),USE(?STRING6),FONT(,10,,FONT:bold,CHARSET:EASTEUROPE)
                           STRING('Datum kreiranja '),AT(4969,344),USE(?STRING7),FONT(,10,,FONT:bold,CHARSET:EASTEUROPE)
                           IMAGE('Slike\bannerdesign1.jpg'),AT(167,604,5917,146),USE(?IMAGE3)
                         END
Detail                   DETAIL,AT(0,0,6250,250),USE(?Detail)
                           STRING(@N3),AT(167,42),USE(PIC:Sifra_slike),LEFT(1)
                           STRING(@s20),AT(760,42,1323),USE(PIC:Naziv_slike),LEFT
                           STRING(@s19),AT(2344,42,552),USE(PIC:Format_slike),LEFT
                           STRING(@P<<<#MBP),AT(3250,31),USE(PIC:Velicina_slike),LEFT
                           STRING(@s10),AT(3990,31),USE(PIC:Rezolucija),LEFT
                           STRING(@D6),AT(5250,31),USE(PIC:Datum_kreiranja),LEFT(12)
                         END
                       END
                       FOOTER,AT(1000,9688,6250,312),USE(?Footer)
                         STRING(@N3),AT(2948,-10),USE(ReportPageNumber)
                       END
                       FORM,AT(1000,1000,6250,9688),USE(?Form)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepLongClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('StavkeOdabraneSlike')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:PICTURES.Open                                     ! File PICTURES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('StavkeOdabraneSlike',ProgressWindow)       ! Restore window settings from non-volatile store
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:PICTURES, ?Progress:PctText, Progress:Thermometer, ProgressMgr, PIC:Sifra_slike)
  ThisReport.AddSortOrder(PIC:PK_Pictures_SifraSlike)
  ThisReport.AddRange(PIC:Sifra_slike)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:PICTURES.SetQuickScan(1,Propagate:OneMany)
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:PICTURES.Close
  END
  IF SELF.Opened
    INIMgr.Update('StavkeOdabraneSlike',ProgressWindow)    ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp{PROP:Text} = FORMAT(TODAY(),@D17)
  END
  IF ReturnValue = Level:Benign
    Report$?ReportPageNumber{PROP:PageNo} = True
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Report
!!! Ispis pjesama u pojedinom mobitelu
!!! </summary>
PomocniIspis PROCEDURE 

Progress:Thermometer BYTE                                  !
Process:View         VIEW(PHONE)
                       PROJECT(PHN:Naziv_mobitela)
                       PROJECT(PHN:Sifra_mobitela)
                       JOIN(IMA_M:PK_ImaM_SifraMobitela_SifraPjesme,PHN:Sifra_mobitela),INNER
                         PROJECT(IMA_M:Cijena_downloada)
                         PROJECT(IMA_M:Cijena_s_popustom)
                         PROJECT(IMA_M:Popust)
                         PROJECT(IMA_M:Sifra_pjesme)
                         JOIN(MSC:PK_Music_SifraPjesme,IMA_M:Sifra_pjesme),INNER
                           PROJECT(MSC:Naziv_pjesme)
                           PROJECT(MSC:Sifra_pjesme)
                         END
                       END
                     END
ReportPageNumber     LONG,AUTO
ProgressWindow       WINDOW('Progress...'),AT(,,142,59),DOUBLE,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

Report               REPORT,AT(1000,2000,6250,7688),PRE(RPT),PAPER(PAPER:A4),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(1000,1000,6250,1458),USE(?Header)
                         STRING('POPIS MUZIKE U MOBITELU'),AT(542,292,4052),USE(?STRING1),FONT(,20),TRN
                         IMAGE('Slike\music-5.jpg'),AT(4812,31,1385,1323),USE(?IMAGE4)
                       END
BreakSifraMobitelaMobitel BREAK(PHN:Sifra_mobitela),USE(?BREAK1)
                         HEADER,AT(0,0,6250,1490),USE(?GROUPHEADER1),PAGEBEFORE(1)
                           STRING(@N3),AT(1240,229),USE(PHN:Sifra_mobitela),RIGHT(1)
                           STRING(@s20),AT(1240,490),USE(PHN:Naziv_mobitela)
                           STRING('#Pjesme'),AT(167,990),USE(?STRING2)
                           STRING('Naziv'),AT(854,990),USE(?STRING3)
                           STRING('Download sa'),AT(2156,990),USE(?STRING5)
                           STRING('Cijena'),AT(3406,990),USE(?STRING6)
                           STRING('Popust (%)'),AT(4135,990,771,198),USE(?STRING7)
                           STRING('Cijena s popustom'),AT(4865,990,1135,198),USE(?STRING8)
                           STRING('Sifra mobitela: '),AT(167,229),USE(?STRING4)
                           STRING('Naziv mobitela:'),AT(167,490),USE(?STRING9)
                           IMAGE('Slike\bannerdesign1.jpg'),AT(167,1250,5937,94),USE(?IMAGE5)
                         END
break1                   BREAK(MSC:Sifra_pjesme),USE(?BREAK2)
Detail                     DETAIL,AT(0,0,6250,271),USE(?Detail)
                             STRING(@N3),AT(260,31),USE(MSC:Sifra_pjesme),RIGHT(1)
                             STRING(@s20),AT(854,31,1135),USE(MSC:Naziv_pjesme)
                             STRING(@s20),AT(2156,31,1073),USE(IMA_M:Download_sa)
                             STRING(@n7.2),AT(3406,31,552),USE(IMA_M:Cijena_downloada),RIGHT(12)
                             STRING(@n3),AT(4240,31),USE(IMA_M:Popust),RIGHT(1)
                             STRING(@N7.2),AT(5094,31),USE(IMA_M:Cijena_s_popustom),CENTER(12)
                           END
                         END
                         FOOTER,AT(0,0,6250,948),USE(?GROUPFOOTER1)
                           STRING('Broj pjesama:'),AT(4115,219),USE(?STRING10)
                           STRING(@N3),AT(5187,219,542),USE(MSC:Sifra_pjesme,,?MSC:Sifra_pjesme:2),CNT,TALLY(break1), |
  RESET(BreakSifraMobitelaMobitel)
                           STRING('Ukupna cijena sa popustom:'),AT(3229,479),USE(?STRING11)
                           STRING(@N7.2),AT(5187,479,917),USE(IMA_M:Cijena_s_popustom,,?IMA_M:Cijena_s_popustom:2),SUM, |
  TALLY(break1),RESET(BreakSifraMobitelaMobitel)
                           STRING('kn'),AT(5792,479,312),USE(?STRING12)
                           IMAGE('Slike\bannerdesign1.jpg'),AT(167,62,5937,94),USE(?IMAGE1)
                           IMAGE('Slike\bannerdesign1.jpg'),AT(3229,740,2875,94),USE(?IMAGE2)
                         END
                       END
                       FOOTER,AT(1000,9688,6250,302),USE(?Footer)
                         STRING(@N3),AT(3000,31),USE(ReportPageNumber)
                       END
                       FORM,AT(1000,1000,6250,9688),USE(?Form)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepLongClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PomocniIspis')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:PHONE.Open                                        ! File PHONE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('PomocniIspis',ProgressWindow)              ! Restore window settings from non-volatile store
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:PHONE, ?Progress:PctText, Progress:Thermometer, ProgressMgr, PHN:Sifra_mobitela)
  ThisReport.AddSortOrder(PHN:PK_Phone_SifraMobitela)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:PHONE.SetQuickScan(1,Propagate:OneMany)
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:PHONE.Close
  END
  IF SELF.Opened
    INIMgr.Update('PomocniIspis',ProgressWindow)           ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    Report$?ReportPageNumber{PROP:PageNo} = True
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Report
!!! Ispis slika - jednostavno izvjesce
!!! </summary>
IspisSlika1 PROCEDURE 

Progress:Thermometer BYTE                                  !
Process:View         VIEW(PICTURES)
                       PROJECT(PIC:Datum_kreiranja)
                       PROJECT(PIC:Format_slike)
                       PROJECT(PIC:Naziv_slike)
                       PROJECT(PIC:Rezolucija)
                       PROJECT(PIC:Sifra_slike)
                       PROJECT(PIC:Velicina_slike)
                     END
ReportPageNumber     LONG,AUTO
ProgressWindow       WINDOW('Progress...'),AT(,,142,59),DOUBLE,VSCROLL,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

Report               REPORT,AT(1000,2000,6250,7688),PRE(RPT),PAPER(PAPER:A4),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(1000,1000,6250,2156),USE(?Header)
                         STRING('POPIS SLIKA'),AT(167,135,2562),USE(?STRING1),FONT(,20,,,CHARSET:EASTEUROPE)
                         STRING('Datum kreiranja:'),AT(167,562),USE(?ReportDatePrompt),TRN
                         STRING('<<-- Date Stamp -->'),AT(1229,562),USE(?ReportDateStamp),TRN
                         IMAGE('Slike\pic.png'),AT(4792,135,1292,1135),USE(?IMAGE1)
                         STRING('#Slike'),AT(167,1635,802,198),USE(?STRING2),FONT(,10,,FONT:bold,CHARSET:EASTEUROPE)
                         STRING('Naziv slike'),AT(781,1635,917,198),USE(?STRING3),FONT(,10,,FONT:bold,CHARSET:EASTEUROPE)
                         STRING('Format'),AT(2375,1635,677,198),USE(?STRING4),FONT(,10,,FONT:bold,CHARSET:EASTEUROPE)
                         STRING('Velicina'),AT(3042,1635,635,198),USE(?STRING5),FONT(,10,,FONT:bold,CHARSET:EASTEUROPE)
                         STRING('Rezolucija'),AT(3854,1635,802,198),USE(?STRING6),FONT(,10,,FONT:bold,CHARSET:EASTEUROPE)
                         STRING('Datum kreiranja'),AT(4990,1635,1094,198),USE(?STRING7),FONT(,10,,FONT:bold,CHARSET:EASTEUROPE)
                         IMAGE('Slike\bannerdesign1.jpg'),AT(167,1896,5917,94),USE(?IMAGE3)
                       END
Detail                 DETAIL,AT(0,0,6250,2125),USE(?Detail)
                         STRING(@N3),AT(167,1635,354,198),USE(PIC:Sifra_slike),LEFT(1)
                         STRING(@s20),AT(781,1635,1698,198),USE(PIC:Naziv_slike),LEFT
                         STRING(@s19),AT(2375,1635,531,198),USE(PIC:Format_slike),LEFT
                         STRING(@P<<<#MBP),AT(3042,1635,656,198),USE(PIC:Velicina_slike),LEFT
                         STRING(@s10),AT(3854,1635,906,198),USE(PIC:Rezolucija),LEFT
                         STRING(@D6),AT(4990,1635,833,198),USE(PIC:Datum_kreiranja),LEFT(12)
                       END
                       FOOTER,AT(1000,9688,6250,312),USE(?Footer)
                         STRING(@N3),AT(2948,31),USE(ReportPageNumber)
                       END
                       FORM,AT(1000,1000,6250,9688),USE(?Form)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepLongClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('IspisSlika1')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:PICTURES.Open                                     ! File PICTURES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IspisSlika1',ProgressWindow)               ! Restore window settings from non-volatile store
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:PICTURES, ?Progress:PctText, Progress:Thermometer, ProgressMgr, PIC:Sifra_slike)
  ThisReport.AddSortOrder(PIC:PK_Pictures_SifraSlike)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:PICTURES.SetQuickScan(1,Propagate:OneMany)
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:PICTURES.Close
  END
  IF SELF.Opened
    INIMgr.Update('IspisSlika1',ProgressWindow)            ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp{PROP:Text} = FORMAT(TODAY(),@D17)
  END
  IF ReturnValue = Level:Benign
    Report$?ReportPageNumber{PROP:PageNo} = True
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Splash
!!! Skocni prozor
!!! </summary>
SkocniProzor PROCEDURE 

window               WINDOW,AT(,,204,112),FONT('MS Sans Serif',8,,FONT:regular),NOFRAME,CENTER,GRAY,MDI
                       PANEL,AT(0,-42,204,154),USE(?PANEL1),BEVEL(6)
                       PANEL,AT(7,6,191,98),USE(?PANEL2),BEVEL(-2,1)
                       STRING('Baza podataka za mobitel'),AT(13,12,182,17),USE(?String2),FONT('Microsoft Sans Serif', |
  12,,FONT:bold),CENTER
                       IMAGE('Slike\rsz_1smartphoneslogo.jpg'),AT(35,33,141,46),USE(?Image1)
                       STRING('Ucitavanje...'),AT(13,82,182,15),USE(?String1),FONT('Microsoft Sans Serif',12,,FONT:bold), |
  CENTER
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SkocniProzor')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PANEL1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(window)                                        ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('SkocniProzor',window)                      ! Restore window settings from non-volatile store
  TARGET{Prop:Timer} = 500                                 ! Close window on timer event, so configure timer
  TARGET{Prop:Alrt,255} = MouseLeft                        ! Alert mouse clicks that will close window
  TARGET{Prop:Alrt,254} = MouseLeft2
  TARGET{Prop:Alrt,253} = MouseRight
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('SkocniProzor',window)                   ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF MouseLeft
      OROF MouseLeft2
      OROF MouseRight
        POST(Event:CloseWindow)                            ! Splash window will close on mouse click
      END
    OF EVENT:LoseFocus
        POST(Event:CloseWindow)                            ! Splash window will close when focus is lost
    OF Event:Timer
      POST(Event:CloseWindow)                              ! Splash window will close on event timer
    OF Event:AlertKey
      CASE KEYCODE()                                       ! Splash window will close on mouse click
      OF MouseLeft
      OROF MouseLeft2
      OROF MouseRight
        POST(Event:CloseWindow)
      END
    ELSE
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

