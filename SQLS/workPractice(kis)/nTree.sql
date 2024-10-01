

--sys계정
-- **계정생성 <- 관리자계정(sys 관리자 계정)
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
--DROP USER finalPractice;

-- 계정 생성
CREATE USER test
IDENTIFIED BY "test1234";

-- 권한 부여 (CREATE위함)
GRANT CONNECT, RESOURCE, CREATE VIEW TO test;

-- 객체 생성 공간 할당 (INSERT위함)
ALTER USER test 
DEFAULT TABLESPACE SYSTEM
QUOTA UNLIMITED ON SYSTEM;


--------------------------------------------------------------------------------

DROP TABLE WORK;
DROP SEQUENCE SEQ_WORK_NO;


CREATE TABLE WORK (
    WORK_NO NUMBER PRIMARY KEY,
    PARENT_NO NUMBER
);
--DROP TABLE WORK;

CREATE SEQUENCE SEQ_WORK_NO NOCACHE;



COMMIT;



SELECT * FROM WORK 
WHERE PARENT_NO IS NULL;

SELECT WORK_NO FROM WORK 
WHERE PARENT_NO IS NULL;

SELECT WORK_NO FROM WORK 
WHERE PARENT_NO = 
(
SELECT WORK_NO FROM WORK 
WHERE PARENT_NO IS NULL
)
;

SELECT WORK_NO FROM WORK 
WHERE PARENT_NO = (
    SELECT WORK_NO FROM WORK 
    WHERE PARENT_NO = 
    (
        SELECT WORK_NO FROM WORK 
        WHERE PARENT_NO IS NULL
    )
)
;

SELECT WORK_NO FROM WORK 
WHERE PARENT_NO = (
    SELECT WORK_NO FROM WORK 
    WHERE PARENT_NO = (
        SELECT WORK_NO FROM WORK 
        WHERE PARENT_NO = 
        (
            SELECT WORK_NO FROM WORK 
            WHERE PARENT_NO IS NULL
        )
    )
)
;


SELECT WORK_NO FROM WORK 
WHERE PARENT_NO = (
    SELECT WORK_NO FROM WORK 
    WHERE PARENT_NO = (
        SELECT WORK_NO FROM WORK 
        WHERE PARENT_NO = (
            SELECT WORK_NO FROM WORK 
            WHERE PARENT_NO = 
            (
                SELECT WORK_NO FROM WORK 
                WHERE PARENT_NO IS NULL
            )
        )
    )
)
;

SELECT WORK_NO FROM WORK 
WHERE PARENT_NO = (
    SELECT WORK_NO FROM WORK 
    WHERE PARENT_NO = (
        SELECT WORK_NO FROM WORK 
        WHERE PARENT_NO = (
            SELECT WORK_NO FROM WORK 
            WHERE PARENT_NO = (
                SELECT WORK_NO FROM WORK 
                WHERE PARENT_NO = 
                (
                    SELECT WORK_NO FROM WORK 
                    WHERE PARENT_NO IS NULL
                )
            )
        )
    )
)
;

SELECT WORK_NO FROM WORK 
WHERE PARENT_NO = (
    SELECT WORK_NO FROM WORK 
    WHERE PARENT_NO = (
        SELECT WORK_NO FROM WORK 
        WHERE PARENT_NO = (
            SELECT WORK_NO FROM WORK 
            WHERE PARENT_NO = (
                SELECT WORK_NO FROM WORK 
                WHERE PARENT_NO = (
                    SELECT WORK_NO FROM WORK 
                    WHERE PARENT_NO = 
                    (
                        SELECT WORK_NO FROM WORK 
                        WHERE PARENT_NO IS NULL
                    )
                )
            )
        )
    )
)
;





--NULL경우
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, NULL); --1
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 1);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 2);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 3);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 4);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 5); --6

INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, NULL); --7
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 7);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 8);

INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, NULL);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, NULL);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 10);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 11);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 10);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 11);

INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 2);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 3);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 3);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 2);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 2);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 17);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 18);


COMMIT;


--0경우
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 0); --1
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 1);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 2);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 3);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 4);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 5); --6

INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 0); --7
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 7);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 8);

INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 0);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 0);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 10);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 11);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 10);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 11);

INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 2);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 3);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 3);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 2);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 2);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 17);
INSERT INTO WORK VALUES(SEQ_WORK_NO.NEXTVAL, 18);


COMMIT;



SELECT * FROM WORK;

--NULL경우
SELECT 
    LPAD(' ', LEVEL * 2) || WORK_NO , 
    WORK_NO,
    PARENT_NO
FROM 
    WORK
START WITH PARENT_NO IS NULL 
CONNECT BY PRIOR WORK_NO = PARENT_NO 
--ORDER SIBLINGS BY created_at
;

--SELECT 
--    LPAD(' ', LEVEL * 2, WORK_NO) , 
--    WORK_NO,
--    PARENT_NO
--FROM 
--    WORK
--START WITH PARENT_NO IS NULL 
--CONNECT BY PRIOR WORK_NO = PARENT_NO 
----ORDER SIBLINGS BY created_at
--;

SELECT 
    LPAD(WORK_NO, LEVEL * 2, ' ') , 
    WORK_NO,
    PARENT_NO
FROM 
    WORK
START WITH PARENT_NO IS NULL 
CONNECT BY PRIOR WORK_NO = PARENT_NO 
--ORDER SIBLINGS BY created_at
;

SELECT 
    LPAD(WORK_NO, LEVEL * 2, ' ') , 
    WORK_NO,
    PARENT_NO,
    LEVEL
FROM 
    WORK
START WITH PARENT_NO IS NULL 
CONNECT BY PRIOR WORK_NO = PARENT_NO 
--ORDER SIBLINGS BY create_dt
;

SELECT 
LPAD(A.WORK_NO, LEVEL * 2, ' ') , 
    A.WORK_NO, A.WORK_TITLE, A.WORK_CONTENT, 
    TO_CHAR(A.CREATE_DT, 'YYYY-MM-DD') CREATE_DT, TO_CHAR(A.UPDATE_DT, 'YYYY-MM-DD') UPDATE_DT, TO_CHAR(A.DUE_DT, 'YYYY-MM-DD') DUE_DT, 
    A.WORK_PR_ST, A.WORK_PR, A.WORK_MN_NO, A.PARENT_NO, A.PROJECT_NO
    ,USER_NAME, PROFILE_IMG
    ,PROJECT_TITLE
    ,B.WORK_TITLE PARENT_TITLE
    ,LEVEL
FROM 
    WORK A
		LEFT OUTER JOIN "USER" ON A.WORK_MN_NO="USER".USER_NO
		LEFT OUTER JOIN "PROJECT" ON A.PROJECT_NO="PROJECT".PROJECT_NO
		LEFT OUTER JOIN WORK B ON A.PARENT_NO=B.WORK_NO
		WHERE A.PROJECT_NO=1
		AND A.WORK_ST=1
        
START WITH A.PARENT_NO IS NULL 
CONNECT BY PRIOR A.WORK_NO = A.PARENT_NO

;


SELECT 
    A.WORK_NO, A.WORK_TITLE, A.WORK_CONTENT, 
    TO_CHAR(A.CREATE_DT, 'YYYY-MM-DD') CREATE_DT, TO_CHAR(A.UPDATE_DT, 'YYYY-MM-DD') UPDATE_DT, TO_CHAR(A.DUE_DT, 'YYYY-MM-DD') DUE_DT, 
    A.WORK_PR_ST, A.WORK_PR, A.WORK_MN_NO, A.PARENT_NO, A.PROJECT_NO
    ,USER_NAME, PROFILE_IMG
    ,PROJECT_TITLE
    ,B.WORK_TITLE PARENT_TITLE
    ,LEVEL
FROM 
WORK A
LEFT OUTER JOIN "USER" ON A.WORK_MN_NO="USER".USER_NO
LEFT OUTER JOIN "PROJECT" ON A.PROJECT_NO="PROJECT".PROJECT_NO
LEFT OUTER JOIN WORK B ON A.PARENT_NO=B.WORK_NO
WHERE A.PROJECT_NO=1
AND A.WORK_ST=1
        
START WITH A.PARENT_NO IS NULL 
CONNECT BY PRIOR A.WORK_NO = A.PARENT_NO
;



--------------------------------------------------------------------------------


SELECT * FROM WORK
;


