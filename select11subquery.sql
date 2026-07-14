/**********------------------*/
서브쿼리 (Sub-Query)

SELECT  (쿼리: 스칼라 서브쿼리)
FROM    (쿼리: 인라인 뷰)
WHERE   (쿼리: 서브쿼리)
;

SELECT * FROM emp;

20번 부서 사람들만 조회
SELECT * FROM emp
WHERE deptno=20
;

사번이 7844인 사원과 같은 부서 사람들 조회

SELECT * FROM emp
WHERE deptno=30;    --직접 데이터 확인 -> 부서번호 하드코딩


SELECT * FROM emp
WHERE deptno=(SELECT deptno FROM emp
            WHERE empno=7844);

SELECT deptno FROM emp       --7844사번을 가진 사원의 부서번호
WHERE empno=7844;



------------------------
SELECT * FROM emp2;
SELECT * FROM dept2;

포항 사무실에서 일하는 직원 목록 조회

SELECT * FROM dept2
WHERE area='Pohang Main Office';


-- JOIN
SELECT *
FROM emp2 e, dept2 d
WHERE e.deptno=d.dcode
AND d.area='Pohang Main Office';

-- 서브쿼리
SELECT *
FROM emp2
WHERE deptno IN (SELECT dcode 
                FROM dept2
                WHERE area='Pohang Main Office');

IN ('0001', '1003', '1006', '1007')


0001번팀을 제외하고 포항 사무실에서 일하는 직원 목록 조회

SELECT *
FROM emp2
WHERE deptno IN (SELECT dcode 
                FROM dept2
                WHERE area='Pohang Main Office'
                AND dcode<>'0001');
                
SELECT *
FROM emp2
WHERE deptno IN (SELECT dcode 
                FROM dept2
                WHERE area='Pohang Main Office')
AND deptno<>'0001';


-----------------------------
SELECT *
FROM emp2
WHERE deptno IN (SELECT dcode 
                FROM dept2
                WHERE area='Pohang Main Office'
                AND dcode=deptno);
                
SELECT *
FROM emp2
WHERE EXISTS (SELECT dcode 
                FROM dept2
                WHERE area='Pohang Main Office'
                AND dcode=deptno);
                
SELECT *
FROM emp2 e2
WHERE EXISTS (SELECT dcode 
                FROM dept2
                WHERE area='Pohang Main Office'
                AND dcode=e2.deptno);
                
            SELECT dcode 
                FROM dept2
                WHERE area='Pohang Main Office'
                AND dcode='1002';
                
----------------------------------
학생 student

> 학번 9513 학생보다 키 작은 학생들 조회

SELECT * 
FROM student
WHERE height<(SELECT height
                FROM student
                WHERE studno=9513);

> 2학년 학생들 기준 제일 많은 몸무게보다 (2학년 학생중 제일 무거운 학생의 몸무게) 보다
  전체학생들 중에서 더 많은 몸무게 나가는 학생 목록 조회

SELECT *
FROM student
WHERE weight>(SELECT MAX(weight)
                FROM student
                WHERE grade=2);
                
                
---- 각 학년별로 가장 큰 몸무게
SELECT *
FROM student
WHERE weight < ANY (SELECT MAX(weight)
                    FROM student
                    GROUP BY grade)
;
    ANY ALL
    
    < ANY 83          (81  82  83 58)
    < ALL 58
    > ANY 58
    > ALL 83


>> 단일행 비교   =   IN
>> 다중행 비교   IN, NOT IN, >ANY ALL
>> 다중컬럼 비교  (컬럼수를 맞춰서 비교)

---- 각 학년별로 가장 큰 몸무게

--  학년, 몸무게
SELECT *
FROM student
WHERE weight IN (   --몸무게만 비교하면, 학년별 최대 몸무게 학생 추출에 문제 발생 가능성 있음
                SELECT MAX(weight)
                FROM student
                GROUP BY grade);

SELECT *
FROM student
WHERE (grade, weight) IN (SELECT grade, MAX(weight)
                            FROM student
                            GROUP BY grade);
                            
                            
--emp2 기준   전체 평균급여보다 많이 받는 직원 조회

SELECT *
FROM emp2
WHERE pay>(SELECT AVG(pay)
            FROM emp2);
            
--emp2 기준   각자, 자신과 같은 직급(position)의 평균 급여보다 많이 받는 직원 조회

SELECT *
FROM emp2 e
WHERE pay>(SELECT AVG(pay)
            FROM emp2 e_
            WHERE e_.position=e.position);
            
            
----emp2 기준 자신과 같은 고용형태(emp_type)의 평균 급여보다 적게 받는 직원목록 조회.

SELECT *
FROM emp2 A
WHERE pay < (--emptype 같은 평균급여
            SELECT AVG(pay)
            FROM emp2 B
            WHERE B.emp_type=A.emp_type);
            
            
/*****************************************/





--SUBQUERY
SELECT
    e.name,
    e.deptno,
    (SELECT dname
        FROM dept2
        WHERE dcode=e.deptno) dname
FROM emp2 e;

SELECT dname
FROM dept2
WHERE dcode='1007';


SELECT * FROM panmae;
SELECT * FROM product;

--JOIN
SELECT 
    A.p_date,
    A.p_code,
    B.p_name
FROM panmae A, product B
WHERE A.p_code=B.p_code;

--Subquery
SELECT 
    a.p_date,
    a.p_code,
    (SELECT p_name
        FROM product
        WHERE p_code=a.p_code) 상품명
FROM panmae A;



/***************************************/

SELECT job, mgr, sal, comm, deptno
from emp;


SELECT empno, ename, job --sal from 절에 속해있는 select 결과를 테이블(뷰)로 간주
from (
    SELECT empno, ename, job
    --select *
    FROM emp)
;

--SELECT empno, ename, job
SELECT enum, emp_name, jjb
from (
    SELECT  --컬럼 별칭을 설정하면 외부에서 조회시 기본 컬럼명으로 인식
        empno enum, 
        ename emp_name, 
        job jjb
    FROM emp)
;


SELECT *
FROM (
    SELECT e.empno, e.name, e.deptno, d.dname
    FROM emp2 e, dept2 d
    WHERE e.deptno=d.dcode);
    
    
    
----emp2 기준 자신과 같은 고용형태(emp_type)의 평균 급여보다 적게 받는 직원목록 조회.

--SELECT AVG(PAY) --함수로 인식되서 컬럼선택 불가
--SELECT "AVG(PAY)"   --문자열로 인식시키면 가능
--SELECT emp_type, avg_pay
SELECT *
FROM 
    emp2 A,
    (
    SELECT emp_type, AVG(pay) avg_pay
    FROM emp2
    GROUP BY emp_type
    ) B
WHERE A.emp_type=B.emp_type
AND A.pay<B.avg_pay;