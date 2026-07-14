/*
참조 테이블 : panmae, pdoduct, gift
출력 데이터 : 상품명, 상품가, 구매수량, 총금액,
적립포인트, 새해2배적립포인트, 사은품명, 포인트 범위

- panmae 테이블을 기준으로 포인트를 보여준다.
- 포인트는 구매한 금액 1원당 100의 포인트를 부여한다.
(단, 01월 01인 경우는 새해 이벤트로 인해 1원당 200의 포인트를 부여한다.)
- 적립포인트와 새해2배적립포인트를 모두 보여준다.
(이 경우, 이벤트 날인 01월 01일을 제외하고는 포인트가 동일 할 것이다.)
- 새해2배적립포인트를 기준으로 해당 포인트 기준으로 받을수 있는 사은품을 보여준다.
- 사은품 명 옆에 해당 사은품을 받을 수 있는 포인트의 범위를 함께 보여준다.

* 출력 양식과 컬럼 헤더에 표기되는 이름 확인!
*/
SELECT TO_CHAR( TO_DATE( PM.P_DATE, 'YYYYMMDD' ), 'YYYY-MM-DD' ) 판매일자,
       PM.P_CODE                                                상품코드,
       PD.P_NAME                                                상품명,
       TO_CHAR( PD.P_PRICE, 'FM999,999' )                        상품가,
       PM.P_QTY                                                 구매수량,
       TO_CHAR( PD.P_PRICE * PM.P_QTY, 'FM999,999,999' )         총금액,
       TO_CHAR( PD.P_PRICE * PM.P_QTY * 100, 'FM999,999,999' )   적립포인트,
       TO_CHAR(
           DECODE(
               TO_CHAR( TO_DATE( PM.P_DATE, 'YYYYMMDD' ), 'MMDD' ),
               TO_CHAR( TO_DATE( '20110101', 'YYYYMMDD' ), 'MMDD' ),
               PD.P_PRICE * PM.P_QTY * 200,
               PD.P_PRICE * PM.P_QTY * 100
           ),
           'FM999,999,999'
       )                                                         새해2배적립포인트,
       G.GNAME                                                  사은품명,
       TO_CHAR( G.G_START, 'FM999,999,999' )                     포인트START,
       TO_CHAR( G.G_END, 'FM999,999,999' )                       포인트END
FROM PANMAE  PM,
     PRODUCT PD,
     GIFT    G
WHERE PM.P_CODE = PD.P_CODE
      AND DECODE(
    TO_CHAR( TO_DATE( PM.P_DATE, 'YYYYMMDD' ), 'MMDD' ),
    TO_CHAR( TO_DATE( '20110101', 'YYYYMMDD' ), 'MMDD' ),
    PD.P_PRICE * PM.P_QTY * 200,
    PD.P_PRICE * PM.P_QTY * 100
)BETWEEN G.G_START AND G.G_END
ORDER BY PM.P_DATE,
         PM.P_CODE ASC;