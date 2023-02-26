/********************************************************************************************************
********************************************** INSERT SCRIPT ***********************************************
*********************************************************************************************************/

INSERT INTO db_campus (
    campus_id,
    campus_street,
    campus_postcode, 
    campus_city
)
    VALUES (
        '&campus_id',
        '&campus_street',
        '&campus_postcode', 
        '&campus_city'
    );

COMMIT;
---------------------------------------------------------------------------------------------------------
INSERT INTO db_building (
    building_id,
    campus_id
)
    VALUES (
        '&building_id',
        '&campus_id'
    );

COMMIT;
---------------------------------------------------------------------------------------------------------
INSERT INTO db_department (
    department_id,
    department_name,
    department_phone,
    building_id
)
    VALUES (
        '&department_id',
        '&department_name',
        '&department_phone',
        '&building_id'
    );

COMMIT;
---------------------------------------------------------------------------------------------------------
INSERT INTO db_qualification (
    qualification_id,
    qualification_name
)
    VALUES (
        '&qualification_id',
        '&qualification_name'
    );

COMMIT;
---------------------------------------------------------------------------------------------------------
INSERT INTO db_staff (
    staff_id,
    staff_first_name,
    staff_last_name,
    staff_employment_start,
    staff_phone_extension,
    staff_office_number,
    staff_gender,
    staff_salary,
    staff_position,
    staff_highest_qualification,
    department_id
)
    VALUES (
        '&staff_id',
        '&staff_first_name',
        '&staff_last_name',
        TO_DATE('&staff_employment_start', 'dd-mm-yyyy'),
        '&staff_phone_extension',
        '&staff_office_number',
        UPPER('&staff_gender'),
        '&staff_salary',
        '&staff_position',
        '&staff_highest_qualification',
        '&department_id'
    );

COMMIT;
---------------------------------------------------------------------------------------------------------
INSERT INTO db_programme (
    programme_code,
    programme_name,
    programme_level,
    programme_points,
    programme_duration_years,
    campus_id,
    department_id,
    staff_id
)
    VALUES (
        UPPER('&programme_code'),
        '&programme_name',
        '&programme_level',
        '&programme_points',
        '&programme_duration_years',
        '&campus_id',
        '&department_id',
        '&staff_id'
    );

COMMIT;
---------------------------------------------------------------------------------------------------------
INSERT INTO db_semester (
    semester_code
)
    VALUES (
        '&semester_code'
    );
    
COMMIT;
---------------------------------------------------------------------------------------------------------
INSERT INTO db_student (
    student_id,
    student_first_name,
    student_last_name,
    student_street,
    student_postcode,
    student_city,
    student_phone,
    student_date_of_birth,
    student_gender,
    student_loan,
    programme_code
)
    VALUES (
        '&student_id',
        '&student_first_name',
        '&student_last_name',
        '&student_street',
        '&student_postcode',
        '&student_city',
        '&student_phone',
        TO_DATE('&student_date_of_birth', 'dd-mm-yyyy'),
        UPPER('&student_gender'),
        UPPER('&student_loan'),
        UPPER('&programme_code')
    );
    
COMMIT;
---------------------------------------------------------------------------------------------------------
INSERT INTO db_nextkin (
    nextkin_id,
    nextkin_first_name,
    nextkin_last_name,
    nextkin_street,
    nextkin_postcode,
    nextkin_city,
    nextkin_phone,
    nextkin_relationship,
    student_id
) 
    VALUES (
        '&nextkin_id',
        '&nextkin_first_name',
        '&nextkin_last_name',
        '&nextkin_street',
        '&nextkin_postcode',
        '&nextkin_city',
        '&nextkin_phone',
        '&nextkin_relationship',
        '&student_id'
    );

COMMIT;
---------------------------------------------------------------------------------------------------------
INSERT INTO db_course (
    course_code,
    course_name,
    course_credit,
    staff_id
)
    VALUES (
        '&course_code',
        '&course_name',
        '&course_credit',
        '&staff_id'
    );

COMMIT;
---------------------------------------------------------------------------------------------------------
INSERT INTO db_head_of_department (
    department_id,
    staff_id,
    head_start_date
)
    VALUES (
        '&department_id',
        '&staff_id',
        TO_DATE('&head_start_date', 'dd-mm-yyyy'),
        TO_DATE('&head_end_date', 'dd-mm-yyyy')
    );

COMMIT;
---------------------------------------------------------------------------------------------------------
INSERT INTO db_staff_schedule (
    staff_id,
    course_code,
    timesheet_date_start,
    timesheet_date_end,
    timesheet_hours
)
    VALUES (
        '&staff_id',
        '&course_code',
        TO_DATE('&timesheet_date_start', 'dd-mm-yyyy'),
        TO_DATE('&timesheet_date_end', 'dd-mm-yyyy'),
        '&timesheet_hours'
    );

COMMIT;
---------------------------------------------------------------------------------------------------------
INSERT INTO db_course_list (
    programme_code,
    course_code,
    semester_code
)
    VALUES (
        '&programme_code',
        '&course_code',
        '&semester_code'
    );

COMMIT;
---------------------------------------------------------------------------------------------------------
INSERT INTO db_course_result (
    student_id,
    course_code,
    semester_code,
    course_grade
)
    VALUES (
        '&student_id',
        '&course_code',
        '&semester_code',
        '&course_grade'
    );

COMMIT;
---------------------------------------------------------------------------------------------------------