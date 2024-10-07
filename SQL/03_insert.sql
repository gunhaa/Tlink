-- SYSTEM 관리자 데이터 삽입
INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    'sys01@kh.or.kr',              -- 이메일 (USER_EMAIL)
    '$2a$10$eeylz0XV81KRZBA.UN09Hu52FXyehKvb.z1COFF7Yi1eRmK7feSzq',                      -- 비밀번호 (USER_PW)
    '관리자',                         -- 이름 (USER_NAME)
    '01012345678',                      -- 전화번호 (USER_PHONE)
    NULL,-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    'S',                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

-- ADMIN 관리자 데이터 삽입
INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    'ad01@kh.or.kr',              -- 이메일 (USER_EMAIL)
    '$2a$10$eeylz0XV81KRZBA.UN09Hu52FXyehKvb.z1COFF7Yi1eRmK7feSzq',                      -- 비밀번호 (USER_PW)
    '관리자',                         -- 이름 (USER_NAME)
    '01012345678',                      -- 전화번호 (USER_PHONE)
    NULL,-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    'A',                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

-- 유저 데이터 삽입
INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    'user01@kh.or.kr',              -- 이메일 (USER_EMAIL)
    '$2a$10$eeylz0XV81KRZBA.UN09Hu52FXyehKvb.z1COFF7Yi1eRmK7feSzq',                      -- 비밀번호 (USER_PW)
    '유저일',                         -- 이름 (USER_NAME)
    '01012345678',                      -- 전화번호 (USER_PHONE)
    '1234^^^테헤란로12^^^101동 201호',-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    DEFAULT,                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    'user02@kh.or.kr',              -- 이메일 (USER_EMAIL)
    '$2a$10$eeylz0XV81KRZBA.UN09Hu52FXyehKvb.z1COFF7Yi1eRmK7feSzq',                      -- 비밀번호 (USER_PW)
    '유저이',                         -- 이름 (USER_NAME)
    '01012345678',                      -- 전화번호 (USER_PHONE)
    '1234^^^테헤란로12^^^101동 201호',-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    DEFAULT,                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    'user03@kh.or.kr',              -- 이메일 (USER_EMAIL)
    '$2a$10$eeylz0XV81KRZBA.UN09Hu52FXyehKvb.z1COFF7Yi1eRmK7feSzq',                      -- 비밀번호 (USER_PW) pass01
    '유저삼',                         -- 이름 (USER_NAME)
    '01012345678',                      -- 전화번호 (USER_PHONE)
    '1234^^^테헤란로12^^^101동 201호',-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    DEFAULT,                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    'user04@kh.or.kr',              -- 이메일 (USER_EMAIL)
    '$2a$10$eeylz0XV81KRZBA.UN09Hu52FXyehKvb.z1COFF7Yi1eRmK7feSzq',                      -- 비밀번호 (USER_PW) pass01
    '유저사',                         -- 이름 (USER_NAME)
    '01012345678',                      -- 전화번호 (USER_PHONE)
    '1234^^^테헤란로12^^^101동 201호',-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    DEFAULT,                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    'user05@kh.or.kr',              -- 이메일 (USER_EMAIL)
    '$2a$10$eeylz0XV81KRZBA.UN09Hu52FXyehKvb.z1COFF7Yi1eRmK7feSzq',                      -- 비밀번호 (USER_PW) pass01
    '유저오',                         -- 이름 (USER_NAME)
    '01012345678',                      -- 전화번호 (USER_PHONE)
    '1234^^^테헤란로12^^^101동 201호',-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    DEFAULT,                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

-- 프로젝트 삽입1
INSERT INTO "PROJECT" VALUES(
    SEQ_PROJECT_NO.NEXTVAL,
    '세미 프로젝트',
    '유저일이 만들었음',
    DEFAULT,
    3
);

INSERT INTO "USER_PROJECT" VALUES(
    3, -- 생성자
    1 -- 만든 프로젝트 번호
);

INSERT INTO "VIDEO_ROOM" VALUES(
    1,
    '화상 채팅'
);

-- 프로젝트 삽입2
INSERT INTO "PROJECT" VALUES(
    SEQ_PROJECT_NO.NEXTVAL,
    '파이널 프로젝트',
    '유저이가 만들었음',
    DEFAULT,
    4
);

INSERT INTO "USER_PROJECT" VALUES(
    4, -- 생성자
    2 -- 만든 프로젝트 번호
);

INSERT INTO "VIDEO_ROOM" VALUES(
    2,
    '화상 채팅'
);

-- 프로젝트 삽입3
INSERT INTO "PROJECT" VALUES(
    SEQ_PROJECT_NO.NEXTVAL,
    '안 중요한 프로젝트',
    '유저삼이 만든 프로젝트입니다.',
    DEFAULT,
    5
);

INSERT INTO "USER_PROJECT" VALUES(
    5, -- 생성자
    3 -- 만든 프로젝트 번호
);

INSERT INTO "VIDEO_ROOM" VALUES(
    3,
    '화상 채팅'
);

-- 프로젝트 삽입4
INSERT INTO "PROJECT" VALUES(
    SEQ_PROJECT_NO.NEXTVAL,
    '중요한 프로젝트',
    '유저사가 만든 프로젝트임',
    DEFAULT,
    6
);

INSERT INTO "USER_PROJECT" VALUES(
    6, -- 생성자
    4 -- 만든 프로젝트 번호
);

INSERT INTO "VIDEO_ROOM" VALUES(
    4,
    '화상 채팅'
);

-- 프로젝트 삽입5
INSERT INTO "PROJECT" VALUES(
    SEQ_PROJECT_NO.NEXTVAL,
    '저일의 프로젝트',
    '연습용 프로젝트',
    DEFAULT,
    3
);

INSERT INTO "USER_PROJECT" VALUES(
    3, -- 생성자
    5 -- 만든 프로젝트 번호
);

INSERT INTO "VIDEO_ROOM" VALUES(
    5,
    '화상 채팅'
);

-- 프로젝트 초대1
INSERT INTO "USER_PROJECT" VALUES(
    4, -- 유저번호
    1 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    5, -- 유저번호
    1 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    6, -- 유저번호
    1 -- 프로젝트 번호
);

-- 프로젝트 초대2
INSERT INTO "USER_PROJECT" VALUES(
    3, -- 유저번호
    2 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    5, -- 유저번호
    2 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    6, -- 유저번호
    2 -- 프로젝트 번호
);

-- 프로젝트 초대3
INSERT INTO "USER_PROJECT" VALUES(
    3, -- 유저번호
    3 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    4, -- 유저번호
    3 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    6, -- 유저번호
    3 -- 프로젝트 번호
);

-- 프로젝트 초대4
INSERT INTO "USER_PROJECT" VALUES(
    3, -- 유저번호
    4 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    4, -- 유저번호
    4 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    5, -- 유저번호
    4 -- 프로젝트 번호
);

-- 공지사항
BEGIN
   FOR i IN 1..310 LOOP
      INSERT INTO NOTICE (
         NOTICE_NO, NOTICE_TYPE, NOTICE_STATUS, NOTICE_TITLE, CREATE_DT, UPDATE_DT, NOTICE_CONTENT, READ_COUNT, USER_NO
      ) VALUES (
         SEQ_NOTICE_NO.NEXTVAL, 
         MOD(i, 3) + 1, -- NOTICE_TYPE은 1, 2, 3이 고르게 분배됨
         1, -- NOTICE_STATUS는 항상 1
         '게시글 제목' || i, -- 게시글 제목은 '게시글 제목1', '게시글 제목2' ...
         SYSDATE, -- 작성일
         NULL, -- 마지막 수정일
         '게시글 내용' || i, -- 게시글 내용은 '게시글 내용1', '게시글 내용2' ...
         CEIL(DBMS_RANDOM.VALUE(20,200)), -- 조회수는 항상 0
         1 -- USER_NO는 1로 설정 (실제 존재하는 USER_NO를 사용해야 함)
      );
   END LOOP;
   COMMIT;
END;
/


INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 3, 2, 2, '상단 고정 내용임',  SYSDATE, NULL, '상단 고정 내용임', 328, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 3, 1, 1, '홈페이지 서버 해킹 피해에 대한 공지', SYSDATE, NULL, '해킹 피해에 대한 개요
</br></br>
1. 2024년 9월 중순경 TLINK와 홈페이지 호스팅을 계약한 미**** 업체가 해커로부터 공격을 받아 자료가 삭제되는 사고가 발생하였습니다.
</br>
2. 이에 해당 업체가 본학회의 데이터를 백업자료로 복구하는 과정에서 9월 1일 이후에 등록된 자료가 소실되는 피해가 발생하였습니다.
</br>
3. 그 후에도 계속된 해커의 공격으로 호스팅 업체의 서버 다운이 또다시 발생하여 홈페이지에 접속이 안되는 피해가 발생하였습니다.
</br></br>
TLINK의 대응
</br></br>
1. TLINK는 소실된 데이터를 최대한 복구하였으나, 9월 초에 가입하신 회원님의 경우 재가입 이외에는 복구 방법이 없어 회원님의 양해를 부탁드립니다.
</br>
2. 해킹으로 발생될 수 있는 회원님들의 개인정보 유출 예방을 위하여, TLINK는 회원 가입시 수집하는 개인정보를 최소화 하는 것으로 변경하였고, 기존에 수집한 추가적인 개인정보는 모두 삭제하였습니다.
</br>
3. 본 홈페이지는 이번 사태에 대한 기존 계약 업체의 대응이 미숙함을 인지하고, 2024-9-20일에 학회 서버를 보안이 철저한 타 업체로 이전 완료 하였습니다.
</br>
4. 이번 사태와 관련하여 회원님들께서 큰 불편을 겪은 점 사과드리며, 한국실리콘학회는 소중한 회원정보 보호를 위하여 최선을 다할 것을 약속드립니다.'
,234, 1 );

INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, 1, 1, 1, '서버점검중', SYSDATE, NULL, '오늘 서버 점검합니다', 22, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 2, 2, '이제 캘린더 사용 가능', SYSDATE, NULL, '캘린더 사용 가능합니다.', 52, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 1, 1, '화상채팅의 화질이 더욱 좋아집니다', SYSDATE, NULL, '화상채팅의 화질이 더욱 좋아집니다.', 122, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, 1, 1, 1, '서버점검중2', SYSDATE, NULL, '오늘 서버 점검합니다', 45, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, 1, 2, 2, '서버점검중3', SYSDATE, NULL, '오늘 서버 점검합니다', 59, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 2, 2, '이제 캘린더 사용 가능3', SYSDATE, NULL, '캘린더 사용 가능합니다.', 66, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, 1, 1, 1, '서버점검중4', SYSDATE, NULL, '오늘 서버 점검합니다', 0, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 1, 1, '이제 캘린더 사용 가능4', SYSDATE, NULL, '캘린더 사용 가능합니다.', 110, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 3, 1, 2, 2, '정부 정책 변경에 따른 개인정보보안 약정 변경', SYSDATE, NULL, '캘린더 사용 가능합니다.', 123, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, 1, 2, 2, '서버점검중5 만약 게시글 제목이 너무 길다면 어떻게 될까 두 줄이 되는데 그걸 더 넘어가면 어떻게 될까', SYSDATE, NULL, '오늘 서버 점검합니다', 43, 1);
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 3, 1, 1, 1, '정부 정책 변경에 따른 개인정보보안 약정 변경', SYSDATE, NULL, '오늘 서버 점검합니다', 112, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 1, 1, '이제 캘린더 사용 가능6', SYSDATE, NULL, '캘린더 사용 가능합니다.', 145, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 1, 1, '이제 캘린더 사용 가능7', SYSDATE, NULL, '캘린더 사용 가능합니다.', 122, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 3, 1, 1, 1, '정부 정책 변경에 따른 개인정보보안 약정 변경', SYSDATE, NULL, '오늘 서버 점검합니다', 40, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 1, 1, '이제 캘린더 사용 가능8', SYSDATE, NULL, '캘린더 사용 가능합니다.', 82, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, 1, 1, 1, '서버점검중8', SYSDATE, NULL, '오늘 서버 점검합니다', 101, 1 );

INSERT INTO SCHEDULE VALUES(SEQ_SCHEDULE_NO.NEXTVAL, 1, '일정1', SYSDATE, SYSDATE + 2,
	 '일정1의 내용입니다.', 3, 1);

INSERT INTO SCHEDULE VALUES(SEQ_SCHEDULE_NO.NEXTVAL, 2, '휴가1', SYSDATE+3, SYSDATE + 6,
	 '휴가1의 내용입니다.', 4, 1);

-- 특정 일정 등록
INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 1, '회의1',
        TO_DATE('2024-09-19 12:50', 'YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-09-19 12:56', 'YYYY-MM-DD HH24:MI'),
        '회의 1내용입니다.', 3, 1
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 1, '회의2',
        TO_DATE('2024-09-24 12:50', 'YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-09-24 12:56', 'YYYY-MM-DD HH24:MI'),
        '회의 2내용입니다.', 4, 1
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 2, '연가1',
        TO_DATE('2024-09-15', 'YYYY-MM-DD"T"HH24:MI'),
        TO_DATE('2024-09-17', 'YYYY-MM-DD"T"HH24:MI'),
        '연가 1내용입니다.', 4, 1
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 2, '연가2',
        TO_DATE('2024-09-01', 'YYYY-MM-DD"T"HH24:MI'),
        TO_DATE('2024-09-04 12:56', 'YYYY-MM-DD HH24:MI'),
        '연가 2내용입니다.', 3, 1
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 3, '병가2',
        TO_DATE('2024-09-06', 'YYYY-MM-DD"T"HH24:MI'),
        TO_DATE('2024-09-07 12:56', 'YYYY-MM-DD HH24:MI'),
        '병가 1내용입니다.', 3, 1
);

INSERT INTO SCHEDULE VALUES(SEQ_SCHEDULE_NO.NEXTVAL, 1, '일정1', SYSDATE, SYSDATE + 2,
	 '일정1의 내용입니다.', 3, 2);

INSERT INTO SCHEDULE VALUES(SEQ_SCHEDULE_NO.NEXTVAL, 2, '휴가1', SYSDATE+3, SYSDATE + 6,
	 '휴가1의 내용입니다.', 4, 2);

-- 특정 일정 등록
INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 1, '회의1',
        TO_DATE('2024-09-19 12:50', 'YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-09-19 12:56', 'YYYY-MM-DD HH24:MI'),
        '회의 1내용입니다.', 3, 2
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 1, '회의2',
        TO_DATE('2024-09-24 12:50', 'YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-09-24 12:56', 'YYYY-MM-DD HH24:MI'),
        '회의 2내용입니다.', 4, 2
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 2, '연가1',
        TO_DATE('2024-09-15', 'YYYY-MM-DD"T"HH24:MI'),
        TO_DATE('2024-09-17', 'YYYY-MM-DD"T"HH24:MI'),
        '연가 1내용입니다.', 4, 2
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 2, '연가2',
        TO_DATE('2024-09-01', 'YYYY-MM-DD"T"HH24:MI'),
        TO_DATE('2024-09-04 12:56', 'YYYY-MM-DD HH24:MI'),
        '연가 2내용입니다.', 3, 2
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 3, '병가2',
        TO_DATE('2024-09-06', 'YYYY-MM-DD"T"HH24:MI'),
        TO_DATE('2024-09-07 12:56', 'YYYY-MM-DD HH24:MI'),
        '병가 1내용입니다.', 3, 2
);


-- COMMENT 테이블 샘플 데이터 삽입(PL/SQL)
BEGIN
   FOR I IN 1..1000 LOOP
      INSERT INTO NOTICE_COMMENT 
      VALUES(SEQ_COMMENT_NO.NEXTVAL, 
            SEQ_COMMENT_NO.CURRVAL || '번째 댓글',
            DEFAULT, DEFAULT,
             CEIL(DBMS_RANDOM.VALUE(0,328)),
             3, NULL);
   END LOOP;
END;
/

INSERT INTO NOTICE_COMMENT
VALUES(SEQ_COMMENT_NO.NEXTVAL, '보안 신경쓰세요', DEFAULT, DEFAULT, 312, 3, NULL);

INSERT INTO NOTICE_COMMENT
VALUES(SEQ_COMMENT_NO.NEXTVAL, '회원 분들의 질문 답변으로 해당 업체와의 계약은 2024-09-20 상호합의 하 해지되었음을 알립니다.', DEFAULT, 3, 312, 1, NULL);

INSERT INTO NOTICE_COMMENT
VALUES(SEQ_COMMENT_NO.NEXTVAL, '보안 신경쓰세요!@!@!@!@', DEFAULT, DEFAULT, 312, 4, NULL);

INSERT INTO NOTICE_COMMENT
VALUES(SEQ_COMMENT_NO.NEXTVAL, '아직도 로그인을 못하고 있어요', DEFAULT, DEFAULT, 312, 4, 1002);

INSERT INTO NOTICE_COMMENT
VALUES(SEQ_COMMENT_NO.NEXTVAL, '언제 부터 이용 가능한가요', DEFAULT, DEFAULT, 312, 5, 1002);

INSERT INTO NOTICE_COMMENT
VALUES(SEQ_COMMENT_NO.NEXTVAL, '지금 복구 완료하여 이용 가능합니다.', DEFAULT, DEFAULT, 312, 2, 1002);

INSERT INTO NOTICE_COMMENT
VALUES(SEQ_COMMENT_NO.NEXTVAL, '보안 신경쓰세요!@!@!@!@', DEFAULT, DEFAULT, 312, 5, NULL);

-- 파일 데이터 추가 
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    '20240809111920_00001.jpg', 'cat1.jpg', 0, 1, 328);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    '20240809111920_00002.jpg', 'cat2.jpg', 1, 1, 328);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    '20240809111920_00003.jpg', 'cat3.jpg', 2, 1, 328);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    '20240809111920_00004.jpg', 'cat4.jpg', 3, 1, 328);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    '20240809111920_00005.jpg', 'cat5.jpg', 4, 1, 328);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    '20240809111920_00006.jpg', 'dog1.jpg', 5, 1, 328);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/calendar/', 
    '20240809111920_00001.jpg', 'cat1.jpg', 0, 4, 7);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    'mailtype.jpg', 'mailtype.jpg', 1, 1, 312);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    'mailtype2.jpg', 'mailtype2.jpg', 2, 1, 312);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    'mailtype3.jpg', 'mailtype3.jpg', 3, 1, 312);
    
    INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    'notice.zip', 'notice.zip', 0, 1, 312);

COMMIT;


--------------------------------------------------------------------------------
--작업

INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('1', '프론트 작업1', '프론트입니다. 작업1 내용', '2024-08-24 09:12:23', '', '2024-09-29 00:00:00', '1', '0', '0', '3', '', '1');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('2', '프론트 작업2', '프론트입니다. 작업2 내용', '2024-09-15 09:12:23', '', '2024-09-26 00:00:00', '1', '1', '1', '3', '1', '1');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('3', '프론트 작업3', '프론트입니다. 작업3 내용', '2024-09-23 09:12:23', '', '2024-09-25 09:12:23', '1', '1', '1', '3', '2', '1');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('4', '프론트 작업4', '프론트입니다. 작업4 내용', '2024-09-26 09:12:23', '', '2024-10-25 00:00:00', '1', '1', '1', '3', '3', '1');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('5', '프론트 작업5', '프론트입니다. 작업5 내용', '2024-09-25 09:12:23', '', '2024-10-27 00:00:00', '1', '1', '1', '3', '2', '1');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('6', '프론트 작업6', '프론트입니다. 작업6 내용', '2024-10-01 09:12:23', '', '2024-10-25 09:12:23', '1', '2', '1', '3', '2', '1');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('7', '프론트 작업7', '프론트입니다. 작업7 내용', '2024-09-25 09:12:23', '', '2024-10-12 00:00:00', '1', '1', '1', '3', '3', '1');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('8', '백앤드 작업1', '백앤드입니다. 작업1 내용', '2024-10-15 09:12:23', '', '2024-10-15 00:00:00', '1', '0', '0', '4', '6', '1');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('9', '백앤드 작업2', '백앤드입니다. 작업2 내용', '2024-10-10 09:12:23', '', '2024-10-30 00:00:00', '1', '0', '0', '4', '7', '1');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('10', '백앤드 작업3', '백앤드입니다. 작업3 내용', '2024-10-25 09:12:23', '', '2024-10-30 00:00:00', '1', '0', '0', '4', '9', '1');


INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('11', '프론트 작업1', '프론트입니다. 작업1 내용', '2024-08-24 09:12:23', '', '2024-09-29 00:00:00', '1', '0', '0', '3', '', '2');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('12', '프론트 작업2', '프론트입니다. 작업2 내용', '2024-09-15 09:12:23', '', '2024-09-26 00:00:00', '1', '1', '1', '3', '1', '2');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('13', '프론트 작업3', '프론트입니다. 작업3 내용', '2024-09-23 09:12:23', '', '2024-09-25 09:12:23', '1', '1', '1', '3', '2', '2');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('14', '프론트 작업4', '프론트입니다. 작업4 내용', '2024-09-26 09:12:23', '', '2024-10-25 00:00:00', '1', '1', '1', '3', '3', '2');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('15', '프론트 작업5', '프론트입니다. 작업5 내용', '2024-09-25 09:12:23', '', '2024-10-27 00:00:00', '1', '1', '1', '3', '2', '2');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('16', '프론트 작업6', '프론트입니다. 작업6 내용', '2024-10-01 09:12:23', '', '2024-10-25 09:12:23', '1', '2', '1', '3', '2', '2');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('17', '프론트 작업7', '프론트입니다. 작업7 내용', '2024-09-25 09:12:23', '', '2024-10-12 00:00:00', '1', '1', '1', '3', '3', '2');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('18', '백앤드 작업1', '백앤드입니다. 작업1 내용', '2024-10-15 09:12:23', '', '2024-10-15 00:00:00', '1', '0', '0', '4', '6', '2');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('19', '백앤드 작업2', '백앤드입니다. 작업2 내용', '2024-10-10 09:12:23', '', '2024-10-30 00:00:00', '1', '0', '0', '4', '7', '2');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('20', '백앤드 작업3', '백앤드입니다. 작업3 내용', '2024-10-25 09:12:23', '', '2024-10-30 00:00:00', '1', '0', '0', '4', '9', '2');


INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('21', '프론트 작업1', '프론트입니다. 작업1 내용', '2024-08-24 09:12:23', '', '2024-09-29 00:00:00', '1', '0', '0', '3', '', '3');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('22', '프론트 작업2', '프론트입니다. 작업2 내용', '2024-09-15 09:12:23', '', '2024-09-26 00:00:00', '1', '1', '1', '3', '1', '3');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('23', '프론트 작업3', '프론트입니다. 작업3 내용', '2024-09-23 09:12:23', '', '2024-09-25 09:12:23', '1', '1', '1', '3', '2', '3');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('24', '프론트 작업4', '프론트입니다. 작업4 내용', '2024-09-26 09:12:23', '', '2024-10-25 00:00:00', '1', '1', '1', '3', '3', '3');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('25', '프론트 작업5', '프론트입니다. 작업5 내용', '2024-09-25 09:12:23', '', '2024-10-27 00:00:00', '1', '1', '1', '3', '2', '3');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('26', '프론트 작업6', '프론트입니다. 작업6 내용', '2024-10-01 09:12:23', '', '2024-10-25 09:12:23', '1', '2', '1', '3', '2', '3');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('27', '프론트 작업7', '프론트입니다. 작업7 내용', '2024-09-25 09:12:23', '', '2024-10-12 00:00:00', '1', '1', '1', '3', '3', '3');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('28', '백앤드 작업1', '백앤드입니다. 작업1 내용', '2024-10-15 09:12:23', '', '2024-10-15 00:00:00', '1', '0', '0', '4', '6', '3');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('29', '백앤드 작업2', '백앤드입니다. 작업2 내용', '2024-10-10 09:12:23', '', '2024-10-30 00:00:00', '1', '0', '0', '4', '7', '3');
INSERT INTO WORK (WORK_NO, WORK_TITLE, WORK_CONTENT,CREATE_DT, UPDATE_DT, DUE_DT, WORK_ST, WORK_PR_ST, WORK_PR, WORK_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('30', '백앤드 작업3', '백앤드입니다. 작업3 내용', '2024-10-25 09:12:23', '', '2024-10-30 00:00:00', '1', '0', '0', '4', '9', '3');
COMMIT;


--댓글
INSERT INTO WORK_COMMENT (COMMENT_NO, COMMENT_CON, COMMENT_ST, COMMENT_DT, PARENT_NO, WORK_NO, USER_NO) VALUES ('1', '댓글1 입니다.', '1', '2024-09-25 10:13:38', '', '1', '3');
INSERT INTO WORK_COMMENT (COMMENT_NO, COMMENT_CON, COMMENT_ST, COMMENT_DT, PARENT_NO, WORK_NO, USER_NO) VALUES ('2', '댓글2 입니다.', '1', '2024-09-25 10:13:38', '', '1', '4');
INSERT INTO WORK_COMMENT (COMMENT_NO, COMMENT_CON, COMMENT_ST, COMMENT_DT, PARENT_NO, WORK_NO, USER_NO) VALUES ('3', '댓글3 입니다.', '1', '2024-09-25 10:13:38', '', '1', '3');
INSERT INTO WORK_COMMENT (COMMENT_NO, COMMENT_CON, COMMENT_ST, COMMENT_DT, PARENT_NO, WORK_NO, USER_NO) VALUES ('4', '댓글4 입니다.', '1', '2024-09-25 10:13:38', '', '1', '4');
INSERT INTO WORK_COMMENT (COMMENT_NO, COMMENT_CON, COMMENT_ST, COMMENT_DT, PARENT_NO, WORK_NO, USER_NO) VALUES ('5', '댓글5 입니다.', '1', '2024-09-25 10:13:38', '', '1', '3');
COMMIT;


--투두
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('1', '제목1', '내용1', '2024-09-23 10:20:13', '', '1', '0', '3', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('2', '제목2', '내용2', '2024-09-23 10:20:15', '', '1', '0', '3', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('3', '제목3', '내용3', '2024-09-23 10:20:22', '', '1', '0', '3', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('4', '제목4', '내용4', '2024-09-23 10:50:13', '', '1', '0', '3', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('5', '제목5', '내용5', '2024-09-23 10:50:13', '', '1', '0', '3', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('6', '제목6', '내용6', '2024-09-23 10:50:13', '', '1', '1', '3', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('7', '제목7', '내용7', '2024-09-23 10:50:14', '', '1', '1', '3', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('8', '제목8', '내용8', '2024-09-23 11:20:18', '', '1', '1', '3', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('9', '제목9', '내용9', '2024-09-23 13:09:50', '', '1', '1', '3', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('10', '제목10', '내용10', '2024-09-23 13:11:57', '', '1', '1', '3', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('11', '제목11', '내용11', '2024-09-23 13:13:08', '', '1', '2', '3', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('12', '제목12', '내용12', '2024-09-23 13:19:04', '', '1', '2', '3', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('13', '제목13', '내용13', '2024-09-23 13:19:07', '', '1', '2', '3', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('14', '제목14', '내용14', '2024-09-23 13:19:09', '', '1', '2', '4', '', '1');
INSERT INTO TODO (TODO_NO, TODO_TITLE, TODO_CONTENT, CREATE_DT, UPDATE_DT, TODO_ST, TODO_PR_ST, TODO_MN_NO, PARENT_NO, PROJECT_NO) VALUES ('15', '제목15', '내용15', '2024-09-23 13:23:35', '', '1', '2', '4', '', '1');
COMMIT;


