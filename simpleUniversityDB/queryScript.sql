/********************************************************************************************************
********************************************* QUERY SCRIPT **********************************************
*********************************************************************************************************/

--Query 1 Department:
SELECT
    stf.department_id AS "Dept. ID",
    dpt.department_name AS "Dept. Name",
    hod.staff_id AS "Head of Department",
    COUNT(stf.department_id) AS "Dept. Size",
    SUM(stf.staff_salary) AS "Yearly Wage",
    ROUND(AVG(stf.staff_salary),0) AS "Average Wage",
    MAX(stf.staff_salary) AS "Maximum Wage",
    MIN(stf.staff_salary) AS "Minimum Wage"
FROM
    db_staff stf,
    db_department dpt,
    db_head_of_department hod
WHERE stf.department_id = dpt.department_id
    AND dpt.department_id = hod.department_id
    AND hod.head_end_date IS NULL
GROUP BY
    stf.department_id,
    dpt.department_name,
    hod.staff_id
ORDER BY
    stf.department_id;

--Query 2 Staff:
SELECT
    stf.staff_id AS "ID",
    stf.staff_first_name || ' ' || stf.staff_last_name AS "Staff Name",
    qual.qualification_name AS "Qualification",
    dpt.department_name AS "Department",
    blg.building_id AS "Building",
    stf.staff_position AS "Position",
    stf.staff_salary AS "Salary",
    SUM(sch.timesheet_hours) AS "Total Hours Worked"
FROM
    db_staff stf,
    db_qualification qual,
    db_department dpt,
    db_building blg,
    db_staff_schedule sch
WHERE stf.staff_id = sch.staff_id
    AND stf.qualification_id = qual.qualification_id
    AND stf.department_id = dpt.department_id
    AND dpt.building_id = blg.building_id
GROUP BY
    stf.staff_id,
    stf.staff_first_name || ' ' || stf.staff_last_name,
    qual.qualification_name,
    dpt.department_name,
    blg.building_id,
    stf.staff_position,
    stf.staff_salary
HAVING
    stf.staff_salary >= '&minimum_salary'
ORDER BY
    SUM(sch.timesheet_hours) DESC;

--Query 3 Student:
SELECT
    crs_rlt.student_id AS "ID",
    stu.student_first_name || ' ' || stu.student_last_name AS "Student Full Name",
    prg.programme_name AS "Programme",
    crs.course_name AS "Course",
    crs_rlt.semester_code AS "Semester",
    crs_rlt.course_grade AS "Grade"
FROM
    db_course_result crs_rlt,
    db_student stu,
    db_programme prg,
    db_course crs
WHERE stu.student_id = crs_rlt.student_id
    AND stu.programme_code = prg.programme_code
    AND crs_rlt.course_code = crs.course_code
    AND crs_rlt.student_id = LOWER('&student_id')
ORDER BY crs_rlt.course_grade DESC;

--Query 4 Course:
SELECT
    stu.programme_code AS "Programme Code",
    crs_rlt.course_code AS "Course Code",
    crs.course_name AS "Course Name",
    stf.staff_first_name || ' ' || stf.staff_last_name AS "Coordinator",
    COUNT(crs_rlt.course_grade) AS "Students Enrolled",
    ROUND(AVG(crs_rlt.course_grade),2) AS "Average Grade",
    ROUND(MAX(crs_rlt.course_grade),2) AS "Highest Grade",
    ROUND(MIN(crs_rlt.course_grade),2) AS "Lowest Grade"
FROM
    db_course_result crs_rlt,
    db_course crs,
    db_staff stf,
    db_student stu
WHERE
    crs_rlt.course_code = crs.course_code
    AND stf.staff_id = crs.staff_id
    AND stu.student_id = crs_rlt.student_id
    AND stu.programme_code = UPPER('&programme_code')
GROUP BY
    stu.programme_code,
    crs_rlt.course_code,
    crs.course_name,
    stf.staff_first_name || ' ' || stf.staff_last_name
ORDER BY
    stu.programme_code ASC,
    crs_rlt.course_code ASC;

--Query 5 Programme:
SELECT
    prg.programme_name AS "Programme",
    prg.programme_code AS "Code",
    INITCAP(cmp.campus_id) AS "Campus",
    prg.programme_level AS "Level",
    prg.programme_points AS "Points",
    prg.programme_duration_years AS "Duration (Years)",
    COUNT(crs_list.course_code) AS "Paper Count",
    dpt.department_name AS "Department",
    stf.staff_first_name || ' ' || stf.staff_last_name AS "Director"
FROM
    db_programme prg,
    db_course_list crs_list,
    db_campus cmp,
    db_department dpt,
    db_staff stf
WHERE prg.programme_code = crs_list.programme_code
    AND prg.campus_id = cmp.campus_id
    AND prg.department_id = dpt.department_id
    AND prg.staff_id = stf.staff_id
GROUP BY
    prg.programme_name,
    prg.programme_level,
    prg.programme_code,
    prg.programme_points,
    prg.programme_duration_years,
    cmp.campus_id,
    dpt.department_name,
    stf.staff_first_name || ' ' || stf.staff_last_name
ORDER BY
    prg.programme_name ASC;