class ZCL_ZOD_SPAS1_DPC_EXT definition
  public
  inheriting from ZCL_ZOD_SPAS1_DPC
  create public .

public section.
protected section.

  methods PETSET_CREATE_ENTITY
    redefinition .
  methods PETSET_GET_ENTITY
    redefinition .
  methods PETSET_GET_ENTITYSET
    redefinition .
  methods PETSET_UPDATE_ENTITY
    redefinition .
  methods RACESET_GET_ENTITYSET
    redefinition .
  methods SPECIESSET_GET_ENTITYSET
    redefinition .
  methods PETSET_DELETE_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZOD_SPAS1_DPC_EXT IMPLEMENTATION.


  METHOD petset_create_entity.
**TRY.
*CALL METHOD SUPER->PETSET_CREATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**    io_data_provider        =
**  IMPORTING
**    er_entity               =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
    DATA: ls_pet TYPE zspas_pet.
    CALL METHOD io_data_provider->read_entry_data
      IMPORTING
        es_data = ls_pet.

    ls_pet-mandt = sy-mandt.
    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'ZPET_ID'
*       QUANTITY                = '1'
*       SUBOBJECT               = ' '
*       TOYEAR                  = '0000'
*       IGNORE_BUFFER           = ' '
      IMPORTING
        number                  = ls_pet-pet_id
*       QUANTITY                =
*       RETURNCODE              =
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.
IF ls_pet-pet_id is NOT INITIAL.
  INSERT  zspas_pet from ls_pet.
  IF SY-SUBRC EQ 0.
     MOVE-CORRESPONDING ls_pet to er_entity.
     COMMIT WORK.
  ENDIF.

ENDIF.

  ENDMETHOD.


  METHOD petset_delete_entity.
**TRY.
*CALL METHOD SUPER->PETSET_DELETE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
    data : ld_pet_id type zspas_pet-pet_id.
    READ TABLE it_key_tab INTO DATA(ls_key) WITH KEY name = 'PetId'.
    IF sy-subrc EQ 0.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = ls_key-value
        IMPORTING
          output = ld_pet_id.
      IF  ld_pet_id IS NOT INITIAL.
        DELETE FROM zspas_pet WHERE pet_id EQ ld_pet_id.
           IF sy-subrc eq 0.
              COMMIT WORK.
           ENDIF.
      ENDIF.

    ENDIF.

  ENDMETHOD.


  method PETSET_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->PETSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
    DATA: ld_pet_id TYPE zspas_pet-pet_id.

    LOOP AT it_key_tab INTO DATA(ls_key).
      CASE ls_key-name.
        WHEN 'PetId'.
          CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
            EXPORTING
              input  = ls_key-value
            IMPORTING
              output = ld_pet_id.
          "   ld_pet_id  = ls_key-name.
      ENDCASE.
    ENDLOOP.

    IF ld_pet_id IS NOT INITIAL.
      SELECT SINGLE *
      INTO er_entity
      FROM zspas_pet
      WHERE pet_id EQ ld_pet_id.

    ENDIF.

  endmethod.


  method PETSET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->PETSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

  endmethod.


  METHOD petset_update_entity.
**TRY.
*CALL METHOD SUPER->PETSET_UPDATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**    io_data_provider        =
**  IMPORTING
**    er_entity               =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

    DATA: ls_pet    TYPE zspas_pet,
          ld_pet_id TYPE zspas_pet-pet_id.
    READ TABLE it_key_tab INTO DATA(ls_key) WITH KEY name = 'PetId'.
    IF sy-subrc EQ 0.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = ls_key-value
        IMPORTING
          output = ld_pet_id.


    ENDIF.

    CALL METHOD io_data_provider->read_entry_data
      IMPORTING
        es_data = ls_pet.
    ls_pet-pet_id = ld_pet_id.

    IF ls_pet-pet_id IS NOT INITIAL.
      MODIFY zspas_pet FROM ls_pet.
      IF sy-subrc EQ 0.
        MOVE-CORRESPONDING ls_pet TO er_entity.
        COMMIT WORK.

      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD raceset_get_entityset.
**TRY.
*CALL METHOD SUPER->RACESET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
    TYPES:  lty_r_species_id TYPE RANGE OF zspas_race-spec.
    DATA: li_r_species_id TYPE lty_r_species_id,
          ls_r_species_id TYPE LINE OF lty_r_species_id.
    LOOP AT it_filter_select_options INTO DATA(ls_FILTER_SELECT_OPTION).

      LOOP AT ls_filter_select_option-select_options INTO DATA(ls_selection_options).

        CASE ls_filter_select_option-property.
          WHEN 'SpecId'.
            CLEAR  ls_r_species_id.
            MOVE-CORRESPONDING ls_selection_options TO ls_r_species_id.
            APPEND ls_r_species_id TO li_r_species_id.
        ENDCASE.
      ENDLOOP.

    ENDLOOP.

    IF li_r_species_id[] is not INITIAL.
      select *
        into table et_entityset
     from zspas_race
        where spec in li_r_species_id.
    ENDIF.

  ENDMETHOD.


  method SPECIESSET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->SPECIESSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
   SELECT *
      INTO TABLE et_ENTITYSET
      FROM zspas_species.

  endmethod.
ENDCLASS.
