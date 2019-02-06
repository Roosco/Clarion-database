  MEMBER('Aplikacija.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('Aplikacija_BC0.CLW')
Aplikacija_BC0:DctInit             PROCEDURE
Aplikacija_BC0:DctKill             PROCEDURE
Aplikacija_BC0:FilesInit           PROCEDURE
    END
  END

DctInit PROCEDURE
  CODE
  Aplikacija_BC0:DctInit
  Aplikacija_BC0:FilesInit


DctKill PROCEDURE
  CODE
  Aplikacija_BC0:DctKill

