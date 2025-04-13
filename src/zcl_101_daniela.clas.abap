CLASS zcl_101_daniela DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    INTERFACES zif_abap_course_basics .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_101_daniela IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**********************************************************************
*   Task 1.
**********************************************************************

    out->write( zif_abap_course_basics~hello_world( 'Daniela' ) ).

**********************************************************************
*   Task 2.
**********************************************************************

    DATA(result) = zif_abap_course_basics~calculator(
        iv_first_number = 2
        iv_second_number = 3
        iv_operator = '*' ).
    IF result IS INITIAL.
        out->write( lcl_helper_class=>r_output ).
    ELSE.
        out->write( | 2 * 3 = { result } | ).

    ENDIF.

**********************************************************************
*   Task 3.
**********************************************************************

    out->write( 'The Fizz-Buzz string is:' &&
        zif_abap_course_basics~fizz_buzz( ) ).

**********************************************************************
*   Task 4.
**********************************************************************

    DATA(d_result) = zif_abap_course_basics~date_parsing( `12 April 2017` ).
    IF d_result IS INITIAL.
        out->write( lcl_helper_class=>r_output ).
    ELSE.
        out->write( d_result ).
    ENDIF.
    d_result = zif_abap_course_basics~date_parsing( `12 4 2017` ).
    IF d_result IS INITIAL.
        out->write( lcl_helper_class=>r_output ).
    ELSE.
        out->write( | { d_result DATE = USER } | ).
    ENDIF.

**********************************************************************
*   Task 5.
**********************************************************************

     out->write(
        'The result for: "This is scrabble score result" is:' &&
        zif_abap_course_basics~scrabble_score(
        'This is scrabble score result' ) ).

**********************************************************************
*   Task 6.
**********************************************************************

    DATA(lv_timestamp) = zif_abap_course_basics~get_current_date_time(  ).
    out->write( | The current timestamp is: { lv_timestamp } | ).
    out->write( | The current date is: { lcl_helper_class=>cdate DATE = USER } | ).
    out->write( | The current time is: { lcl_helper_class=>ctime TIME = USER } | ).

**********************************************************************
*   Task 7.
**********************************************************************

    out->write( lcl_helper_class=>is_empty_table(  ) ).
    lcl_helper_class=>init_travel_table( ).
    out->write( lcl_helper_class=>is_empty_table(  ) ).

  ENDMETHOD.


  METHOD zif_abap_course_basics~calculator.

    CASE iv_operator.
        WHEN '+'.
            rv_result = iv_first_number + iv_second_number.
        WHEN '-'.
            rv_result =  iv_first_number - iv_second_number.
        WHEN '*'.
            rv_result =  iv_first_number * iv_second_number.
        WHEN '/'.
            rv_result =  iv_first_number / iv_second_number.
        WHEN OTHERS.
            lcl_helper_class=>r_output =  `Wrong operator and/or operands.`.
            RETURN.
    ENDCASE.

  ENDMETHOD.


  METHOD zif_abap_course_basics~date_parsing.

    TYPES:
      BEGIN OF t_name,
        name TYPE string,
        idx TYPE i,
      END OF t_name.

    DATA: m_names TYPE TABLE OF t_name,
        day TYPE n LENGTH 2,
        month TYPE n LENGTH 2,
        year TYPE n LENGTH 4.

    m_names = VALUE #(
        ( idx =  1 name = `January` )
        ( idx =  2 name = `February` )
        ( idx =  3 name = `March` )
        ( idx =  4 name = `April` )
        ( idx =  5 name = `May` )
        ( idx =  6 name = `June` )
        ( idx =  7 name = `July` )
        ( idx =  8 name = `August` )
        ( idx =  9 name = `September` )
        ( idx = 10 name = `October` )
        ( idx = 11 name = `November` )
        ( idx = 12 name = `December` )
    ).

    SPLIT iv_date AT ' ' INTO DATA(s_day) DATA(s_month) DATA(s_year).

    IF strlen( s_month ) > 2.
        READ TABLE m_names WITH KEY name = s_month INTO DATA(single).
        IF sy-subrc = 0.
            s_month = single-idx.
        ELSE.
            lcl_helper_class=>r_output = `No such month.`.
            RETURN.
        ENDIF.
    ENDIF.

    TRY.
        day = s_day.
        month = s_month.
        year = s_year.
        lcl_helper_class=>r_output = s_year && s_month && s_day.
        rv_result = year && month && day.
    CATCH CX_SY_CONVERSION_ERROR.
        lcl_helper_class=>r_output =  `Conversion error.`.
        RETURN.
    ENDTRY.

  ENDMETHOD.


  METHOD zif_abap_course_basics~fizz_buzz.

    CONSTANTS how_many TYPE i VALUE 100.

    DATA: counter TYPE i VALUE 1,
          iv_result TYPE string VALUE '',
          digit TYPE i.

    DO how_many TIMES.
        IF counter > 9.
            digit = counter DIV 10.
            CASE digit.
                WHEN 3.
                    iv_result = iv_result && 'Fizz'.
                WHEN 5.
                    iv_result = iv_result && 'Buzz'.
                WHEN OTHERS.
                    iv_result = iv_result && digit.
            ENDCASE.
        ENDIF.

        digit = counter MOD 10.
        CASE digit.
            WHEN 3.
                iv_result = iv_result && 'Fizz'.
            WHEN 5.
                iv_result = iv_result && 'Buzz'.
            WHEN OTHERS.
                iv_result = iv_result && digit.
        ENDCASE.

        counter = counter + 1.

    ENDDO.

    RETURN iv_result.

  ENDMETHOD.


  METHOD zif_abap_course_basics~get_current_date_time.

  GET TIME STAMP FIELD DATA(lv_timestamp).

  CONVERT TIME STAMP lv_timestamp TIME ZONE 'EET' INTO
        DATE lcl_helper_class=>cdate TIME lcl_helper_class=>ctime.

  RETURN lv_timestamp.

  ENDMETHOD.


  METHOD zif_abap_course_basics~hello_world.

     RETURN | 'Hello { IV_NAME }, your system user id is <{ sy-uname }>'|.
  ENDMETHOD.


  METHOD zif_abap_course_basics~internal_tables.
  ENDMETHOD.


  METHOD zif_abap_course_basics~open_sql.
  ENDMETHOD.


  METHOD zif_abap_course_basics~scrabble_score.

    DATA: codeA TYPE i,
          code TYPE i,
          index TYPE i,
          len TYPE i,
          ch TYPE c.

    DATA(lo_conv) = cl_abap_conv_codepage=>create_out( ).
    codeA = lo_conv->convert( 'A' ).

    len = strlen( iv_word ).

    DO len TIMES.
        ch = iv_word+index(1).
        IF ch >= 'A' AND ch <= 'Z' OR ch >= 'a' AND ch <= 'z'.
          code = lo_conv->convert( substring( val = iv_word off = index len = 1 ) ).
          rv_result = rv_result + code - codeA + 1.
        ENDIF.
        ADD 1 TO index.
    ENDDO.

    RETURN rv_result.

  ENDMETHOD.


ENDCLASS.
