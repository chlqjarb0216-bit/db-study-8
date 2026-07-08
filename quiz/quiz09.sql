--1.
--Professor 테이블에서 201번 학과 교수들의 이름과 급여, bonus , 총 연봉을 아래와 같이 출력하세요. 단 총 연봉은 (pay*12+bonus) 로 계산하고 bonus 가 없는 교수는 0으로 계산하세요.
SELECT PROFNO,
       NAME,
       PAY,
       BONUS,
       to_char(PAY * 12 + NVL(BONUS, 0),'999,999,999') TOTAL    --형식숫자가 커지면 그에 맞춰서 늘려야하나?
                                                                --문자열포매팅방식으론 그렇다. 정규식 등 다른방식 존재.
                                                                --하지만 데이터베이스쪽에서 굳이 필요한 기능은 아닌듯
FROM PROFESSOR
WHERE DEPTNO = 201;


--2.
--아래 화면과 같이 emp 테이블에서 deptno 가 30 번인 사원들을 조회하여 comm 값이 있을 경우 'Exist' 을 출력하고 comm 값이 null 일 경우 'NULL' 을 출력하세요.
SELECT EMPNO,
       ENAME,
       COMM,
       NVL2(COMM, 'Exist', 'NULL') NVL2
FROM EMP
WHERE DEPTNO = 30;