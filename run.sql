set serveroutput on;
begin
    dbms_output.enable;
end;
/

DECLARE 
CURSOR curs_for_procedure IS 
                            SELECT
                                table1.name    AS operator_911,
                                table2.name    AS witness,
                                table1.call_begin,
                                table1.call_end
                            FROM
                                     (
                                    SELECT
                                        call_911.witness_id,
                                        person.name,
                                        call_911.call_begin,
                                        call_911.operator_pass_id,
                                        call_911.call_end
                                    FROM
                                             call_911
                                        JOIN person ON call_911.operator_pass_id = person.passport_id
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
                                    table2.status = 1;

CURSOR curs_for_function IS 
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
                            AND table1.call_begin >= table2.data_own;
                            
CURSOR curs_after_func IS 
                        SELECT operator_911, witness, call_begin, title from TABLE(actual_caller_info('Mark Bobanchuk','Boba Smith' ));                                                                                                  
                                                                                                    

out_call_end VARCHAR2(10);   
out1_  varchar2(200);
BEGIN
    dbms_output.put_line('PROOOOCEEEDUUUUREEEEE! ');
    dbms_output.put_line('table before the procedures work ');
    dbms_output.put_line('---------------------------------------------------------------------------------------------------------------------------------------------------------');
    FOR cur_row IN curs_for_procedure
        LOOP
            IF (cur_row.call_end is null) THEN
                out_call_end := '(null)';
                dbms_output.put_line('OPERATOR_NAME: '||cur_row.operator_911||'     WITNESS_NAME: '||cur_row.witness||'     CALL_BEGIN: '||cur_row.call_begin||'     CALL_END: '||out_call_end);
            ELSE
                dbms_output.put_line('OPERATOR_NAME: '||cur_row.operator_911||'     WITNESS_NAME: '||cur_row.witness||'     CALL_BEGIN: '||cur_row.call_begin||'     CALL_END: '||cur_row.call_end);
            END IF;          
        END LOOP;
        
    --using procedure
    updating_time_procedure(
    operator_name => 'Mark Bobanchuk',
    witness_name=>'Boba Smith',
    result_out=>out1_
    );
    dbms_output.put_line('**********');
    dbms_output.put_line('table after the procedures work ');
    dbms_output.put_line('---------------------------------------------------------------------------------------------------------------------------------------------------------');
    FOR cur_row IN curs_for_procedure
        LOOP
            IF (cur_row.call_end is null) THEN
                out_call_end := '(null)';
                dbms_output.put_line('OPERATOR_NAME: '||cur_row.operator_911||'     WITNESS_NAME: '||cur_row.witness||'     CALL_BEGIN: '||cur_row.call_begin||'     CALL_END: '||out_call_end);
            ELSE
                dbms_output.put_line('OPERATOR_NAME: '||cur_row.operator_911||'     WITNESS_NAME: '||cur_row.witness||'     CALL_BEGIN: '||cur_row.call_begin||'     CALL_END: '||cur_row.call_end);
            END IF;          
        END LOOP;    
    
    dbms_output.put_line('');
    dbms_output.put_line('FUUUUNCTIIIIOOOON! ');
    dbms_output.put_line('table before the functions work ');
    dbms_output.put_line('---------------------------------------------------------------------------------------------------------------------------------------------------------');   
    FOR cur_row IN curs_for_function
        LOOP
            dbms_output.put_line('OPERATOR_NAME: '||cur_row.operator_911||'     WITNESS_NAME: '||cur_row.witness||'     CALL_BEGIN: '||cur_row.call_begin||'     TITLE: '||cur_row.title);
        END LOOP;
    
    dbms_output.put_line('**********');
    dbms_output.put_line('table after the functions work ');
    dbms_output.put_line('---------------------------------------------------------------------------------------------------------------------------------------------------------');
    FOR cur_row IN curs_after_func
        LOOP
            dbms_output.put_line('OPERATOR_NAME: '||cur_row.operator_911||'     WITNESS_NAME: '||cur_row.witness||'     CALL_BEGIN: '||cur_row.call_begin||'     TITLE: '||cur_row.title);
        END LOOP;

END;
