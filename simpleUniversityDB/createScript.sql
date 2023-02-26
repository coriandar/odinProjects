/********************************************************************************************************
********************************************* TABLE SCRIPT **********************************************
*********************************************************************************************************/

CREATE TABLE db_campus (
    campus_id VARCHAR2(10),
    campus_street VARCHAR2(50) CONSTRAINT db_campus_street_nn NOT NULL,
    campus_postcode VARCHAR2(4) CONSTRAINT db_campus_postcode_nn NOT NULL,
    campus_city VARCHAR2(30) CONSTRAINT db_campus_city_nn NOT NULL,
    CONSTRAINT db_campus_campus_id_pk PRIMARY KEY(campus_id)
);

CREATE TABLE db_building (
    building_id VARCHAR2(10),
    campus_id VARCHAR2(10),
    CONSTRAINT db_building_building_id_pk PRIMARY KEY(building_id),
    CONSTRAINT db_building_campus_id_fk FOREIGN KEY(campus_id) REFERENCES db_campus (campus_id)
);

CREATE TABLE db_department (
    department_id VARCHAR2(10),
    department_name VARCHAR2(30) CONSTRAINT db_department_name_nn NOT NULL,
    department_phone VARCHAR2(20) CONSTRAINT db_department_phone_nn NOT NULL,
    building_id VARCHAR2(10),
    CONSTRAINT db_department_department_id_pk PRIMARY KEY(department_id),
    CONSTRAINT db_department_building_id_fk FOREIGN KEY(building_id) REFERENCES db_building (building_id)
);

CREATE TABLE db_qualification (
    qualification_id VARCHAR2(10),
    qualification_name VARCHAR2(100) CONSTRAINT db_qualification_name_nn NOT NULL,
    CONSTRAINT db_qualification_qualification_id_pk PRIMARY KEY(qualification_id)
);

CREATE TABLE db_staff (
    staff_id VARCHAR2(10),
    staff_first_name VARCHAR2(30) CONSTRAINT db_staff_first_name_nn NOT NULL,
    staff_last_name VARCHAR2(30) CONSTRAINT db_staff_last_name_nn NOT NULL,
    staff_employment_start DATE,
    staff_phone_extension VARCHAR2(4),
    staff_office_number NUMBER(3),
    staff_gender CHAR(1),
    staff_salary NUMBER(8,2) CONSTRAINT db_staff_salary_nn NOT NULL,
    staff_position VARCHAR2(30) CONSTRAINT db_staff_position_nn NOT NULL,
    qualification_id VARCHAR2(30),
    department_id VARCHAR2(10),
    CONSTRAINT db_staff_staff_id_pk PRIMARY KEY(staff_id),
    CONSTRAINT db_staff_qualification_id_fk FOREIGN KEY(qualification_id) REFERENCES db_qualification (qualification_id),
    CONSTRAINT db_staff_department_id_fk FOREIGN KEY(department_id) REFERENCES db_department (department_id),
    CONSTRAINT db_staff_salary_min CHECK (staff_salary > 0)
);

CREATE TABLE db_programme (
    programme_code VARCHAR2(10),
    programme_name VARCHAR2(100) CONSTRAINT db_programme_name_nn NOT NULL,
    programme_level NUMBER(2),
    programme_points NUMBER(3),
    programme_duration_years NUMBER(2),
    campus_id VARCHAR2(10),
    department_id VARCHAR2(10),
    staff_id VARCHAR2(10),
    CONSTRAINT db_programme_programme_code_pk PRIMARY KEY(programme_code),
    CONSTRAINT db_programme_campus_id_fk FOREIGN KEY(campus_id) REFERENCES db_campus (campus_id),
    CONSTRAINT db_programme_department_id_fk FOREIGN KEY(department_id) REFERENCES db_department (department_id),
    CONSTRAINT db_programme_staff_id_fk FOREIGN KEY(staff_id) REFERENCES db_staff (staff_id)
);

CREATE TABLE db_semester (
    semester_code VARCHAR2(10),
    CONSTRAINT db_semester_semester_code_pk PRIMARY KEY(semester_code)
);

CREATE TABLE db_student (
    student_id VARCHAR2(10),
    student_first_name VARCHAR2(30) CONSTRAINT db_student_first_name_nn NOT NULL,
    student_last_name VARCHAR2(30) CONSTRAINT db_student_last_name_nn NOT NULL,
    student_street VARCHAR2(50),
    student_postcode VARCHAR2(4),
    student_city VARCHAR2(30),
    student_phone VARCHAR2(20),
    student_date_of_birth DATE,
    student_gender CHAR(1),
    student_loan CHAR(1),
    programme_code VARCHAR2(10),
    CONSTRAINT db_student_student_id_pk PRIMARY KEY(student_id),
    CONSTRAINT db_student_programme_code_fk FOREIGN KEY(programme_code) REFERENCES db_programme (programme_code)
);

CREATE TABLE db_nextkin (
    nextkin_id VARCHAR2(10),
    nextkin_first_name VARCHAR2(30) CONSTRAINT db_nextkin_first_name_nn NOT NULL,
    nextkin_last_name VARCHAR2(30) CONSTRAINT db_nextkin_last_name_nn NOT NULL,
    nextkin_street VARCHAR2(50),
    nextkin_postcode VARCHAR2(4),
    nextkin_city VARCHAR2(30),
    nextkin_phone VARCHAR2(20) CONSTRAINT db_nextkin_phone_nn NOT NULL,
    nextkin_relationship VARCHAR2(30) CONSTRAINT db_nextkin_relationship_nn NOT NULL,
    student_id VARCHAR2(10),
    CONSTRAINT db_next_kin_nextkin_id_pk PRIMARY KEY(nextkin_id),
    CONSTRAINT db_next_kin_student_id_fk FOREIGN KEY(student_id) REFERENCES db_student (student_id)
);

CREATE TABLE db_course (
    course_code VARCHAR2(10),
    course_name VARCHAR2(100) CONSTRAINT db_course_name_nn NOT NULL,
    course_credit NUMBER(3) CONSTRAINT db_course_credit_nn NOT NULL,
    staff_id VARCHAR2(10),
    CONSTRAINT db_course_course_code_pk PRIMARY KEY(course_code),
    CONSTRAINT db_course_staff_id_fk FOREIGN KEY(staff_id) REFERENCES db_staff (staff_id)
);

CREATE TABLE db_head_of_department (
    department_id VARCHAR2(10),
    staff_id VARCHAR2(10),
    head_start_date DATE,
    head_end_date DATE,
    CONSTRAINT db_head_head_cpk PRIMARY KEY(staff_id,department_id, head_start_date),
    CONSTRAINT db_head_department_id_fk FOREIGN KEY(department_id) REFERENCES db_department (department_id),
    CONSTRAINT db_head_staff_id_fk FOREIGN KEY(staff_id) REFERENCES db_staff (staff_id),
    CONSTRAINT db_head_end_date CHECK (head_start_date < head_end_date)
);

CREATE TABLE db_staff_schedule (
    staff_id VARCHAR2(10),
    course_code VARCHAR2(10),
    timesheet_date_start DATE,
    timesheet_date_end DATE,
    timesheet_hours NUMBER(5,2),
    CONSTRAINT db_staff_schedule_cpk PRIMARY KEY(staff_id,course_code,timesheet_date_start),
    CONSTRAINT db_staff_schedule_staff_id_fk FOREIGN KEY(staff_id) REFERENCES db_staff (staff_id),
    CONSTRAINT db_staff_schedule_course_code_fk FOREIGN KEY(course_code) REFERENCES db_course (course_code),
    CONSTRAINT db_staff_schedule_date_start_min CHECK (timesheet_date_start < timesheet_date_end),
    CONSTRAINT db_staff_schedule_hours_min CHECK (0 < timesheet_hours)
);

CREATE TABLE db_course_list (
    programme_code VARCHAR2(10),
    course_code VARCHAR2(10),
    semester_code VARCHAR2(10),
    CONSTRAINT db_course_list_cpk PRIMARY KEY(programme_code,course_code,semester_code),
    CONSTRAINT db_course_list_programme_code_fk FOREIGN KEY(programme_code) REFERENCES db_programme (programme_code),
    CONSTRAINT db_course_list_course_code_fk FOREIGN KEY(course_code) REFERENCES db_course (course_code),
    CONSTRAINT db_course_list_semester_code_fk FOREIGN KEY(semester_code) REFERENCES db_semester (semester_code)
);

CREATE TABLE db_course_result (
    student_id VARCHAR2(10),
    course_code VARCHAR2(10),
    semester_code VARCHAR2(10),
    course_grade NUMBER(5,2),
    CONSTRAINT db_course_result_cpk PRIMARY KEY(student_id,course_code,semester_code),
    CONSTRAINT db_course_result_student_id_fk FOREIGN KEY(student_id) REFERENCES db_student (student_id),
    CONSTRAINT db_course_result_course_code_fk FOREIGN KEY(course_code) REFERENCES db_course (course_code),
    CONSTRAINT db_course_result_semester_code_fk FOREIGN KEY(semester_code) REFERENCES db_semester (semester_code),
    CONSTRAINT db_course_result_min CHECK (0 <= course_grade),
    CONSTRAINT db_course_result_max CHECK (course_grade <= 100)
);