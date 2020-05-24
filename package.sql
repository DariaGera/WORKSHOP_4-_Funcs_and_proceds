CREATE PACKAGE call_911_pkg IS
    
    TYPE actual_caller_info_row IS RECORD (
        operator_911  person.name%type,
        witness       person.name%type,
        call_begin    call_911.call_begin%type,
        title         witness_accident.title%type
    );
    
    TYPE actual_caller_info_table IS
        TABLE OF actual_caller_info_row;
    
    FUNCTION actual_caller_info (
        operator_name  VARCHAR2,
        witness_name   VARCHAR2
    ) RETURN actual_caller_info_table
    PIPELINED;

    PROCEDURE updating_time_procedure (
        operator_name  IN   person.name%TYPE,
        witness_name   IN   person.name%TYPE,
        result_out     OUT  VARCHAR2
    );
END call_911_pkg;


CREATE PACKAGE BODY call_911_pkg IS

    FUNCTION actual_caller_info (
        operator_name  VARCHAR2,
        witness_name   VARCHAR2
    ) RETURN actual_caller_info_table
    PIPELINED
    IS
        CURSOR my_cursor IS
                                SELECT
                                    table1.name    AS operator_911,
                                    table2.name    AS witness,
                                    table1.call_begin,
                                    witness_accident.title
                                FROM
                                         (
                                        SELECT
                                            call_911.witness_id,
                                            person.name,
                                            call_911.call_begin,
                                            call_911.operator_pass_id
                                        FROM
                                                 call_911
                                            JOIN person ON call_911.operator_pass_id = person.passport_id
                                    ) table1
                                    JOIN witness_accident ON witness_accident.witness_id = table1.witness_id
                                    JOIN (
                                        SELECT
                                            person.name,
                                            phone_owner.phone_number,
                                            phone_owner.status,
                                            phone_owner.data_own
                                        FROM
                                                 phone_owner
                                            JOIN person ON person.passport_id = phone_owner.passport_id
                                    ) table2 ON table2.phone_number = witness_accident.phone_number
                                WHERE
                                        table2.status = 1
                                    AND table1.call_begin >= table2.data_own
                                    AND table1.name = operator_name
                                    AND table2.name = witness_name;  
    BEGIN                         
        FOR one_row IN my_cursor
            LOOP
                PIPE ROW(one_row);
            END LOOP;
    END;

    PROCEDURE updating_time_procedure (
        operator_name  IN   person.name%TYPE,
        witness_name   IN   person.name%TYPE,
        result_out     OUT  VARCHAR2
    ) IS

        call_beginin       call_911.call_begin%TYPE;
        call_endin         call_911.call_end%TYPE;
        operator_911       person.name%TYPE;
        witness            person.name%TYPE;
        operator_pass_id_  person.passport_id%TYPE;
    BEGIN
        SELECT
            table1.name    AS operator_911,
            table2.name    AS witness,
            table1.call_begin,
            table1.operator_pass_id
        INTO
            operator_911,
            witness,
            call_beginin,
            operator_pass_id_
        FROM
                 (
                SELECT
                    call_911.witness_id,
                    person.name,
                    call_911.call_begin,
                    call_911.operator_pass_id
                FROM
                         call_911
                    JOIN person ON call_911.operator_pass_id = person.passport_id
                WHERE
                    call_end IS NULL
            ) table1
            JOIN witness_accident ON witness_accident.witness_id = table1.witness_id
            JOIN (
                SELECT
                    person.name,
                    phone_owner.phone_number,
                    phone_owner.status
                FROM
                         phone_owner
                    JOIN person ON person.passport_id = phone_owner.passport_id
            ) table2 ON table2.phone_number = witness_accident.phone_number
        WHERE
                table2.status = 1
            AND table1.name = operator_name
            AND table2.name = witness_name;

        IF ( operator_911 != witness ) THEN
            UPDATE call_911
            SET
                call_end = sysdate
            WHERE
                    call_911.operator_pass_id = operator_pass_id_
                AND call_911.call_end IS NULL
                AND call_911.call_begin = call_beginin;

            result_out := 'was modified: '|| operator_911|| ' | '|| witness|| ' | '|| call_beginin|| ' | ';

        END IF;

    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('Error: no users is found');
    END;

END call_911_pkg;