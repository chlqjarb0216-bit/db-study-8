-- 연결 연산자 연습 문제1:
SELECT
    name || '''s ID : ' || id || ', WEIGHT is ' || weight || 'Kg' AS "ID AND WEIGHT"
FROM student;


-- 연결 연산자 연습 문제2:
SELECT
    ename || '(' || job || '), ' || ename || q'[']' || job || q'[']' AS "NAME AND JOB"
FROM emp;


-- 연결 연산자 연습 문제3:
SELECT
    ename || '''s sal is $' || sal AS "Name and Sal"
FROM emp;