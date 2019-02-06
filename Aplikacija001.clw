

   MEMBER('Aplikacija.clw')                                ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('BRWEXT.INC'),ONCE

                     MAP
                       INCLUDE('APLIKACIJA001.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('APLIKACIJA002.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Frame
!!! Glavni prozor
!!! </summary>
Main PROCEDURE 

SplashProcedureThread LONG
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
AppFrame             APPLICATION('Baza podataka za mobitel'),AT(,,605,210),FONT(,,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,MAXIMIZE,CENTERED,HVSCROLL,ICON('Slike\Iconshock-Real-Vista-Project-Managment-' & |
  'Data-management.ico'),MAX,STATUS(-1,80,120,45),SYSTEM,WALLPAPER('Slike\simple-backgr' & |
  'ound-12.jpg'),IMM
                       MENUBAR,USE(?MENUBAR1)
                         MENU('&Datoteka'),USE(?FileMenu)
                           ITEM('P&ostavke ispisa...'),USE(?PrintSetup),MSG('Setup Printer'),STD(STD:PrintSetup)
                           ITEM,USE(?SEPARATOR1),SEPARATOR
                           ITEM('Izlaz'),USE(?Exit),MSG('Exit this application'),STD(STD:Close)
                         END
                         MENU('Edit'),USE(?EditMenu)
                           ITEM('Cu&t'),USE(?Cut),MSG('Remove item to Windows Clipboard'),STD(STD:Cut)
                           ITEM('&Copy'),USE(?Copy),MSG('Copy item to Windows Clipboard'),STD(STD:Copy)
                           ITEM('&Paste'),USE(?Paste),MSG('Paste contents of Windows Clipboard'),STD(STD:Paste)
                         END
                         MENU('Prozor'),USE(?MENU1),MSG('Create and Arrange windows'),STD(STD:WindowList)
                           ITEM('T&ile'),USE(?Tile),MSG('Make all open windows visible'),STD(STD:TileWindow)
                           ITEM('&Cascade'),USE(?Cascade),MSG('Stack all open windows'),STD(STD:CascadeWindow)
                           ITEM('&Arrange Icons'),USE(?Arrange),MSG('Align all window icons'),STD(STD:ArrangeIcons)
                         END
                         MENU('Pomoc'),USE(?MENU2),MSG('Windows Help')
                           ITEM('&Contents'),USE(?Helpindex),MSG('View the contents of the help file'),STD(STD:HelpIndex)
                           ITEM('&Search for Help On...'),USE(?HelpSearch),MSG('Search for help on a subject'),STD(STD:HelpSearch)
                           ITEM('&How to Use Help'),USE(?HelpOnHelp),MSG('How to use Windows Help'),STD(STD:HelpOnHelp)
                         END
                         MENU('Popis'),USE(?MENU3)
                           ITEM('Mobitela'),USE(?ITEM1)
                           ITEM('Muzike'),USE(?ITEM2)
                           ITEM('Slika'),USE(?ITEM3)
                           ITEM('Videa'),USE(?ITEM4)
                           ITEM('SD Kartica'),USE(?ITEM5)
                         END
                         MENU('Ispis'),USE(?MENU4)
                           ITEM('Jedne slike po stranici'),USE(?ITEM7)
                           ITEM('Svih slika'),USE(?ITEM6)
                           ITEM('Muzike po mobitelu'),USE(?ITEM8)
                         END
                       END
                       TOOLBAR,AT(0,0,605,46),USE(?TOOLBAR1)
                         BUTTON,AT(16,8,28,26),USE(?BUTTON2),FONT(,,,FONT:regular,234),ICON('Slike\telefon.ico')
                         BUTTON,AT(86,8,28,26),USE(?BUTTON1),ICON('Slike\Vargas21-Aquave-Metal-Music.ico')
                         BUTTON,AT(128,8,28,26),USE(?BUTTON3),FONT(,14),ICON('Slike\Vargas21-Aquave-Metal-Photos.ico')
                         BUTTON,AT(168,8,28,26),USE(?BUTTON4),ICON('Slike\Vargas21-Aquave-Metal-Movies.ico')
                         BUTTON,AT(236,8,28,26),USE(?BUTTON5),ICON('Slike\Sycamoreent-Storage-Sd.ico')
                         BOX,AT(12,4,258,35),USE(?BOX1),COLOR(COLOR:Black),LINEWIDTH(1)
                         BUTTON('Ispis slika'),AT(324,8,70,26),USE(?BUTTON6)
                         BUTTON('Ispis muzike po mobitelu'),AT(396,8,119,26),USE(?BUTTON7)
                         BOX,AT(319,4,200,35),USE(?BOX2),COLOR(COLOR:Black),LINEWIDTH(1)
                         BUTTON,AT(566,8,28,26),USE(?Close),ICON('Slike\exit.ico')
                         BOX,AT(562,4,37,35),USE(?BOX3),COLOR(COLOR:Black),LINEWIDTH(1)
                       END
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
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
Menu::MENUBAR1 ROUTINE                                     ! Code for menu items on ?MENUBAR1
Menu::FileMenu ROUTINE                                     ! Code for menu items on ?FileMenu
Menu::EditMenu ROUTINE                                     ! Code for menu items on ?EditMenu
Menu::MENU1 ROUTINE                                        ! Code for menu items on ?MENU1
Menu::MENU2 ROUTINE                                        ! Code for menu items on ?MENU2
Menu::MENU3 ROUTINE                                        ! Code for menu items on ?MENU3
  CASE ACCEPTED()
  OF ?ITEM1
    START(PopisMobitela, 50000)
  OF ?ITEM2
    START(PopisMuzike, 50000)
  OF ?ITEM3
    START(PopisSlika, 50000)
  OF ?ITEM4
    START(PopisVidea, 50000)
  OF ?ITEM5
    START(PopisKartica, 50000)
  END
Menu::MENU4 ROUTINE                                        ! Code for menu items on ?MENU4
  CASE ACCEPTED()
  OF ?ITEM7
    START(IspisSlika2, 50000)
  OF ?ITEM6
    START(IspisSlika1, 50000)
  OF ?ITEM8
    START(PomocniIspis, 50000)
  END

ThisWindow.Ask PROCEDURE

  CODE
  IF NOT INRANGE(AppFrame{PROP:Timer},1,100)
    AppFrame{PROP:Timer} = 100
  END
    AppFrame{Prop:StatusText,3} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
    AppFrame{PROP:StatusText,4} = FORMAT(CLOCK(),@T1)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  SELF.Open(AppFrame)                                      ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('Main',AppFrame)                            ! Restore window settings from non-volatile store
  SELF.SetAlerts()
  COMPILE ('**CW7**',_VER_C70)
      AppFrame{PROP:TabBarVisible}  = False
  !**CW7**
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('Main',AppFrame)                         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
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
    CASE ACCEPTED()
    ELSE
      DO Menu::MENUBAR1                                    ! Process menu items on ?MENUBAR1 menu
      DO Menu::FileMenu                                    ! Process menu items on ?FileMenu menu
      DO Menu::EditMenu                                    ! Process menu items on ?EditMenu menu
      DO Menu::MENU1                                       ! Process menu items on ?MENU1 menu
      DO Menu::MENU2                                       ! Process menu items on ?MENU2 menu
      DO Menu::MENU3                                       ! Process menu items on ?MENU3 menu
      DO Menu::MENU4                                       ! Process menu items on ?MENU4 menu
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BUTTON2
      START(PopisMobitela, 50000)
    OF ?BUTTON1
      START(PopisMuzike, 50000)
    OF ?BUTTON3
      START(PopisSlika, 50000)
    OF ?BUTTON4
      START(PopisVidea, 50000)
    OF ?BUTTON5
      START(PopisKartica, 50000)
    OF ?BUTTON6
      START(IspisSlika2, 50000)
    OF ?BUTTON7
      START(PomocniIspis, 50000)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
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
    OF EVENT:OpenWindow
      SplashProcedureThread = START(SkocniProzor)          ! Run the splash window procedure
    OF EVENT:Timer
      AppFrame{Prop:StatusText,3} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
      AppFrame{PROP:StatusText,4} = FORMAT(CLOCK(),@T1)
    ELSE
      IF SplashProcedureThread
        IF EVENT() = Event:Accepted
          POST(Event:CloseWindow,,SplashProcedureThread)   ! Close the splash window
          SplashPRocedureThread = 0
        END
     END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Browse
!!! Popis mobitela
!!! </summary>
PopisMobitela PROCEDURE 

BRW1::View:Browse    VIEW(PHONE)
                       PROJECT(PHN:Sifra_mobitela)
                       PROJECT(PHN:Naziv_mobitela)
                       PROJECT(PHN:Velicina_ekrana)
                       PROJECT(PHN:Rezolucija)
                       PROJECT(PHN:OS)
                       PROJECT(PHN:Memorija)
                       PROJECT(PHN:Baterija)
                       PROJECT(PHN:Kolicina_glazbe)
                       PROJECT(PHN:Kolicina_slika)
                       PROJECT(PHN:Kolicina_videa)
                       PROJECT(PHN:Sifra_kartice)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
PHN:Sifra_mobitela     LIKE(PHN:Sifra_mobitela)       !List box control field - type derived from field
PHN:Naziv_mobitela     LIKE(PHN:Naziv_mobitela)       !List box control field - type derived from field
PHN:Velicina_ekrana    LIKE(PHN:Velicina_ekrana)      !List box control field - type derived from field
PHN:Rezolucija         LIKE(PHN:Rezolucija)           !List box control field - type derived from field
PHN:OS                 LIKE(PHN:OS)                   !List box control field - type derived from field
PHN:Memorija           LIKE(PHN:Memorija)             !List box control field - type derived from field
PHN:Baterija           LIKE(PHN:Baterija)             !List box control field - type derived from field
PHN:Kolicina_glazbe    LIKE(PHN:Kolicina_glazbe)      !List box control field - type derived from field
PHN:Kolicina_slika     LIKE(PHN:Kolicina_slika)       !List box control field - type derived from field
PHN:Kolicina_videa     LIKE(PHN:Kolicina_videa)       !List box control field - type derived from field
PHN:Sifra_kartice      LIKE(PHN:Sifra_kartice)        !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis mobitela'),AT(0,0,515,127),FONT(,,,,CHARSET:DEFAULT),ICON('Slike\telefon.ico'), |
  GRAY,MDI,SYSTEM,IMM
                       LIST,AT(5,5,504,102),USE(?List),HVSCROLL,FORMAT('37C(2)|M~#Mobitela~C(1)@N3@80C(2)|M~Na' & |
  'ziv mobitela~C(0)@s20@40C(2)|M~Vel. ekrana~C(0)@P#.#"P@40C(2)|M~Rezolucija~C(0)@s10@' & |
  '47C(2)|M~OS~C(0)@s25@40C(2)|M~Memorija~C(0)@P<<#GBP@42C(2)|M~Baterija~C(0)@P####mAhP' & |
  '@42C(2)|M~Kol. glazbe~C(1)@N-4@35C(2)|M~Kol. slika~C(1)@N-4@43C(2)|M~Kol. videa~C(1)' & |
  '@N-4@12C(2)|M~Sifra kartice~C(1)@N3@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('Izmjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('Odabir'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Izlaz'),AT(469,110,40,12),USE(?Close)
                     END

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
SetAlerts              PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator

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
  GlobalErrors.SetProcedureName('PopisMobitela')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:PHONE.Open                                        ! File PHONE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:PHONE,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,PHN:PK_Phone_SifraMobitela)           ! Add the sort order for PHN:PK_Phone_SifraMobitela for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,PHN:Sifra_mobitela,1,BRW1)     ! Initialize the browse locator using  using key: PHN:PK_Phone_SifraMobitela , PHN:Sifra_mobitela
  BRW1.AddField(PHN:Sifra_mobitela,BRW1.Q.PHN:Sifra_mobitela) ! Field PHN:Sifra_mobitela is a hot field or requires assignment from browse
  BRW1.AddField(PHN:Naziv_mobitela,BRW1.Q.PHN:Naziv_mobitela) ! Field PHN:Naziv_mobitela is a hot field or requires assignment from browse
  BRW1.AddField(PHN:Velicina_ekrana,BRW1.Q.PHN:Velicina_ekrana) ! Field PHN:Velicina_ekrana is a hot field or requires assignment from browse
  BRW1.AddField(PHN:Rezolucija,BRW1.Q.PHN:Rezolucija)      ! Field PHN:Rezolucija is a hot field or requires assignment from browse
  BRW1.AddField(PHN:OS,BRW1.Q.PHN:OS)                      ! Field PHN:OS is a hot field or requires assignment from browse
  BRW1.AddField(PHN:Memorija,BRW1.Q.PHN:Memorija)          ! Field PHN:Memorija is a hot field or requires assignment from browse
  BRW1.AddField(PHN:Baterija,BRW1.Q.PHN:Baterija)          ! Field PHN:Baterija is a hot field or requires assignment from browse
  BRW1.AddField(PHN:Kolicina_glazbe,BRW1.Q.PHN:Kolicina_glazbe) ! Field PHN:Kolicina_glazbe is a hot field or requires assignment from browse
  BRW1.AddField(PHN:Kolicina_slika,BRW1.Q.PHN:Kolicina_slika) ! Field PHN:Kolicina_slika is a hot field or requires assignment from browse
  BRW1.AddField(PHN:Kolicina_videa,BRW1.Q.PHN:Kolicina_videa) ! Field PHN:Kolicina_videa is a hot field or requires assignment from browse
  BRW1.AddField(PHN:Sifra_kartice,BRW1.Q.PHN:Sifra_kartice) ! Field PHN:Sifra_kartice is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisMobitela',BrowseWindow)               ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse,?List,'','',BRW1::View:Browse)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:PHONE.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('PopisMobitela',BrowseWindow)            ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeMobitela
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.SetAlerts PROCEDURE

  CODE
  PARENT.SetAlerts
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.SetAlerts()


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  !Take Sort Headers Events
  IF BRW1::SortHeader.TakeEvents()
     RETURN Level:Notify
  END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW1.SetSort PROCEDURE(BYTE NewOrder,BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.SetSort(NewOrder,Force)
  IF BRW1::LastSortOrder<>NewOrder THEN
     BRW1::SortHeader.ClearSort()
  END
  BRW1::LastSortOrder=NewOrder
  RETURN ReturnValue

BRW1::SortHeader.QueueResorted       PROCEDURE(STRING pString)
  CODE
    IF pString = ''
       BRW1.RestoreSort()
       BRW1.ResetSort(True)
    ELSE
       BRW1.ReplaceSort(pString,BRW1::Sort0:Locator)
       BRW1.SetLocatorFromSort()
    END
!!! <summary>
!!! Generated from procedure template - Browse
!!! Popis muzike
!!! </summary>
PopisMuzike PROCEDURE 

BRW1::View:Browse    VIEW(MUSIC)
                       PROJECT(MSC:Sifra_pjesme)
                       PROJECT(MSC:Naziv_pjesme)
                       PROJECT(MSC:Format_pjesme)
                       PROJECT(MSC:Velicina_pjesme)
                       PROJECT(MSC:Datum_kreiranja)
                       PROJECT(MSC:Bitrate)
                       PROJECT(MSC:Trajanje)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
MSC:Sifra_pjesme       LIKE(MSC:Sifra_pjesme)         !List box control field - type derived from field
MSC:Naziv_pjesme       LIKE(MSC:Naziv_pjesme)         !List box control field - type derived from field
MSC:Format_pjesme      LIKE(MSC:Format_pjesme)        !List box control field - type derived from field
MSC:Velicina_pjesme    LIKE(MSC:Velicina_pjesme)      !List box control field - type derived from field
MSC:Datum_kreiranja    LIKE(MSC:Datum_kreiranja)      !List box control field - type derived from field
MSC:Bitrate            LIKE(MSC:Bitrate)              !List box control field - type derived from field
MSC:Trajanje           LIKE(MSC:Trajanje)             !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis muzike'),AT(0,0,334,128),ICON('Slike\Vargas21-Aquave-Metal-Music.ico'),GRAY, |
  MDI,SYSTEM,IMM
                       LIST,AT(5,5,325,100),USE(?List),HVSCROLL,FORMAT('35C(2)|M~#Pjesme~C(0)@N3@80C(2)|M~Nazi' & |
  'v pjesme~C(0)@s20@32C(2)|M~Format~C(0)@s5@36C(2)|M~Velicina~C(0)@P<<<<#MBP@54C(2)|M~' & |
  'Datum kreiranja~C(0)@D6@40C(2)|M~Bitrate~C(0)@P<<<<#P@40C(2)|M~Trajanje~C(0)@P<<<<m<<<<sP@'), |
  FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('Izmjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('Odabir'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Izlaz'),AT(290,110,40,12),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator

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
  GlobalErrors.SetProcedureName('PopisMuzike')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:MUSIC.SetOpenRelated()
  Relate:MUSIC.Open                                        ! File MUSIC used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:MUSIC,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,MSC:PK_Music_SifraPjesme)             ! Add the sort order for MSC:PK_Music_SifraPjesme for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,MSC:Sifra_pjesme,1,BRW1)       ! Initialize the browse locator using  using key: MSC:PK_Music_SifraPjesme , MSC:Sifra_pjesme
  BRW1.AddField(MSC:Sifra_pjesme,BRW1.Q.MSC:Sifra_pjesme)  ! Field MSC:Sifra_pjesme is a hot field or requires assignment from browse
  BRW1.AddField(MSC:Naziv_pjesme,BRW1.Q.MSC:Naziv_pjesme)  ! Field MSC:Naziv_pjesme is a hot field or requires assignment from browse
  BRW1.AddField(MSC:Format_pjesme,BRW1.Q.MSC:Format_pjesme) ! Field MSC:Format_pjesme is a hot field or requires assignment from browse
  BRW1.AddField(MSC:Velicina_pjesme,BRW1.Q.MSC:Velicina_pjesme) ! Field MSC:Velicina_pjesme is a hot field or requires assignment from browse
  BRW1.AddField(MSC:Datum_kreiranja,BRW1.Q.MSC:Datum_kreiranja) ! Field MSC:Datum_kreiranja is a hot field or requires assignment from browse
  BRW1.AddField(MSC:Bitrate,BRW1.Q.MSC:Bitrate)            ! Field MSC:Bitrate is a hot field or requires assignment from browse
  BRW1.AddField(MSC:Trajanje,BRW1.Q.MSC:Trajanje)          ! Field MSC:Trajanje is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisMuzike',BrowseWindow)                 ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:MUSIC.Close
  END
  IF SELF.Opened
    INIMgr.Update('PopisMuzike',BrowseWindow)              ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeMuzike
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

!!! <summary>
!!! Generated from procedure template - Browse
!!! Popis slika
!!! </summary>
PopisSlika PROCEDURE 

BRW1::View:Browse    VIEW(PICTURES)
                       PROJECT(PIC:Sifra_slike)
                       PROJECT(PIC:Naziv_slike)
                       PROJECT(PIC:Format_slike)
                       PROJECT(PIC:Velicina_slike)
                       PROJECT(PIC:Rezolucija)
                       PROJECT(PIC:Datum_kreiranja)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
PIC:Sifra_slike        LIKE(PIC:Sifra_slike)          !List box control field - type derived from field
PIC:Naziv_slike        LIKE(PIC:Naziv_slike)          !List box control field - type derived from field
PIC:Format_slike       LIKE(PIC:Format_slike)         !List box control field - type derived from field
PIC:Velicina_slike     LIKE(PIC:Velicina_slike)       !List box control field - type derived from field
PIC:Rezolucija         LIKE(PIC:Rezolucija)           !List box control field - type derived from field
PIC:Datum_kreiranja    LIKE(PIC:Datum_kreiranja)      !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis slika'),AT(0,0,337,127),ICON('Slike\Vargas21-Aquave-Metal-Photos.ico'),GRAY, |
  MDI,SYSTEM,IMM
                       LIST,AT(5,5,326,100),USE(?List),HVSCROLL,FORMAT('25C|M~#Slike~C(2)@N3@70C|M~Naziv~C(2)@' & |
  's20@76C|M~Format~C(2)@s19@40C|M~Velicina~C(2)@P<<<<<<#MBP@43C|M~Rezolucija~C(2)@s10@' & |
  '56C|M~Datum kreiranja~C(2)@D6@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('Izmjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('Odabir'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Izlaz'),AT(291,110,40,12),USE(?Close)
                       BUTTON('Ispis'),AT(220,110,40,12),USE(?Print)
                     END

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
SetAlerts              PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator

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
  GlobalErrors.SetProcedureName('PopisSlika')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:PICTURES.Open                                     ! File PICTURES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:PICTURES,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,PIC:PK_Pictures_SifraSlike)           ! Add the sort order for PIC:PK_Pictures_SifraSlike for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,PIC:Sifra_slike,1,BRW1)        ! Initialize the browse locator using  using key: PIC:PK_Pictures_SifraSlike , PIC:Sifra_slike
  BRW1.AddField(PIC:Sifra_slike,BRW1.Q.PIC:Sifra_slike)    ! Field PIC:Sifra_slike is a hot field or requires assignment from browse
  BRW1.AddField(PIC:Naziv_slike,BRW1.Q.PIC:Naziv_slike)    ! Field PIC:Naziv_slike is a hot field or requires assignment from browse
  BRW1.AddField(PIC:Format_slike,BRW1.Q.PIC:Format_slike)  ! Field PIC:Format_slike is a hot field or requires assignment from browse
  BRW1.AddField(PIC:Velicina_slike,BRW1.Q.PIC:Velicina_slike) ! Field PIC:Velicina_slike is a hot field or requires assignment from browse
  BRW1.AddField(PIC:Rezolucija,BRW1.Q.PIC:Rezolucija)      ! Field PIC:Rezolucija is a hot field or requires assignment from browse
  BRW1.AddField(PIC:Datum_kreiranja,BRW1.Q.PIC:Datum_kreiranja) ! Field PIC:Datum_kreiranja is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisSlika',BrowseWindow)                  ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.PrintProcedure = 2
  BRW1.PrintControl = ?Print
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse,?List,'','',BRW1::View:Browse)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:PICTURES.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('PopisSlika',BrowseWindow)               ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      AzuriranjeSlika
      StavkeOdabraneSlike
    END
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.SetAlerts PROCEDURE

  CODE
  PARENT.SetAlerts
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.SetAlerts()


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  !Take Sort Headers Events
  IF BRW1::SortHeader.TakeEvents()
     RETURN Level:Notify
  END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW1.SetSort PROCEDURE(BYTE NewOrder,BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.SetSort(NewOrder,Force)
  IF BRW1::LastSortOrder<>NewOrder THEN
     BRW1::SortHeader.ClearSort()
  END
  BRW1::LastSortOrder=NewOrder
  RETURN ReturnValue

BRW1::SortHeader.QueueResorted       PROCEDURE(STRING pString)
  CODE
    IF pString = ''
       BRW1.RestoreSort()
       BRW1.ResetSort(True)
    ELSE
       BRW1.ReplaceSort(pString,BRW1::Sort0:Locator)
       BRW1.SetLocatorFromSort()
    END
!!! <summary>
!!! Generated from procedure template - Browse
!!! Popis videa
!!! </summary>
PopisVidea PROCEDURE 

BRW1::View:Browse    VIEW(VIDEOS)
                       PROJECT(VID:Sifra_videa)
                       PROJECT(VID:Naziv_videa)
                       PROJECT(VID:Format_videa)
                       PROJECT(VID:Velicina_videa)
                       PROJECT(VID:Rezolucija)
                       PROJECT(VID:Trajanje)
                       PROJECT(VID:Framerate)
                       PROJECT(VID:Datum_kreiranja)
                       PROJECT(VID:Film)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
VID:Sifra_videa        LIKE(VID:Sifra_videa)          !List box control field - type derived from field
VID:Naziv_videa        LIKE(VID:Naziv_videa)          !List box control field - type derived from field
VID:Format_videa       LIKE(VID:Format_videa)         !List box control field - type derived from field
VID:Velicina_videa     LIKE(VID:Velicina_videa)       !List box control field - type derived from field
VID:Rezolucija         LIKE(VID:Rezolucija)           !List box control field - type derived from field
VID:Trajanje           LIKE(VID:Trajanje)             !List box control field - type derived from field
VID:Framerate          LIKE(VID:Framerate)            !List box control field - type derived from field
VID:Datum_kreiranja    LIKE(VID:Datum_kreiranja)      !List box control field - type derived from field
VID:Film               LIKE(VID:Film)                 !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis videa'),AT(0,0,457,128),ICON('Slike\Vargas21-Aquave-Metal-Movies.ico'),GRAY, |
  MDI,SYSTEM,IMM
                       LIST,AT(5,5,446,100),USE(?List),HVSCROLL,FORMAT('30C(2)|M~#Videa~C(1)@N4@80L(2)|M~Naziv' & |
  '~C(0)@s20@76L(2)|M~Format~C(0)@s19@40L(2)|M~Velicina~C(0)@P<<<<<<#MBP@40L(2)|M~Rezol' & |
  'ucija~C(0)@s10@40L(2)|M~Trajanje~C(0)@T4@40L(2)|M~Framerate~C(0)@P##P@54L(2)|M~Datum' & |
  ' kreiranja~C(0)@D6@76L(2)|M~Film~C(0)@s19@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('Izmjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('Odabir'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Izlaz'),AT(412,110,40,12),USE(?Close)
                     END

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
SetAlerts              PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator

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
  GlobalErrors.SetProcedureName('PopisVidea')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:VIDEOS.Open                                       ! File VIDEOS used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:VIDEOS,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,VID:PK_Videos_SifraVidea)             ! Add the sort order for VID:PK_Videos_SifraVidea for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,VID:Sifra_videa,1,BRW1)        ! Initialize the browse locator using  using key: VID:PK_Videos_SifraVidea , VID:Sifra_videa
  BRW1.AddField(VID:Sifra_videa,BRW1.Q.VID:Sifra_videa)    ! Field VID:Sifra_videa is a hot field or requires assignment from browse
  BRW1.AddField(VID:Naziv_videa,BRW1.Q.VID:Naziv_videa)    ! Field VID:Naziv_videa is a hot field or requires assignment from browse
  BRW1.AddField(VID:Format_videa,BRW1.Q.VID:Format_videa)  ! Field VID:Format_videa is a hot field or requires assignment from browse
  BRW1.AddField(VID:Velicina_videa,BRW1.Q.VID:Velicina_videa) ! Field VID:Velicina_videa is a hot field or requires assignment from browse
  BRW1.AddField(VID:Rezolucija,BRW1.Q.VID:Rezolucija)      ! Field VID:Rezolucija is a hot field or requires assignment from browse
  BRW1.AddField(VID:Trajanje,BRW1.Q.VID:Trajanje)          ! Field VID:Trajanje is a hot field or requires assignment from browse
  BRW1.AddField(VID:Framerate,BRW1.Q.VID:Framerate)        ! Field VID:Framerate is a hot field or requires assignment from browse
  BRW1.AddField(VID:Datum_kreiranja,BRW1.Q.VID:Datum_kreiranja) ! Field VID:Datum_kreiranja is a hot field or requires assignment from browse
  BRW1.AddField(VID:Film,BRW1.Q.VID:Film)                  ! Field VID:Film is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisVidea',BrowseWindow)                  ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse,?List,'','',BRW1::View:Browse)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:VIDEOS.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('PopisVidea',BrowseWindow)               ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeVidea
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.SetAlerts PROCEDURE

  CODE
  PARENT.SetAlerts
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.SetAlerts()


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  !Take Sort Headers Events
  IF BRW1::SortHeader.TakeEvents()
     RETURN Level:Notify
  END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW1.SetSort PROCEDURE(BYTE NewOrder,BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.SetSort(NewOrder,Force)
  IF BRW1::LastSortOrder<>NewOrder THEN
     BRW1::SortHeader.ClearSort()
  END
  BRW1::LastSortOrder=NewOrder
  RETURN ReturnValue

BRW1::SortHeader.QueueResorted       PROCEDURE(STRING pString)
  CODE
    IF pString = ''
       BRW1.RestoreSort()
       BRW1.ResetSort(True)
    ELSE
       BRW1.ReplaceSort(pString,BRW1::Sort0:Locator)
       BRW1.SetLocatorFromSort()
    END
!!! <summary>
!!! Generated from procedure template - Browse
!!! Popis SD kartica
!!! </summary>
PopisKartica PROCEDURE 

LOC:Pretraga         STRING(20)                            !
BRW1::View:Browse    VIEW(SDCard)
                       PROJECT(SDC:Sifra_kartice)
                       PROJECT(SDC:Naziv_kartice)
                       PROJECT(SDC:Format)
                       PROJECT(SDC:Kapacitet)
                       PROJECT(SDC:Klasa)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
SDC:Sifra_kartice      LIKE(SDC:Sifra_kartice)        !List box control field - type derived from field
SDC:Naziv_kartice      LIKE(SDC:Naziv_kartice)        !List box control field - type derived from field
SDC:Format             LIKE(SDC:Format)               !List box control field - type derived from field
SDC:Kapacitet          LIKE(SDC:Kapacitet)            !List box control field - type derived from field
SDC:Klasa              LIKE(SDC:Klasa)                !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis SD kartica'),AT(0,0,316,163),ICON('Slike\Sycamoreent-Storage-Sd.ico'),GRAY,MDI, |
  SYSTEM,IMM
                       SHEET,AT(4,7,300,131),USE(?SHEET1)
                         TAB('Po sifri kartice'),USE(?TAB1)
                         END
                         TAB('Po nazivu kartice'),USE(?TAB2)
                         END
                         TAB('Po formatu'),USE(?TAB3)
                         END
                       END
                       PROMPT('Pretraga:'),AT(182,8,30,11),USE(?LOC:Pretraga:Prompt)
                       ENTRY(@s20),AT(215,8,60,10),USE(LOC:Pretraga)
                       BUTTON('Trazi'),AT(279,7,24,11),USE(?BUTTON1)
                       LIST,AT(15,27,279,100),USE(?List),VSCROLL,FORMAT('33C|M~#Kartice~C(2)@N3@95C|M~Naziv ka' & |
  'rtice~C(2)@s20@38C|M~Format~C(2)@s5@43C|M~Kapacitet~C(2)@P<<#GBP@34C|M~Klasa~C(2)@s3@'), |
  FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(4,141,40,12),USE(?Insert)
                       BUTTON('&Izmjena'),AT(50,141,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(94,141,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(144,141,40,12),USE(?Select)
                       BUTTON('Izlaz'),AT(264,141,40,12),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator
BRW1::Sort1:Locator  EntryLocatorClass                     ! Conditional Locator - CHOICE(?Sheet1)=2
BRW1::Sort2:Locator  EntryLocatorClass                     ! Conditional Locator - CHOICE(?Sheet1)=3

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
  GlobalErrors.SetProcedureName('PopisKartica')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?LOC:Pretraga:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:SDCard.Open                                       ! File SDCard used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:SDCard,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,SDC:SK_SDCard_NazivKartice)           ! Add the sort order for SDC:SK_SDCard_NazivKartice for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(?LOC:Pretraga,SDC:Naziv_kartice,1,BRW1) ! Initialize the browse locator using ?LOC:Pretraga using key: SDC:SK_SDCard_NazivKartice , SDC:Naziv_kartice
  BRW1.AddSortOrder(,SDC:SK_SDCard_FormatKartice)          ! Add the sort order for SDC:SK_SDCard_FormatKartice for sort order 2
  BRW1.AddLocator(BRW1::Sort2:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort2:Locator.Init(?LOC:Pretraga,SDC:Format,1,BRW1) ! Initialize the browse locator using ?LOC:Pretraga using key: SDC:SK_SDCard_FormatKartice , SDC:Format
  BRW1.AddSortOrder(,SDC:PK_SDCard_SifraKartice)           ! Add the sort order for SDC:PK_SDCard_SifraKartice for sort order 3
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 3
  BRW1::Sort0:Locator.Init(?LOC:Pretraga,SDC:Sifra_kartice,1,BRW1) ! Initialize the browse locator using ?LOC:Pretraga using key: SDC:PK_SDCard_SifraKartice , SDC:Sifra_kartice
  BRW1.AddField(SDC:Sifra_kartice,BRW1.Q.SDC:Sifra_kartice) ! Field SDC:Sifra_kartice is a hot field or requires assignment from browse
  BRW1.AddField(SDC:Naziv_kartice,BRW1.Q.SDC:Naziv_kartice) ! Field SDC:Naziv_kartice is a hot field or requires assignment from browse
  BRW1.AddField(SDC:Format,BRW1.Q.SDC:Format)              ! Field SDC:Format is a hot field or requires assignment from browse
  BRW1.AddField(SDC:Kapacitet,BRW1.Q.SDC:Kapacitet)        ! Field SDC:Kapacitet is a hot field or requires assignment from browse
  BRW1.AddField(SDC:Klasa,BRW1.Q.SDC:Klasa)                ! Field SDC:Klasa is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisKartica',BrowseWindow)                ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
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
    INIMgr.Update('PopisKartica',BrowseWindow)             ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeKartica
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
    CASE ACCEPTED()
    OF ?BUTTON1
      ThisWindow.Reset(1)
    END
  ReturnValue = PARENT.TakeAccepted()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?Sheet1)=2
    RETURN SELF.SetSort(1,Force)
  ELSIF CHOICE(?Sheet1)=3
    RETURN SELF.SetSort(2,Force)
  ELSE
    RETURN SELF.SetSort(3,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! Azuriranje mobitela
!!! </summary>
AzuriranjeMobitela PROCEDURE 

ActionMessage        CSTRING(40)                           !
BRW6::View:Browse    VIEW(IMA_M)
                       PROJECT(IMA_M:Sifra_pjesme)
                       PROJECT(IMA_M:Download_sa)
                       PROJECT(IMA_M:Cijena_downloada)
                       PROJECT(IMA_M:Popust)
                       PROJECT(IMA_M:Cijena_s_popustom)
                       PROJECT(IMA_M:Sifra_mobitela)
                       JOIN(MSC:PK_Music_SifraPjesme,IMA_M:Sifra_pjesme)
                         PROJECT(MSC:Naziv_pjesme)
                         PROJECT(MSC:Format_pjesme)
                         PROJECT(MSC:Velicina_pjesme)
                         PROJECT(MSC:Datum_kreiranja)
                         PROJECT(MSC:Bitrate)
                         PROJECT(MSC:Trajanje)
                         PROJECT(MSC:Sifra_pjesme)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
IMA_M:Sifra_pjesme     LIKE(IMA_M:Sifra_pjesme)       !List box control field - type derived from field
MSC:Naziv_pjesme       LIKE(MSC:Naziv_pjesme)         !List box control field - type derived from field
MSC:Format_pjesme      LIKE(MSC:Format_pjesme)        !List box control field - type derived from field
MSC:Velicina_pjesme    LIKE(MSC:Velicina_pjesme)      !List box control field - type derived from field
MSC:Datum_kreiranja    LIKE(MSC:Datum_kreiranja)      !List box control field - type derived from field
MSC:Bitrate            LIKE(MSC:Bitrate)              !List box control field - type derived from field
MSC:Trajanje           LIKE(MSC:Trajanje)             !List box control field - type derived from field
IMA_M:Download_sa      LIKE(IMA_M:Download_sa)        !List box control field - type derived from field
IMA_M:Cijena_downloada LIKE(IMA_M:Cijena_downloada)   !List box control field - type derived from field
IMA_M:Popust           LIKE(IMA_M:Popust)             !List box control field - type derived from field
IMA_M:Cijena_s_popustom LIKE(IMA_M:Cijena_s_popustom) !List box control field - type derived from field
IMA_M:Sifra_mobitela   LIKE(IMA_M:Sifra_mobitela)     !Primary key field - type derived from field
MSC:Sifra_pjesme       LIKE(MSC:Sifra_pjesme)         !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW8::View:Browse    VIEW(IMA_P)
                       PROJECT(IMA_P:Sifra_slike)
                       PROJECT(IMA_P:Sifra_mobitela)
                       JOIN(PIC:PK_Pictures_SifraSlike,IMA_P:Sifra_slike)
                         PROJECT(PIC:Naziv_slike)
                         PROJECT(PIC:Format_slike)
                         PROJECT(PIC:Velicina_slike)
                         PROJECT(PIC:Rezolucija)
                         PROJECT(PIC:Datum_kreiranja)
                         PROJECT(PIC:Sifra_slike)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
IMA_P:Sifra_slike      LIKE(IMA_P:Sifra_slike)        !List box control field - type derived from field
PIC:Naziv_slike        LIKE(PIC:Naziv_slike)          !List box control field - type derived from field
PIC:Format_slike       LIKE(PIC:Format_slike)         !List box control field - type derived from field
PIC:Velicina_slike     LIKE(PIC:Velicina_slike)       !List box control field - type derived from field
PIC:Rezolucija         LIKE(PIC:Rezolucija)           !List box control field - type derived from field
PIC:Datum_kreiranja    LIKE(PIC:Datum_kreiranja)      !List box control field - type derived from field
IMA_P:Sifra_mobitela   LIKE(IMA_P:Sifra_mobitela)     !Primary key field - type derived from field
PIC:Sifra_slike        LIKE(PIC:Sifra_slike)          !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW10::View:Browse   VIEW(IMA_V)
                       PROJECT(IMA_V:Sifra_videa)
                       PROJECT(IMA_V:Sifra_mobitela)
                       JOIN(VID:PK_Videos_SifraVidea,IMA_V:Sifra_videa)
                         PROJECT(VID:Naziv_videa)
                         PROJECT(VID:Format_videa)
                         PROJECT(VID:Velicina_videa)
                         PROJECT(VID:Rezolucija)
                         PROJECT(VID:Trajanje)
                         PROJECT(VID:Framerate)
                         PROJECT(VID:Datum_kreiranja)
                         PROJECT(VID:Film)
                         PROJECT(VID:Sifra_videa)
                       END
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?List:3
IMA_V:Sifra_videa      LIKE(IMA_V:Sifra_videa)        !List box control field - type derived from field
VID:Naziv_videa        LIKE(VID:Naziv_videa)          !List box control field - type derived from field
VID:Format_videa       LIKE(VID:Format_videa)         !List box control field - type derived from field
VID:Velicina_videa     LIKE(VID:Velicina_videa)       !List box control field - type derived from field
VID:Rezolucija         LIKE(VID:Rezolucija)           !List box control field - type derived from field
VID:Trajanje           LIKE(VID:Trajanje)             !List box control field - type derived from field
VID:Framerate          LIKE(VID:Framerate)            !List box control field - type derived from field
VID:Datum_kreiranja    LIKE(VID:Datum_kreiranja)      !List box control field - type derived from field
VID:Film               LIKE(VID:Film)                 !List box control field - type derived from field
IMA_V:Sifra_mobitela   LIKE(IMA_V:Sifra_mobitela)     !Primary key field - type derived from field
VID:Sifra_videa        LIKE(VID:Sifra_videa)          !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::PHN:Record  LIKE(PHN:RECORD),THREAD
FormWindow           WINDOW('Azuriranje mobitela'),AT(,,557,362),CENTER,ICON('Slike\telefon.ico'),GRAY,MDI,SYSTEM,IMM
                       PROMPT('Sifra mobitela:'),AT(16,12),USE(?PHN:Sifra_mobitela:Prompt)
                       ENTRY(@N3),AT(66,12,26,9),USE(PHN:Sifra_mobitela),RIGHT(1),REQ
                       PROMPT('Naziv mobitela:'),AT(12,24,,10),USE(?PHN:Naziv_mobitela:Prompt)
                       ENTRY(@s20),AT(66,24,60,9),USE(PHN:Naziv_mobitela),CAP,REQ
                       PROMPT('Velicina ekrana:'),AT(10,38),USE(?PHN:Velicina_ekrana:Prompt:2)
                       ENTRY(@P#.<P),AT(66,38,26,9),USE(PHN:Velicina_ekrana,,?PHN:Velicina_ekrana:2),CENTER
                       PROMPT('Rezolucija:'),AT(26,52,,10),USE(?PHN:Rezolucija:Prompt)
                       ENTRY(@s10),AT(66,52,60,9),USE(PHN:Rezolucija),REQ
                       PROMPT('OS:'),AT(48,66),USE(?PHN:OS:Prompt)
                       ENTRY(@s25),AT(66,66,60,9),USE(PHN:OS),CAP,REQ
                       PROMPT('Memorija:'),AT(30,80),USE(?PHN:Memorij:Prompt)
                       ENTRY(@P<#GBP),AT(66,80,26,9),USE(PHN:Memorija),REQ
                       PROMPT('Baterija:'),AT(34,92),USE(?PHN:Baterija:Prompt)
                       ENTRY(@P####mAhP),AT(66,92,38,9),USE(PHN:Baterija),REQ
                       PROMPT('Sifra kartice:'),AT(415,12),USE(?PHN:Sifra_kartice:Prompt)
                       ENTRY(@N3),AT(462,12,20,9),USE(PHN:Sifra_kartice),RIGHT(1)
                       BUTTON('...'),AT(486,12,12,10),USE(?CallLookup:2)
                       PROMPT('Kolicina glazbe:'),AT(422,36),USE(?PHN:Kolicina_glazbe:Prompt)
                       ENTRY(@N-4),AT(478,37,20,9),USE(PHN:Kolicina_glazbe),RIGHT(1)
                       PROMPT('Kolicina slika:'),AT(428,48),USE(?PHN:Kolicina_slika:Prompt)
                       ENTRY(@N-4),AT(478,49,20,9),USE(PHN:Kolicina_slika),RIGHT(1)
                       PROMPT('Kolicina videa:'),AT(426,60),USE(?PHN:Kolicina_videa:Prompt)
                       ENTRY(@N-4),AT(478,61,20,9),USE(PHN:Kolicina_videa),RIGHT(1)
                       BUTTON,AT(469,80,29,22),USE(?Save),KEY(CtrlAltEnter),ICON('Slike\Custom-Icon-Design-Pre' & |
  'tty-Office-7-Save.ico'),TIP('Save Record and Close')
                       STRING('Popis muzike'),AT(6,108),USE(?STRING1),FONT(,14,,FONT:bold)
                       LIST,AT(6,123,498,58),USE(?List),RIGHT(1),HVSCROLL,COLUMN,FORMAT('[35C(2)|M~#Pjesme~C(0' & |
  ')@N3@49C(2)|M~Naziv~C(0)@s20@30C(2)|M~Format~C(0)@s5@38C(2)|M~Velicina~C(0)@P<<<<#MB' & |
  'P@53C(2)|M~Datum kreiranja~C(0)@D6@33C(2)|M~Bitrate~C(0)@P<<#P@35C(2)|M~Trajanje~C(0' & |
  ')@P<<<<m<<<<sP@]|~Pjesma~[55C(2)|M~Download s~C(0)@s20@63C(2)|M~Cijena downloada~C(0' & |
  ')@n7.2@29C(2)|M~Popust~C(0)@n3@28C(2)|M~Cijena s popustom~C(0)@N7.2@]|~Dodatne informacije~'), |
  FROM(Queue:Browse),IMM
                       BUTTON('Unos'),AT(508,139,42,12),USE(?Insert)
                       BUTTON('Izmjena'),AT(508,154,42,12),USE(?Change)
                       BUTTON('Brisanje'),AT(508,169,42,12),USE(?Delete)
                       STRING('Popis slika'),AT(6,184),USE(?STRING2),FONT(,14,,FONT:bold)
                       LIST,AT(6,200,498,58),USE(?List:2),RIGHT(1),HVSCROLL,COLUMN,FORMAT('32C(2)|M~#Slike~C(1' & |
  ')@N3@145C(2)|M~Naziv~C(0)@s20@45C(2)|M~Format~C(0)@s19@38C(2)|M~Velicina~C(0)@P<<#MB' & |
  'P@43C(2)|M~Rezolucija~C(0)@s10@60C(2)|M~Datum kreiranja~C(0)@D6@'),FROM(Queue:Browse:1), |
  IMM
                       BUTTON('Unos'),AT(508,216,42,12),USE(?Insert:2)
                       BUTTON('Izmjena'),AT(508,231,42,12),USE(?Change:2)
                       BUTTON('Brisanje'),AT(508,246,42,12),USE(?Delete:2)
                       STRING('Popis videa'),AT(6,262,62,12),USE(?STRING3),FONT(,14,,FONT:bold)
                       LIST,AT(6,277,498,58),USE(?List:3),RIGHT(1),HVSCROLL,COLUMN,FORMAT('37C|M~#Videa~C(1)@N' & |
  '4@140C|M~Naziv~C(2)@s20@37C|M~Format~C(2)@s19@37C|M~Velicina~C(2)@P<<<<<<#MBP@45C|M~' & |
  'Rezolucija~C(2)@s10@44C|M~Trajanje~C(2)@T4@41C|M~Framerate~C(2)@P##P@60C|M~Datum kre' & |
  'iranja~C(2)@D6@50C|M~Film~C(2)@s19@'),FROM(Queue:Browse:2),IMM
                       BUTTON('Unos'),AT(508,294,42,12),USE(?Insert:3)
                       BUTTON('Izmjena'),AT(508,308,42,12),USE(?Change:3)
                       BUTTON('Brisanje'),AT(508,324,42,12),USE(?Delete:3)
                       BUTTON('Spremi'),AT(462,344,42,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Izlaz'),AT(508,344,42,12),USE(?Cancel),ICON(ICON:None)
                       STRING(@S40),AT(312,346,146),USE(ActionMessage)
                       BOX,AT(6,8,498,97),USE(?BOX1),COLOR(COLOR:Black),LINEWIDTH(1)
                       STRING(@s20),AT(462,24,36),USE(SDC:Naziv_kartice,,?SDC:Naziv_kartice:2)
                       STRING('Naziv kartice:'),AT(415,24),USE(?STRING4)
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
BRW6                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
                     END

BRW6::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW8                 CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
                     END

BRW8::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW10                CLASS(BrowseClass)                    ! Browse using ?List:3
Q                      &Queue:Browse:2                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
                     END

BRW10::Sort0:Locator StepLocatorClass                      ! Default Locator
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
  GlobalErrors.SetProcedureName('AzuriranjeMobitela')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PHN:Sifra_mobitela:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(PHN:Record,History::PHN:Record)
  SELF.AddHistoryField(?PHN:Sifra_mobitela,1)
  SELF.AddHistoryField(?PHN:Naziv_mobitela,2)
  SELF.AddHistoryField(?PHN:Velicina_ekrana:2,3)
  SELF.AddHistoryField(?PHN:Rezolucija,4)
  SELF.AddHistoryField(?PHN:OS,5)
  SELF.AddHistoryField(?PHN:Baterija,7)
  SELF.AddHistoryField(?PHN:Sifra_kartice,11)
  SELF.AddHistoryField(?PHN:Kolicina_glazbe,8)
  SELF.AddHistoryField(?PHN:Kolicina_slika,9)
  SELF.AddHistoryField(?PHN:Kolicina_videa,10)
  SELF.AddUpdateFile(Access:PHONE)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:IMA_M.SetOpenRelated()
  Relate:IMA_M.Open                                        ! File IMA_M used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:PHONE
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
  SELF.SaveControl = ?Save
  SELF.DisableCancelButton = 1
  BRW6.Init(?List,Queue:Browse.ViewPosition,BRW6::View:Browse,Queue:Browse,Relate:IMA_M,SELF) ! Initialize the browse manager
  BRW8.Init(?List:2,Queue:Browse:1.ViewPosition,BRW8::View:Browse,Queue:Browse:1,Relate:IMA_P,SELF) ! Initialize the browse manager
  BRW10.Init(?List:3,Queue:Browse:2.ViewPosition,BRW10::View:Browse,Queue:Browse:2,Relate:IMA_V,SELF) ! Initialize the browse manager
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  BRW6.Q &= Queue:Browse
  BRW6.AddSortOrder(,IMA_M:PK_ImaM_SifraMobitela_SifraPjesme) ! Add the sort order for IMA_M:PK_ImaM_SifraMobitela_SifraPjesme for sort order 1
  BRW6.AddRange(IMA_M:Sifra_mobitela,Relate:IMA_M,Relate:PHONE) ! Add file relationship range limit for sort order 1
  BRW6.AddLocator(BRW6::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW6::Sort0:Locator.Init(,IMA_M:Sifra_pjesme,1,BRW6)     ! Initialize the browse locator using  using key: IMA_M:PK_ImaM_SifraMobitela_SifraPjesme , IMA_M:Sifra_pjesme
  BRW6.AddField(IMA_M:Sifra_pjesme,BRW6.Q.IMA_M:Sifra_pjesme) ! Field IMA_M:Sifra_pjesme is a hot field or requires assignment from browse
  BRW6.AddField(MSC:Naziv_pjesme,BRW6.Q.MSC:Naziv_pjesme)  ! Field MSC:Naziv_pjesme is a hot field or requires assignment from browse
  BRW6.AddField(MSC:Format_pjesme,BRW6.Q.MSC:Format_pjesme) ! Field MSC:Format_pjesme is a hot field or requires assignment from browse
  BRW6.AddField(MSC:Velicina_pjesme,BRW6.Q.MSC:Velicina_pjesme) ! Field MSC:Velicina_pjesme is a hot field or requires assignment from browse
  BRW6.AddField(MSC:Datum_kreiranja,BRW6.Q.MSC:Datum_kreiranja) ! Field MSC:Datum_kreiranja is a hot field or requires assignment from browse
  BRW6.AddField(MSC:Bitrate,BRW6.Q.MSC:Bitrate)            ! Field MSC:Bitrate is a hot field or requires assignment from browse
  BRW6.AddField(MSC:Trajanje,BRW6.Q.MSC:Trajanje)          ! Field MSC:Trajanje is a hot field or requires assignment from browse
  BRW6.AddField(IMA_M:Download_sa,BRW6.Q.IMA_M:Download_sa) ! Field IMA_M:Download_sa is a hot field or requires assignment from browse
  BRW6.AddField(IMA_M:Cijena_downloada,BRW6.Q.IMA_M:Cijena_downloada) ! Field IMA_M:Cijena_downloada is a hot field or requires assignment from browse
  BRW6.AddField(IMA_M:Popust,BRW6.Q.IMA_M:Popust)          ! Field IMA_M:Popust is a hot field or requires assignment from browse
  BRW6.AddField(IMA_M:Cijena_s_popustom,BRW6.Q.IMA_M:Cijena_s_popustom) ! Field IMA_M:Cijena_s_popustom is a hot field or requires assignment from browse
  BRW6.AddField(IMA_M:Sifra_mobitela,BRW6.Q.IMA_M:Sifra_mobitela) ! Field IMA_M:Sifra_mobitela is a hot field or requires assignment from browse
  BRW6.AddField(MSC:Sifra_pjesme,BRW6.Q.MSC:Sifra_pjesme)  ! Field MSC:Sifra_pjesme is a hot field or requires assignment from browse
  BRW8.Q &= Queue:Browse:1
  BRW8.AddSortOrder(,IMA_P:PK_ImaP_SifraMobitela_SifraSlike) ! Add the sort order for IMA_P:PK_ImaP_SifraMobitela_SifraSlike for sort order 1
  BRW8.AddRange(IMA_P:Sifra_mobitela,Relate:IMA_P,Relate:PHONE) ! Add file relationship range limit for sort order 1
  BRW8.AddLocator(BRW8::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW8::Sort0:Locator.Init(,IMA_P:Sifra_slike,1,BRW8)      ! Initialize the browse locator using  using key: IMA_P:PK_ImaP_SifraMobitela_SifraSlike , IMA_P:Sifra_slike
  BRW8.AddField(IMA_P:Sifra_slike,BRW8.Q.IMA_P:Sifra_slike) ! Field IMA_P:Sifra_slike is a hot field or requires assignment from browse
  BRW8.AddField(PIC:Naziv_slike,BRW8.Q.PIC:Naziv_slike)    ! Field PIC:Naziv_slike is a hot field or requires assignment from browse
  BRW8.AddField(PIC:Format_slike,BRW8.Q.PIC:Format_slike)  ! Field PIC:Format_slike is a hot field or requires assignment from browse
  BRW8.AddField(PIC:Velicina_slike,BRW8.Q.PIC:Velicina_slike) ! Field PIC:Velicina_slike is a hot field or requires assignment from browse
  BRW8.AddField(PIC:Rezolucija,BRW8.Q.PIC:Rezolucija)      ! Field PIC:Rezolucija is a hot field or requires assignment from browse
  BRW8.AddField(PIC:Datum_kreiranja,BRW8.Q.PIC:Datum_kreiranja) ! Field PIC:Datum_kreiranja is a hot field or requires assignment from browse
  BRW8.AddField(IMA_P:Sifra_mobitela,BRW8.Q.IMA_P:Sifra_mobitela) ! Field IMA_P:Sifra_mobitela is a hot field or requires assignment from browse
  BRW8.AddField(PIC:Sifra_slike,BRW8.Q.PIC:Sifra_slike)    ! Field PIC:Sifra_slike is a hot field or requires assignment from browse
  BRW10.Q &= Queue:Browse:2
  BRW10.AddSortOrder(,IMA_V:PK_ImaV_SifraMobitela_SifraVidea) ! Add the sort order for IMA_V:PK_ImaV_SifraMobitela_SifraVidea for sort order 1
  BRW10.AddRange(IMA_V:Sifra_mobitela,Relate:IMA_V,Relate:PHONE) ! Add file relationship range limit for sort order 1
  BRW10.AddLocator(BRW10::Sort0:Locator)                   ! Browse has a locator for sort order 1
  BRW10::Sort0:Locator.Init(,IMA_V:Sifra_videa,1,BRW10)    ! Initialize the browse locator using  using key: IMA_V:PK_ImaV_SifraMobitela_SifraVidea , IMA_V:Sifra_videa
  BRW10.AddField(IMA_V:Sifra_videa,BRW10.Q.IMA_V:Sifra_videa) ! Field IMA_V:Sifra_videa is a hot field or requires assignment from browse
  BRW10.AddField(VID:Naziv_videa,BRW10.Q.VID:Naziv_videa)  ! Field VID:Naziv_videa is a hot field or requires assignment from browse
  BRW10.AddField(VID:Format_videa,BRW10.Q.VID:Format_videa) ! Field VID:Format_videa is a hot field or requires assignment from browse
  BRW10.AddField(VID:Velicina_videa,BRW10.Q.VID:Velicina_videa) ! Field VID:Velicina_videa is a hot field or requires assignment from browse
  BRW10.AddField(VID:Rezolucija,BRW10.Q.VID:Rezolucija)    ! Field VID:Rezolucija is a hot field or requires assignment from browse
  BRW10.AddField(VID:Trajanje,BRW10.Q.VID:Trajanje)        ! Field VID:Trajanje is a hot field or requires assignment from browse
  BRW10.AddField(VID:Framerate,BRW10.Q.VID:Framerate)      ! Field VID:Framerate is a hot field or requires assignment from browse
  BRW10.AddField(VID:Datum_kreiranja,BRW10.Q.VID:Datum_kreiranja) ! Field VID:Datum_kreiranja is a hot field or requires assignment from browse
  BRW10.AddField(VID:Film,BRW10.Q.VID:Film)                ! Field VID:Film is a hot field or requires assignment from browse
  BRW10.AddField(IMA_V:Sifra_mobitela,BRW10.Q.IMA_V:Sifra_mobitela) ! Field IMA_V:Sifra_mobitela is a hot field or requires assignment from browse
  BRW10.AddField(VID:Sifra_videa,BRW10.Q.VID:Sifra_videa)  ! Field VID:Sifra_videa is a hot field or requires assignment from browse
  INIMgr.Fetch('AzuriranjeMobitela',FormWindow)            ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  BRW6.AskProcedure = 2
  BRW8.AskProcedure = 3
  BRW10.AskProcedure = 4
  BRW6.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW8.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW10.AddToolbarTarget(Toolbar)                          ! Browse accepts toolbar control
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
    INIMgr.Update('AzuriranjeMobitela',FormWindow)         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  SDC:Sifra_kartice = PHN:Sifra_kartice                    ! Assign linking field value
  Access:SDCard.Fetch(SDC:PK_SDCard_SifraKartice)
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
    EXECUTE Number
      PopisKartica
      AzuriranjeImaM
      AzuriranjeImaP
      AzuriranjeImaV
    END
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
    OF ?PHN:Sifra_kartice
      IF Access:PHONE.TryValidateField(11)                 ! Attempt to validate PHN:Sifra_kartice in PHONE
        SELECT(?PHN:Sifra_kartice)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?PHN:Sifra_kartice
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?PHN:Sifra_kartice{PROP:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    OF ?CallLookup:2
      ThisWindow.Update
      SDC:Sifra_kartice = PHN:Sifra_kartice
      IF SELF.Run(1,SelectRecord) = RequestCompleted       ! Call lookup procedure and verify RequestCompleted
        PHN:Sifra_kartice = SDC:Sifra_kartice
      END
      ThisWindow.Reset(1)
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
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?PHN:Sifra_kartice
      SDC:Sifra_kartice = PHN:Sifra_kartice
      IF Access:SDCard.TryFetch(SDC:PK_SDCard_SifraKartice)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          PHN:Sifra_kartice = SDC:Sifra_kartice
        END
      END
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW6.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW6.ResetFromView PROCEDURE

PHN:Kolicina_glazbe:Cnt LONG                               ! Count variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:IMA_M.SetQuickScan(1)
  SELF.Reset
  IF SELF.UseMRP
     IF SELF.View{PROP:IPRequestCount} = 0
          SELF.View{PROP:IPRequestCount} = 60
     END
  END
  LOOP
    IF SELF.UseMRP
       IF SELF.View{PROP:IPRequestCount} = 0
            SELF.View{PROP:IPRequestCount} = 60
       END
    END
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      SETCURSOR()
      RETURN
    END
    SELF.SetQueueRecord
    PHN:Kolicina_glazbe:Cnt += 1
  END
  SELF.View{PROP:IPRequestCount} = 0
  PHN:Kolicina_glazbe = PHN:Kolicina_glazbe:Cnt
  PARENT.ResetFromView
  Relate:IMA_M.SetQuickScan(0)
  SETCURSOR()


BRW8.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END


BRW8.ResetFromView PROCEDURE

PHN:Kolicina_slika:Cnt LONG                                ! Count variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:IMA_P.SetQuickScan(1)
  SELF.Reset
  IF SELF.UseMRP
     IF SELF.View{PROP:IPRequestCount} = 0
          SELF.View{PROP:IPRequestCount} = 60
     END
  END
  LOOP
    IF SELF.UseMRP
       IF SELF.View{PROP:IPRequestCount} = 0
            SELF.View{PROP:IPRequestCount} = 60
       END
    END
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      SETCURSOR()
      RETURN
    END
    SELF.SetQueueRecord
    PHN:Kolicina_slika:Cnt += 1
  END
  SELF.View{PROP:IPRequestCount} = 0
  PHN:Kolicina_slika = PHN:Kolicina_slika:Cnt
  PARENT.ResetFromView
  Relate:IMA_P.SetQuickScan(0)
  SETCURSOR()


BRW10.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END


BRW10.ResetFromView PROCEDURE

PHN:Kolicina_videa:Cnt LONG                                ! Count variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:IMA_V.SetQuickScan(1)
  SELF.Reset
  IF SELF.UseMRP
     IF SELF.View{PROP:IPRequestCount} = 0
          SELF.View{PROP:IPRequestCount} = 60
     END
  END
  LOOP
    IF SELF.UseMRP
       IF SELF.View{PROP:IPRequestCount} = 0
            SELF.View{PROP:IPRequestCount} = 60
       END
    END
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      SETCURSOR()
      RETURN
    END
    SELF.SetQueueRecord
    PHN:Kolicina_videa:Cnt += 1
  END
  SELF.View{PROP:IPRequestCount} = 0
  PHN:Kolicina_videa = PHN:Kolicina_videa:Cnt
  PARENT.ResetFromView
  Relate:IMA_V.SetQuickScan(0)
  SETCURSOR()

!!! <summary>
!!! Generated from procedure template - Form
!!! Azuriranje muzike
!!! </summary>
AzuriranjeMuzike PROCEDURE 

ActionMessage        CSTRING(40)                           !
History::MSC:Record  LIKE(MSC:RECORD),THREAD
FormWindow           WINDOW('Azuriranje muzike...'),AT(,,140,132),CENTER,ICON('Slike\Vargas21-Aquave-Metal-Music.ico'), |
  GRAY,MDI,SYSTEM,IMM
                       PROMPT('Sifra pjesme:'),AT(19,6),USE(?MSC:Sifra_pjesme:Prompt:2)
                       ENTRY(@N3),AT(72,6,20,9),USE(MSC:Sifra_pjesme,,?MSC:Sifra_pjesme:2),RIGHT(1),REQ
                       PROMPT('Naziv pjesme:'),AT(16,19),USE(?MSC:Naziv_pjesme:Prompt)
                       ENTRY(@s20),AT(72,19,60,9),USE(MSC:Naziv_pjesme),CAP,REQ
                       PROMPT('Format pjesme:'),AT(12,32),USE(?MSC:Format_pjesme:Prompt)
                       LIST,AT(72,32,60,9),USE(MSC:Format_pjesme),DROP(3),FROM('MP3|#MP3|AAC|#AAC|FLAC|#FLAC')
                       PROMPT('Velicina pjesme:'),AT(9,45,,11),USE(?MSC:Velicina_pjesme:Prompt)
                       ENTRY(@P<<#MBP),AT(72,44,60,10),USE(MSC:Velicina_pjesme),REQ
                       PROMPT('Datum kreiranja:'),AT(10,59,,11),USE(?MSC:Datum_kreiranja:Prompt)
                       ENTRY(@D6),AT(72,58,45,10),USE(MSC:Datum_kreiranja),REQ
                       BUTTON('...'),AT(120,57,12,11),USE(?Calendar)
                       PROMPT('Bitrate:'),AT(38,73),USE(?MSC:Bitrate:Prompt)
                       ENTRY(@P<<#P),AT(72,71,29,10),USE(MSC:Bitrate),REQ
                       PROMPT('Trajanje:'),AT(32,86,,11),USE(?MSC:Trajanje:Prompt)
                       ENTRY(@P<<m<<sP),AT(72,84,29,10),USE(MSC:Trajanje),REQ
                       STRING(@S40),AT(32,100,100),USE(ActionMessage)
                       BUTTON('Spremi'),AT(48,113,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Izlaz'),AT(92,113,40,12),USE(?Cancel)
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
Calendar5            CalendarClass
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
  GlobalErrors.SetProcedureName('AzuriranjeMuzike')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?MSC:Sifra_pjesme:Prompt:2
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(MSC:Record,History::MSC:Record)
  SELF.AddHistoryField(?MSC:Sifra_pjesme:2,1)
  SELF.AddHistoryField(?MSC:Naziv_pjesme,2)
  SELF.AddHistoryField(?MSC:Format_pjesme,3)
  SELF.AddHistoryField(?MSC:Velicina_pjesme,4)
  SELF.AddHistoryField(?MSC:Datum_kreiranja,5)
  SELF.AddHistoryField(?MSC:Bitrate,6)
  SELF.AddHistoryField(?MSC:Trajanje,7)
  SELF.AddUpdateFile(Access:MUSIC)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:MUSIC.SetOpenRelated()
  Relate:MUSIC.Open                                        ! File MUSIC used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:MUSIC
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
  INIMgr.Fetch('AzuriranjeMuzike',FormWindow)              ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:MUSIC.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeMuzike',FormWindow)           ! Save window data to non-volatile store
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
    OF ?Calendar
      ThisWindow.Update
      Calendar5.SelectOnClose = True
      Calendar5.Ask('Odaberite datum',MSC:Datum_kreiranja)
      IF Calendar5.Response = RequestCompleted THEN
      MSC:Datum_kreiranja=Calendar5.SelectedDate
      DISPLAY(?MSC:Datum_kreiranja)
      END
      ThisWindow.Reset(True)
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
!!! Azuriranje slika
!!! </summary>
AzuriranjeSlika PROCEDURE 

ActionMessage        CSTRING(40)                           !
History::PIC:Record  LIKE(PIC:RECORD),THREAD
FormWindow           WINDOW('Azuriranje slika...'),AT(,,136,121),CENTER,ICON('Slike\Vargas21-Aquave-Metal-Photos.ico'), |
  GRAY,MDI,SYSTEM,IMM
                       PROMPT('Sifra slike:'),AT(28,8),USE(?PIC:Sifra_slike:Prompt)
                       ENTRY(@N3),AT(68,8,60,9),USE(PIC:Sifra_slike),RIGHT(1),REQ
                       PROMPT('Naziv slike:'),AT(24,20),USE(?PIC:Naziv_slike:Prompt)
                       ENTRY(@s20),AT(68,20,60,9),USE(PIC:Naziv_slike),CAP,REQ
                       PROMPT('Format slike:'),AT(20,34),USE(?PIC:Format_slike:Prompt)
                       LIST,AT(68,34,60,9),USE(PIC:Format_slike),DROP(4),FROM('BMP|#BMP|JPG|#JPG|JPEG|#JPEG|TI' & |
  'FF|#TIFF|PNG|#PNG')
                       PROMPT('Velicina slike:'),AT(18,46),USE(?PIC:Velicina_slike:Prompt)
                       ENTRY(@P<<<#MBP),AT(68,46,60,9),USE(PIC:Velicina_slike),REQ
                       PROMPT('Rezolucija:'),AT(26,60,,11),USE(?PIC:Rezolucija:Prompt)
                       ENTRY(@s10),AT(68,60,60,10),USE(PIC:Rezolucija),REQ
                       PROMPT('Datum kreiranja:'),AT(10,74,,11),USE(?PIC:Datum_kreiranja:Prompt)
                       ENTRY(@D6),AT(68,74,45,10),USE(PIC:Datum_kreiranja),LEFT(6),REQ
                       BUTTON('...'),AT(116,74,12,11),USE(?Calendar)
                       STRING(@S40),AT(26,88,102),USE(ActionMessage)
                       BUTTON('Spremi'),AT(44,101,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Izlaz'),AT(88,101,40,12),USE(?Cancel)
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
Calendar5            CalendarClass
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
  GlobalErrors.SetProcedureName('AzuriranjeSlika')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PIC:Sifra_slike:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(PIC:Record,History::PIC:Record)
  SELF.AddHistoryField(?PIC:Sifra_slike,1)
  SELF.AddHistoryField(?PIC:Naziv_slike,2)
  SELF.AddHistoryField(?PIC:Format_slike,3)
  SELF.AddHistoryField(?PIC:Velicina_slike,4)
  SELF.AddHistoryField(?PIC:Rezolucija,5)
  SELF.AddHistoryField(?PIC:Datum_kreiranja,6)
  SELF.AddUpdateFile(Access:PICTURES)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:PICTURES.Open                                     ! File PICTURES used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:PICTURES
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
  INIMgr.Fetch('AzuriranjeSlika',FormWindow)               ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeSlika',FormWindow)            ! Save window data to non-volatile store
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
    OF ?Calendar
      ThisWindow.Update
      Calendar5.SelectOnClose = True
      Calendar5.Ask('Odaberite datum',PIC:Datum_kreiranja)
      IF Calendar5.Response = RequestCompleted THEN
      PIC:Datum_kreiranja=Calendar5.SelectedDate
      DISPLAY(?PIC:Datum_kreiranja)
      END
      ThisWindow.Reset(True)
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
!!! Azuriranje videa
!!! </summary>
AzuriranjeVidea PROCEDURE 

ActionMessage        CSTRING(40)                           !
History::VID:Record  LIKE(VID:RECORD),THREAD
FormWindow           WINDOW('Azuriranje videa...'),AT(,,222,131),CENTER,ICON('Slike\Vargas21-Aquave-Metal-Movies.ico'), |
  GRAY,MDI,SYSTEM,IMM
                       PROMPT('Sifra videa:'),AT(24,8,,11),USE(?VID:Sifra_videa:Prompt)
                       ENTRY(@N4),AT(66,8,60,10),USE(VID:Sifra_videa),RIGHT(1),REQ
                       PROMPT('Naziv videa:'),AT(20,22),USE(?VID:Naziv_videa:Prompt)
                       ENTRY(@s20),AT(66,22,60,9),USE(VID:Naziv_videa),CAP,REQ
                       PROMPT('Velicina videa:'),AT(14,34,,11),USE(?VID:Velicina_videa:Prompt)
                       SPIN(@P<<<#MBP),AT(66,34,60,10),USE(VID:Velicina_videa),REQ
                       PROMPT('Rezolucija:'),AT(24,48,,11),USE(?VID:Rezolucija:Prompt)
                       ENTRY(@s10),AT(66,48,60,10),USE(VID:Rezolucija),REQ
                       PROMPT('Trajanje:'),AT(32,61,,11),USE(?VID:Trajanje:Prompt)
                       ENTRY(@T4),AT(66,61,60,10),USE(VID:Trajanje),REQ
                       PROMPT('Framerate:'),AT(26,74,,11),USE(?VID:Framerate:Prompt)
                       ENTRY(@P##P),AT(66,74,60,10),USE(VID:Framerate),REQ
                       PROMPT('Datum kreiranja:'),AT(10,88,,11),USE(?VID:Datum_kreiranja:Prompt)
                       ENTRY(@D6),AT(66,88,41,10),USE(VID:Datum_kreiranja),REQ
                       BUTTON('...'),AT(110,88,12,11),USE(?Calendar)
                       PROMPT('Film:'),AT(44,102),USE(?VID:Film:Prompt)
                       CHECK,AT(66,101),USE(VID:Film,,?VID:Film:2),VALUE('Da','Ne')
                       OPTION('Format videa:'),AT(148,7,66,70),USE(VID:Format_videa),BOXED
                         RADIO('MP4'),AT(156,17),USE(?VID:Format_videa:Radio1),VALUE('MP4')
                         RADIO('AVI'),AT(156,32),USE(?VID:Format_videa:Radio2),VALUE('AVI')
                         RADIO('WMV'),AT(156,46),USE(?VID:Format_videa:Radio3),VALUE('WMV')
                         RADIO('MPEG'),AT(156,60),USE(?VID:Format_videa:Radio4),VALUE('MPEG')
                       END
                       STRING(@S40),AT(44,115,81),USE(ActionMessage)
                       BUTTON('OK'),AT(128,114,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(174,114,40,12),USE(?Cancel)
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
Calendar5            CalendarClass
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
  GlobalErrors.SetProcedureName('AzuriranjeVidea')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?VID:Sifra_videa:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(VID:Record,History::VID:Record)
  SELF.AddHistoryField(?VID:Sifra_videa,1)
  SELF.AddHistoryField(?VID:Naziv_videa,2)
  SELF.AddHistoryField(?VID:Velicina_videa,4)
  SELF.AddHistoryField(?VID:Rezolucija,5)
  SELF.AddHistoryField(?VID:Trajanje,6)
  SELF.AddHistoryField(?VID:Framerate,7)
  SELF.AddHistoryField(?VID:Datum_kreiranja,8)
  SELF.AddHistoryField(?VID:Film:2,9)
  SELF.AddHistoryField(?VID:Format_videa,3)
  SELF.AddUpdateFile(Access:VIDEOS)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:VIDEOS.Open                                       ! File VIDEOS used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:VIDEOS
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
  INIMgr.Fetch('AzuriranjeVidea',FormWindow)               ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:VIDEOS.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeVidea',FormWindow)            ! Save window data to non-volatile store
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
    OF ?Calendar
      ThisWindow.Update
      Calendar5.SelectOnClose = True
      Calendar5.Ask('Odaberite datum',VID:Datum_kreiranja)
      IF Calendar5.Response = RequestCompleted THEN
      VID:Datum_kreiranja=Calendar5.SelectedDate
      DISPLAY(?VID:Datum_kreiranja)
      END
      ThisWindow.Reset(True)
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

