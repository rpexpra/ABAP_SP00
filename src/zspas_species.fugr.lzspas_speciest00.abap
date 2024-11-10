*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZSPAS_SPECIES...................................*
DATA:  BEGIN OF STATUS_ZSPAS_SPECIES                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSPAS_SPECIES                 .
CONTROLS: TCTRL_ZSPAS_SPECIES
            TYPE TABLEVIEW USING SCREEN '9000'.
*.........table declarations:.................................*
TABLES: *ZSPAS_SPECIES                 .
TABLES: ZSPAS_SPECIES                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
