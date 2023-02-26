/********************************************************************************************************
********************************************* OTHER SCRIPT **********************************************
*********************************************************************************************************/

SELECT * FROM db_campus;
SELECT * FROM db_building;
SELECT * FROM db_department;
SELECT * FROM db_qualification;
SELECT * FROM db_staff;
SELECT * FROM db_programme;
SELECT * FROM db_semester;
SELECT * FROM db_student;
SELECT * FROM db_nextkin;
SELECT * FROM db_course;
SELECT * FROM db_head_of_department;
SELECT * FROM db_staff_schedule;
SELECT * FROM db_course_list;
SELECT * FROM db_course_result;

DROP TABLE db_course_result CASCADE CONSTRAINTS;
SELECT COUNT(*) FROM db_course_result;
TRUNCATE TABLE db_course_result;
COMMIT;
ROLLBACK;

DELETE FROM db_staff WHERE staff_id = 'stf_000001';
ALTER TABLE db_staff RENAME COLUMN staff_highest_qualification TO qualification_id;
ALTER TABLE db_staff ADD CONSTRAINT db_staff_qualification_id_fk FOREIGN KEY(qualification_id) REFERENCES db_qualification (qualification_id);
SELECT table_name FROM user_tables ORDER BY table_name;