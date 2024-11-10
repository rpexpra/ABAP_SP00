*&---------------------------------------------------------------------*
*& Report Z_FILL_SPAS_PET
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_FILL_SPAS_PET.
DATA: g_pet TYPE zspas_pet.
*DATA: g_pet TYPE zspas_SPECIES.
*DATA: g_pet TYPE zspas_RACE.

CLEAR g_pet.
g_pet-MANDT = '001'.
g_pet-PET_ID = '0000000002'.
g_pet-NAME = 'CHUKY2'.
g_pet-SPECIES = 'DOG'.
g_pet-RACE = 'FOX_TER'.
g_pet-COLOR = 'WHITE'.
g_pet-MICRICHIP = 'G797979'.
*g_pet-SEX = 'f'.
*g_pet-STERLIZED = 'true'.
*g_pet-ADOPTER_NAME
*g_pet-ADOPTER_ADDRESS
*g_pet-ADOPTER_ID_CAR
*g_pet-PICTURE
*g_pet-OTHER_INFO
 g_pet-DOB = '20220911'.
*g_pet-ADOPTED

* Insert into BBDD
INSERT INTO zspas_pet VALUES g_pet.

IF sy-subrc EQ 0.
  MESSAGE 'Registro insertado correctamente' TYPE 'I'.
ELSE.
  MESSAGE 'El registro no se insertó' TYPE 'I'.
ENDIF.
*
*DATA: g_pet TYPE zspas_pet.
*
** SR  Swiss
*SELECT SINGLE * FROM zspas_pet
*   INTO g_pet
*   WHERE pet_id EQ '0000000002'.
*
*IF sy-subrc EQ 0.
*
* DELETE zspas_pet FROM g_pet.
*
* IF sy-subrc EQ 0.
*  WRITE / 'Registro eliminado de la base de datos'.
* ENDIF.
*
*ENDIF.
