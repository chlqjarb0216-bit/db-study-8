--1.
SELECT 
    name AS 이름,
    SUBSTR(birthday, 1, 2) AS 년도,
    SUBSTR(birthday, 4, 2) AS 월,
    SUBSTR(birthday, 7, 2) AS 일
FROM student;


--2.
SELECT 
    name AS 이름,
    TEL,
    INSTR(tel, ')')
FROM student
WHERE deptno1 = 201;


--3.
SELECT 
    name,
    tel,
    INSTR(tel, 3) 첫3위치
FROM student
WHERE deptno1 = 101;


--4.
SELECT 
    name,
    tel,
    SUBSTR(tel, 1, INSTR(tel, ')')-1) 지역번호
FROM student
WHERE deptno1 = 201;