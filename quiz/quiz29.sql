--1.
/*
    DELETE FROM 테이블명;
    테이블에서 데이터의 일부 혹은 전체를 삭제하는 명령어.
    
    TRUNCATE TABLE 테이블명;
    테이블 데이터를 백지로 되돌리는 명령어.
    
    DELETE의 경우 해당하는 데이터를 찾아가 삭제하는 코스트가 들어가지만, 
    TRUNCATE의 경우 기존 데이터를 무시하고 새로 공간을 잡는 것에 가깝기 때문에 매우 빠르다.
    
    다만 TRUNCATE의 경우 되돌릴 수가 없다.
*/


--2.
CREATE TABLE T_MEMBER_POINT(
    ID   NUMBER( 6 ),
    순번   NUMBER( 6 ),
    멤버ID VARCHAR2( 24 )NOT NULL,
    점수   NUMBER( 3 ),
    채점일시 DATE DEFAULT SYSDATE,
    CONSTRAINT T_MEMBER_POINT_PK PRIMARY KEY( ID,
                                              순번 )
);


--3.
CREATE SEQUENCE T_MEMBER_POINT_PK_SEQ INCREMENT BY 1 START WITH 1 MAXVALUE 999999 NOCYCLE;


--4.
INSERT INTO T_MEMBER_POINT(
    ID,
    순번,
    멤버ID,
    점수
)VALUES( T_MEMBER_POINT_PK_SEQ.NEXTVAL,
         (
             SELECT COUNT( * )+ 1
             FROM T_MEMBER_POINT
             WHERE 멤버ID = 'A'
         ),
         'A',
         30 );

INSERT INTO T_MEMBER_POINT(
    ID,
    순번,
    멤버ID,
    점수
)VALUES( T_MEMBER_POINT_PK_SEQ.NEXTVAL,
         (
             SELECT COUNT( * )+ 1
             FROM T_MEMBER_POINT
             WHERE 멤버ID = 'B'
         ),
         'B',
         40 );

INSERT INTO T_MEMBER_POINT(
    ID,
    순번,
    멤버ID,
    점수
)VALUES( T_MEMBER_POINT_PK_SEQ.NEXTVAL,
         (
             SELECT COUNT( * )+ 1
             FROM T_MEMBER_POINT
             WHERE 멤버ID = 'C'
         ),
         'C',
         40 );

INSERT INTO T_MEMBER_POINT(
    ID,
    순번,
    멤버ID,
    점수
)VALUES( T_MEMBER_POINT_PK_SEQ.NEXTVAL,
         (
             SELECT COUNT( * )+ 1
             FROM T_MEMBER_POINT
             WHERE 멤버ID = 'A'
         ),
         'A',
         50 );

INSERT INTO T_MEMBER_POINT(
    ID,
    순번,
    멤버ID,
    점수
)VALUES( T_MEMBER_POINT_PK_SEQ.NEXTVAL,
         (
             SELECT COUNT( * )+ 1
             FROM T_MEMBER_POINT
             WHERE 멤버ID = 'B'
         ),
         'B',
         60 );

INSERT INTO T_MEMBER_POINT(
    ID,
    순번,
    멤버ID,
    점수
)VALUES( T_MEMBER_POINT_PK_SEQ.NEXTVAL,
         (
             SELECT COUNT( * )+ 1
             FROM T_MEMBER_POINT
             WHERE 멤버ID = 'A'
         ),
         'A',
         70 );

SELECT *
FROM T_MEMBER_POINT;