  MEMBER('Aplikacija.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
Aplikacija_BC0:DctInit    PROCEDURE
Aplikacija_BC0:DctKill    PROCEDURE
Aplikacija_BC0:FilesInit  PROCEDURE
  END

Hide:Access:MUSIC    CLASS(FileManager),TYPE               ! FileManager for MUSIC
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:MUSIC    CLASS(RelationManager),TYPE           ! RelationManager for MUSIC
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:IMA_M    CLASS(FileManager),TYPE               ! FileManager for IMA_M
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:IMA_M    CLASS(RelationManager),TYPE           ! RelationManager for IMA_M
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:SDCard   CLASS(FileManager),TYPE               ! FileManager for SDCard
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:SDCard   CLASS(RelationManager),TYPE           ! RelationManager for SDCard
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:PHONE    CLASS(FileManager),TYPE               ! FileManager for PHONE
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:PHONE    CLASS(RelationManager),TYPE           ! RelationManager for PHONE
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:IMA_P    CLASS(FileManager),TYPE               ! FileManager for IMA_P
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:IMA_P    CLASS(RelationManager),TYPE           ! RelationManager for IMA_P
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:IMA_V    CLASS(FileManager),TYPE               ! FileManager for IMA_V
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:IMA_V    CLASS(RelationManager),TYPE           ! RelationManager for IMA_V
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:PICTURES CLASS(FileManager),TYPE               ! FileManager for PICTURES
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:PICTURES CLASS(RelationManager),TYPE           ! RelationManager for PICTURES
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:VIDEOS   CLASS(FileManager),TYPE               ! FileManager for VIDEOS
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:VIDEOS   CLASS(RelationManager),TYPE           ! RelationManager for VIDEOS
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END


_Hide:Access:MUSIC   &Hide:Access:MUSIC,AUTO,THREAD
_Hide:Relate:MUSIC   &Hide:Relate:MUSIC,AUTO,THREAD
_Hide:Access:IMA_M   &Hide:Access:IMA_M,AUTO,THREAD
_Hide:Relate:IMA_M   &Hide:Relate:IMA_M,AUTO,THREAD
_Hide:Access:SDCard  &Hide:Access:SDCard,AUTO,THREAD
_Hide:Relate:SDCard  &Hide:Relate:SDCard,AUTO,THREAD
_Hide:Access:PHONE   &Hide:Access:PHONE,AUTO,THREAD
_Hide:Relate:PHONE   &Hide:Relate:PHONE,AUTO,THREAD
_Hide:Access:IMA_P   &Hide:Access:IMA_P,AUTO,THREAD
_Hide:Relate:IMA_P   &Hide:Relate:IMA_P,AUTO,THREAD
_Hide:Access:IMA_V   &Hide:Access:IMA_V,AUTO,THREAD
_Hide:Relate:IMA_V   &Hide:Relate:IMA_V,AUTO,THREAD
_Hide:Access:PICTURES &Hide:Access:PICTURES,AUTO,THREAD
_Hide:Relate:PICTURES &Hide:Relate:PICTURES,AUTO,THREAD
_Hide:Access:VIDEOS  &Hide:Access:VIDEOS,AUTO,THREAD
_Hide:Relate:VIDEOS  &Hide:Relate:VIDEOS,AUTO,THREAD


Aplikacija_BC0:DctInit PROCEDURE
  CODE
  _Hide:Access:MUSIC &= NEW(Hide:Access:MUSIC)
  _Hide:Relate:MUSIC &= NEW(Hide:Relate:MUSIC)
  _Hide:Access:IMA_M &= NEW(Hide:Access:IMA_M)
  _Hide:Relate:IMA_M &= NEW(Hide:Relate:IMA_M)
  _Hide:Access:SDCard &= NEW(Hide:Access:SDCard)
  _Hide:Relate:SDCard &= NEW(Hide:Relate:SDCard)
  _Hide:Access:PHONE &= NEW(Hide:Access:PHONE)
  _Hide:Relate:PHONE &= NEW(Hide:Relate:PHONE)
  _Hide:Access:IMA_P &= NEW(Hide:Access:IMA_P)
  _Hide:Relate:IMA_P &= NEW(Hide:Relate:IMA_P)
  _Hide:Access:IMA_V &= NEW(Hide:Access:IMA_V)
  _Hide:Relate:IMA_V &= NEW(Hide:Relate:IMA_V)
  _Hide:Access:PICTURES &= NEW(Hide:Access:PICTURES)
  _Hide:Relate:PICTURES &= NEW(Hide:Relate:PICTURES)
  _Hide:Access:VIDEOS &= NEW(Hide:Access:VIDEOS)
  _Hide:Relate:VIDEOS &= NEW(Hide:Relate:VIDEOS)
  Relate:MUSIC &= _Hide:Relate:MUSIC
  Relate:IMA_M &= _Hide:Relate:IMA_M
  Relate:SDCard &= _Hide:Relate:SDCard
  Relate:PHONE &= _Hide:Relate:PHONE
  Relate:IMA_P &= _Hide:Relate:IMA_P
  Relate:IMA_V &= _Hide:Relate:IMA_V
  Relate:PICTURES &= _Hide:Relate:PICTURES
  Relate:VIDEOS &= _Hide:Relate:VIDEOS


Aplikacija_BC0:FilesInit PROCEDURE
  CODE
  _Hide:Relate:MUSIC.Init
  _Hide:Relate:IMA_M.Init
  _Hide:Relate:SDCard.Init
  _Hide:Relate:PHONE.Init
  _Hide:Relate:IMA_P.Init
  _Hide:Relate:IMA_V.Init
  _Hide:Relate:PICTURES.Init
  _Hide:Relate:VIDEOS.Init


Aplikacija_BC0:DctKill PROCEDURE
  CODE
  _Hide:Relate:MUSIC.Kill
  DISPOSE(_Hide:Relate:MUSIC)
  _Hide:Relate:IMA_M.Kill
  DISPOSE(_Hide:Relate:IMA_M)
  _Hide:Relate:SDCard.Kill
  DISPOSE(_Hide:Relate:SDCard)
  _Hide:Relate:PHONE.Kill
  DISPOSE(_Hide:Relate:PHONE)
  _Hide:Relate:IMA_P.Kill
  DISPOSE(_Hide:Relate:IMA_P)
  _Hide:Relate:IMA_V.Kill
  DISPOSE(_Hide:Relate:IMA_V)
  _Hide:Relate:PICTURES.Kill
  DISPOSE(_Hide:Relate:PICTURES)
  _Hide:Relate:VIDEOS.Kill
  DISPOSE(_Hide:Relate:VIDEOS)


Hide:Relate:MUSIC.Init PROCEDURE
  CODE
  _Hide:Access:MUSIC.Init
  SELF.Init(Access:MUSIC,1)


Hide:Access:MUSIC.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= MSC:Record
  SELF.FileNameValue = 'MUSIC'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= MUSIC
  PARENT.Init
  Access:MUSIC &= SELF


Hide:Access:MUSIC.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:MUSIC &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:MUSIC.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(MUSIC,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(MSC:PK_Music_SifraPjesme,'MSC:PK_Music_SifraPjesme',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:MUSIC.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 3
    GlobalErrors.SetField('MSC:Format_pjesme')
    IF INSTRING(']' & MSC:Format_pjesme & '[', ']MP3[]AAC[]FLAC[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''MP3'',''AAC'',''FLAC''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:MUSIC.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:IMA_M,RI:CASCADE,RI:CASCADE,IMA_M:PK_ImaM_SifraMobitela_SifraPjesme)
  SELF.AddRelationLink(MSC:Sifra_pjesme,IMA_M:Sifra_pjesme)


Hide:Relate:MUSIC.Kill PROCEDURE

  CODE
  _Hide:Access:MUSIC.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:MUSIC &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:MUSIC)                              ! destroy the file manager


Hide:Relate:IMA_M.Init PROCEDURE
  CODE
  _Hide:Access:IMA_M.Init
  SELF.Init(Access:IMA_M,1)


Hide:Access:IMA_M.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= IMA_M:Record
  SELF.FileNameValue = 'IMA_M'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= IMA_M
  PARENT.Init
  Access:IMA_M &= SELF


Hide:Access:IMA_M.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:IMA_M &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:IMA_M.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(IMA_M,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(IMA_M:PK_ImaM_SifraMobitela_SifraPjesme,'IMA_M:PK_ImaM_SifraMobitela_SifraPjesme',0)
    SELF.AddKey(IMA_M:K_ImaM_SifraPjesme_SifraMobitela,'IMA_M:K_ImaM_SifraPjesme_SifraMobitela',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:IMA_M.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:MUSIC1        USHORT,AUTO
Save:PHONE2        USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 1
    GlobalErrors.SetField('IMA_M:Sifra_pjesme')
    Save:MUSIC1 = Access:MUSIC.SaveFile()
    MSC:Sifra_pjesme = IMA_M:Sifra_pjesme
    ReturnValue = Access:MUSIC.TryFetch(MSC:PK_Music_SifraPjesme)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'MUSIC')
      END
    END
    Access:MUSIC.RestoreFile(Save:MUSIC1)
  OF 2
    GlobalErrors.SetField('IMA_M:Sifra_mobitela')
    Save:PHONE2 = Access:PHONE.SaveFile()
    PHN:Sifra_mobitela = IMA_M:Sifra_mobitela
    ReturnValue = Access:PHONE.TryFetch(PHN:PK_Phone_SifraMobitela)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'PHONE')
      END
    END
    Access:PHONE.RestoreFile(Save:PHONE2)
  END
  RETURN ReturnValue


Hide:Relate:IMA_M.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:MUSIC)

  SELF.AddRelation(Relate:PHONE)


Hide:Relate:IMA_M.Kill PROCEDURE

  CODE
  _Hide:Access:IMA_M.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:IMA_M &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:IMA_M)                              ! destroy the file manager


Hide:Relate:SDCard.Init PROCEDURE
  CODE
  _Hide:Access:SDCard.Init
  SELF.Init(Access:SDCard,1)


Hide:Access:SDCard.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= SDC:Record
  SELF.FileNameValue = 'SDCard'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= SDCard
  PARENT.Init
  Access:SDCard &= SELF


Hide:Access:SDCard.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:SDCard &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:SDCard.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(SDCard,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(SDC:SK_SDCard_NazivKartice,'SDC:SK_SDCard_NazivKartice',0)
    SELF.AddKey(SDC:SK_SDCard_FormatKartice,'SDC:SK_SDCard_FormatKartice',0)
    SELF.AddKey(SDC:SK_SDCard_Klasa,'SDC:SK_SDCard_Klasa',0)
    SELF.AddKey(SDC:SK_SDCard_Kapacitet,'SDC:SK_SDCard_Kapacitet',0)
    SELF.AddKey(SDC:PK_SDCard_SifraKartice,'SDC:PK_SDCard_SifraKartice',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:SDCard.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 4
    GlobalErrors.SetField('SDC:Format')
    IF INSTRING(']' & SDC:Format & '[', ']NTFS[]FAT32[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''NTFS'',''FAT32''')
      END
    END
  OF 5
    GlobalErrors.SetField('SDC:Klasa')
    IF INSTRING(']' & CLIP(SDC:Klasa) & '[', ']4[]10[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''4'',''10''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:SDCard.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:PHONE,RI:CASCADE,RI:RESTRICT,PHN:PK_Phone_SifraMobitela)


Hide:Relate:SDCard.Kill PROCEDURE

  CODE
  _Hide:Access:SDCard.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:SDCard &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:SDCard)                             ! destroy the file manager


Hide:Relate:PHONE.Init PROCEDURE
  CODE
  _Hide:Access:PHONE.Init
  SELF.Init(Access:PHONE,1)


Hide:Access:PHONE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PHN:Record
  SELF.FileNameValue = 'PHONE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= PHONE
  PARENT.Init
  Access:PHONE &= SELF


Hide:Access:PHONE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:PHONE &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:PHONE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(PHONE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(PHN:PK_Phone_SifraMobitela,'PHN:PK_Phone_SifraMobitela',0)
    SELF.AddKey(PHN:VK_Phone_SifraKartice,'PHN:VK_Phone_SifraKartice',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:PHONE.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:SDCard11      USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 11
    GlobalErrors.SetField('PHN:Sifra_kartice')
    Save:SDCard11 = Access:SDCard.SaveFile()
    SDC:Sifra_kartice = PHN:Sifra_kartice
    ReturnValue = Access:SDCard.TryFetch(SDC:PK_SDCard_SifraKartice)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'SDCard')
      END
    END
    Access:SDCard.RestoreFile(Save:SDCard11)
  END
  RETURN ReturnValue


Hide:Relate:PHONE.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:IMA_M,RI:CASCADE,RI:CASCADE,IMA_M:PK_ImaM_SifraMobitela_SifraPjesme)
  SELF.AddRelationLink(PHN:Sifra_mobitela,IMA_M:Sifra_mobitela)

  SELF.AddRelation(Relate:IMA_P,RI:CASCADE,RI:CASCADE,IMA_P:PK_ImaP_SifraMobitela_SifraSlike)
  SELF.AddRelationLink(PHN:Sifra_mobitela,IMA_P:Sifra_mobitela)

  SELF.AddRelation(Relate:IMA_V,RI:CASCADE,RI:CASCADE,IMA_V:PK_ImaV_SifraMobitela_SifraVidea)
  SELF.AddRelationLink(PHN:Sifra_mobitela,IMA_V:Sifra_mobitela)

  SELF.AddRelation(Relate:SDCard)


Hide:Relate:PHONE.Kill PROCEDURE

  CODE
  _Hide:Access:PHONE.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:PHONE &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:PHONE)                              ! destroy the file manager


Hide:Relate:IMA_P.Init PROCEDURE
  CODE
  _Hide:Access:IMA_P.Init
  SELF.Init(Access:IMA_P,1)


Hide:Access:IMA_P.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= IMA_P:Record
  SELF.FileNameValue = 'IMA_P'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= IMA_P
  PARENT.Init
  Access:IMA_P &= SELF


Hide:Access:IMA_P.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:IMA_P &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:IMA_P.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(IMA_P,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(IMA_P:PK_ImaP_SifraMobitela_SifraSlike,'IMA_P:PK_ImaP_SifraMobitela_SifraSlike',0)
    SELF.AddKey(IMA_P:K_ImaP_SifraSlike_SifraMobitela,'IMA_P:K_ImaP_SifraSlike_SifraMobitela',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:IMA_P.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:PHONE1        USHORT,AUTO
Save:PICTURES2     USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 1
    GlobalErrors.SetField('IMA_P:Sifra_mobitela')
    Save:PHONE1 = Access:PHONE.SaveFile()
    PHN:Sifra_mobitela = IMA_P:Sifra_mobitela
    ReturnValue = Access:PHONE.TryFetch(PHN:PK_Phone_SifraMobitela)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'PHONE')
      END
    END
    Access:PHONE.RestoreFile(Save:PHONE1)
  OF 2
    GlobalErrors.SetField('IMA_P:Sifra_slike')
    Save:PICTURES2 = Access:PICTURES.SaveFile()
    PIC:Sifra_slike = IMA_P:Sifra_slike
    ReturnValue = Access:PICTURES.TryFetch(PIC:PK_Pictures_SifraSlike)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'PICTURES')
      END
    END
    Access:PICTURES.RestoreFile(Save:PICTURES2)
  END
  RETURN ReturnValue


Hide:Relate:IMA_P.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:PHONE)

  SELF.AddRelation(Relate:PICTURES)


Hide:Relate:IMA_P.Kill PROCEDURE

  CODE
  _Hide:Access:IMA_P.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:IMA_P &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:IMA_P)                              ! destroy the file manager


Hide:Relate:IMA_V.Init PROCEDURE
  CODE
  _Hide:Access:IMA_V.Init
  SELF.Init(Access:IMA_V,1)


Hide:Access:IMA_V.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= IMA_V:Record
  SELF.FileNameValue = 'IMA_V'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= IMA_V
  PARENT.Init
  Access:IMA_V &= SELF


Hide:Access:IMA_V.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:IMA_V &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:IMA_V.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(IMA_V,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(IMA_V:PK_ImaV_SifraMobitela_SifraVidea,'IMA_V:PK_ImaV_SifraMobitela_SifraVidea',0)
    SELF.AddKey(IMA_V:K_ImaV_SifraVidea_SifraMobitela,'IMA_V:K_ImaV_SifraVidea_SifraMobitela',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:IMA_V.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:PHONE1        USHORT,AUTO
Save:VIDEOS2       USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 1
    GlobalErrors.SetField('IMA_V:Sifra_mobitela')
    Save:PHONE1 = Access:PHONE.SaveFile()
    PHN:Sifra_mobitela = IMA_V:Sifra_mobitela
    ReturnValue = Access:PHONE.TryFetch(PHN:PK_Phone_SifraMobitela)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'PHONE')
      END
    END
    Access:PHONE.RestoreFile(Save:PHONE1)
  OF 2
    GlobalErrors.SetField('IMA_V:Sifra_videa')
    Save:VIDEOS2 = Access:VIDEOS.SaveFile()
    VID:Sifra_videa = IMA_V:Sifra_videa
    ReturnValue = Access:VIDEOS.TryFetch(VID:PK_Videos_SifraVidea)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'VIDEOS')
      END
    END
    Access:VIDEOS.RestoreFile(Save:VIDEOS2)
  END
  RETURN ReturnValue


Hide:Relate:IMA_V.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:PHONE)

  SELF.AddRelation(Relate:VIDEOS)


Hide:Relate:IMA_V.Kill PROCEDURE

  CODE
  _Hide:Access:IMA_V.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:IMA_V &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:IMA_V)                              ! destroy the file manager


Hide:Relate:PICTURES.Init PROCEDURE
  CODE
  _Hide:Access:PICTURES.Init
  SELF.Init(Access:PICTURES,1)


Hide:Access:PICTURES.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PIC:Record
  SELF.FileNameValue = 'PICTURES'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= PICTURES
  PARENT.Init
  Access:PICTURES &= SELF


Hide:Access:PICTURES.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:PICTURES &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:PICTURES.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(PICTURES,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(PIC:PK_Pictures_SifraSlike,'PIC:PK_Pictures_SifraSlike',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:PICTURES.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 3
    GlobalErrors.SetField('PIC:Format_slike')
    IF INSTRING(']' & PIC:Format_slike & '[', ']BMP[]JPG[]JPEG[]TIFF[]PNG[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''BMP'',''JPG'',''JPEG'',''TIFF'',''PNG''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:PICTURES.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:IMA_P,RI:CASCADE,RI:CASCADE,IMA_P:PK_ImaP_SifraMobitela_SifraSlike)
  SELF.AddRelationLink(PIC:Sifra_slike,IMA_P:Sifra_slike)


Hide:Relate:PICTURES.Kill PROCEDURE

  CODE
  _Hide:Access:PICTURES.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:PICTURES &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:PICTURES)                           ! destroy the file manager


Hide:Relate:VIDEOS.Init PROCEDURE
  CODE
  _Hide:Access:VIDEOS.Init
  SELF.Init(Access:VIDEOS,1)


Hide:Access:VIDEOS.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= VID:Record
  SELF.FileNameValue = 'VIDEOS'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= VIDEOS
  PARENT.Init
  Access:VIDEOS &= SELF


Hide:Access:VIDEOS.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:VIDEOS &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:VIDEOS.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(VIDEOS,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(VID:PK_Videos_SifraVidea,'VID:PK_Videos_SifraVidea',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:VIDEOS.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 3
    GlobalErrors.SetField('VID:Format_videa')
    IF INSTRING(']' & VID:Format_videa & '[', ']MP4[]AVI[]WMV[]MPEG[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''MP4'',''AVI'',''WMV'',''MPEG''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:VIDEOS.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:IMA_V,RI:CASCADE,RI:CASCADE,IMA_V:PK_ImaV_SifraMobitela_SifraVidea)
  SELF.AddRelationLink(VID:Sifra_videa,IMA_V:Sifra_videa)


Hide:Relate:VIDEOS.Kill PROCEDURE

  CODE
  _Hide:Access:VIDEOS.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:VIDEOS &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:VIDEOS)                             ! destroy the file manager

