*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZSPAS_PET.......................................*
DATA:  BEGIN OF STATUS_ZSPAS_PET                     .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSPAS_PET                     .
CONTROLS: TCTRL_ZSPAS_PET
            TYPE TABLEVIEW USING SCREEN '9000'.
*.........table declarations:.................................*
TABLES: *ZSPAS_PET                     .
TABLES: ZSPAS_PET                      .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
