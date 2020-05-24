--1 step to create(and run!!) a row as a class 
CREATE TYPE actual_caller_info_row AS OBJECT (
    operator_911  VARCHAR2(200),
    witness       VARCHAR2(200),
    call_begin    TIMESTAMP,
    title         VARCHAR2(128)
);


--2 step to create(and run after 1 step!) a table as a class, it inherits the class row
CREATE TYPE actual_caller_info_table IS
    TABLE OF actual_caller_info_row;


--3 step to create function only!! after running steps 1 and 2 
CREATE FUNCTION actual_caller_info (
    operator_name  VARCHAR2,
    witness_name   VARCHAR2
) RETURN actual_caller_info_table AS
    result_table actual_caller_info_table := actual_caller_info_table();
BEGIN
    FOR my_cursor IN (
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
                            AND table2.name = witness_name
                    ) 
    LOOP
        result_table.extend;
        result_table(result_table.last) := actual_caller_info_row(my_cursor.operator_911, my_cursor.witness, my_cursor.call_begin, my_cursor.title );

    END LOOP;

    RETURN result_table;
END;
