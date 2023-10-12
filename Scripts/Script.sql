
-- 상품 카테고리
CREATE TABLE PRODUCT_category (
   Pro_category_id VARCHAR(20) NOT NULL primary key, -- 상품_카테고리_ID
   P_category      VARCHAR(50) NOT NULL  -- 카테고리
);

-- 게시판 카테고리
CREATE TABLE BOARD_category (
   Board_category_id VARCHAR(20) NOT NULL primary key, -- 게시판_카테고리_ID
   B_category        VARCHAR(50) NOT NULL  -- 카테고리
);

-- 관리자
CREATE TABLE MANAGER (
   Manager_id VARCHAR(45)  NOT NULL primary key, -- 아이디
   M_pwd      VARCHAR(255) NOT NULL, -- 비밀번호
   M_nickname VARCHAR(45)  NOT NULL  -- 닉네임
);


-- 회원
CREATE TABLE Member (
   User_id    VARCHAR(45)  NOT NULL primary key, -- 아이디
   U_pwd      VARCHAR(255) NOT NULL, -- 비밀번호
   U_name     VARCHAR(45)  NOT NULL, -- 이름
   U_nickname VARCHAR(45)  NOT NULL, -- 닉네임
   U_picture  BLOB         NULL,     -- 사진
   Email      VARCHAR(45)  NULL,     -- 이메일
   Birthdate  DATE         NULL,     -- 생년월일
   Phonenum   VARCHAR(45)  NOT NULL, -- 전화번호
   Address    VARCHAR(45)  NULL,     -- 주소
   archive    INT          NULL      -- 숨기기
);

-- 찜
CREATE TABLE WANT (
   Want_id INT           NOT NULL primary key, -- 찜_상품번호
   W_url   VARCHAR(45)   NOT NULL, -- 물품링크
   W_img   VARCHAR(1000) NULL     -- 물품이미지

);

-- 로그인테이블
CREATE TABLE LOGIN (
   User_id         VARCHAR(45)  NOT NULL PRIMARY KEY, -- 아이디
   U_pwd           VARCHAR(255) NOT NULL, -- 비밀번호
   U_certification INT      DEFAULT 1,      -- 인증유무
   foreign key (User_id)
    REFERENCES Member(User_id) 
);

-- 게시물
CREATE TABLE BOARD (
   Board_id          INT         NOT NULL primary key, -- 게시물번호
   Board_category_id VARCHAR(20) NOT NULL, -- 게시판_카테고리_ID
   User_id           VARCHAR(45) NOT NULL, -- 아이디
   B_regdate         DATE    NOT NULL, -- 게시물_등록시간
   B_name            VARCHAR(45) NOT NULL, -- 게시물제목
   Viewcount         INT         NOT NULL, -- 조회수
   archive           INT         NULL,      -- 활성화
   foreign key (Board_category_id)
    REFERENCES BOARD_category(Board_category_id) ,
    foreign key (User_id)
    REFERENCES LOGIN(User_id) 
);



-- 댓글
CREATE TABLE BOARD_COMMENT (
   Cmnt_id           INT          NOT NULL primary key, -- 댓글번호
   Board_id          INT          NOT NULL, -- 게시물번호
   Board_category_id VARCHAR(20)  NOT NULL, -- 게시판_카테고리_ID
   User_id           VARCHAR(45)  NOT NULL, -- 아이디
   C_regdate         DATE     NOT NULL, -- 댓글_등록시간
   C_contents        VARCHAR(150) NOT NULL,  -- 내용
   foreign key (Board_id)
   references BOARD(Board_id) ,
   foreign key (Board_category_id)
   references BOARD_category(Board_category_id) ,
   foreign key (User_id)
    REFERENCES Member(User_id) 
   
);



-- 상품
CREATE TABLE PRODUCT (
   Pro_num         INT           NOT NULL primary key, -- 상품번호
   Pro_category_id VARCHAR(20)   NOT NULL, -- 상품_카테고리_ID
   User_id         VARCHAR(45)   NOT NULL, -- 아이디
   P_name          VARCHAR(50)   NOT NULL, -- 상품명
   P_state         INT       NOT NULL, -- 상품_판매여부
   P_regdate       DATE      NOT NULL, -- 등록시간
   P_price         INT           NOT NULL, -- 가격
   P_img           VARCHAR(1000) NULL,     -- 상품사진
   archive         INT           NULL,      -- 활성화
   foreign key (Pro_category_id)
    REFERENCES PRODUCT_category(Pro_category_id) ,
    foreign key (User_id)
    REFERENCES Member(User_id) 
);

-- 게시판 이미지 파일
CREATE TABLE BOARD_IMG (
   Board_file_id     INT           NOT NULL primary key, -- 파일번호
   Board_id          INT           NOT NULL, -- 게시물번호
   Board_category_id VARCHAR(20)   NOT NULL, -- 게시판_카테고리_ID
   User_id           VARCHAR(45)   NOT NULL, -- 아이디
   B_filename        VARCHAR(50)   NOT NULL, -- 파일이름
   B_filetype        VARCHAR(45)   NOT NULL, -- 파일유형
   B_fileurl         VARCHAR(1000) NOT NULL,  -- 파일경로
   foreign key (Board_id)
   references BOARD(Board_id) ,
   foreign key (Board_category_id)
   references BOARD_category(Board_category_id) ,
   foreign key (User_id)
    REFERENCES Member(User_id) 
);

-- 공지게시판
CREATE TABLE NOTI_BOARD (
   Noti_board_id INT          NOT NULL primary key, -- 공지_게시판_ID
   User_id       VARCHAR(45)  NOT NULL, -- 아이디
   N_regdate     DATE     NOT NULL, -- 공지_등록시간
   N_name        VARCHAR(45)  NOT NULL, -- 공지_제목
   N_contents    VARCHAR(150) NOT NULL, -- 공지_내용
   archive       INT          NULL,      -- 활성화
   foreign key (User_id)
    REFERENCES Member(User_id) 
);

-- 상품이미지파일
CREATE TABLE PRODUCT_IMG (
   Pro_imgid       INT           NOT NULL primary key, -- 파일번호
   Pro_num         INT           NOT NULL, -- 상품번호
   Pro_category_id VARCHAR(20)   NOT NULL, -- 상품_카테고리_ID
   User_id         VARCHAR(45)   NOT NULL, -- 아이디
   P_imgname       VARCHAR(50)   NOT NULL, -- 파일이름
   P_imgtype       VARCHAR(45)   NOT NULL, -- 파일유형
   P_imgurl        VARCHAR(100) NOT NULL -- 파일경로
);


-- 회원_찜_테이블
CREATE TABLE USER_WANT (
   User_want_id VARCHAR(45) NOT NULL primary key, -- 회원_찜_Id
   User_id      VARCHAR(45) NOT NULL, -- 아이디
   Want_id      INT         NOT NULL,  -- 찜_상품번호
   foreign key (User_id)
    REFERENCES Member(User_id) ,
    foreign key (Want_id)
    references WANT(Want_id) 
);

-- 공지이미지파일
CREATE TABLE NOTI_IMG (
   Noti_file_id  INT           NOT NULL primary key, -- 파일번호
   Noti_board_id INT           NOT NULL, -- 공지_게시판_ID
   User_id       VARCHAR(45)   NOT NULL, -- 아이디
   N_imgname     VARCHAR(50)   NOT NULL, -- 파일이름
   N_imgtype     VARCHAR(45)   NOT NULL, -- 파일유형
   N_imgurl      VARCHAR(1000) NOT NULL,  -- 파일경로
   foreign key (Noti_board_id)
   references NOTI_BOARD(Noti_board_id),
   foreign key (User_id)
    REFERENCES Member(User_id) 
);


-- 공지_댓글
CREATE TABLE NOTI_COMMENT (
   Noti_cmntid    INT          NOT NULL primary key, -- 댓글번호
   User_id        VARCHAR(45)  NOT NULL, -- 아이디
   Noti_board_id  INT          NOT NULL, -- 공지_게시판_ID
   NCmnt_regdate  DATETIME     NOT NULL, -- 댓글_등록시간
   NCmnt_contents VARCHAR(150) NOT NULL,  -- 내용
   foreign key (User_id)
    REFERENCES Member(User_id) ,
    foreign key (Noti_board_id)
   references NOTI_BOARD(Noti_board_id)
);
 
   SELECT AA.COLUMN_ID,
         AA.COLUMN_NAME,
         BB.COMMENTS,
         AA.DATA_TYPE,
         AA.DATA_LENGTH,
         AA.DATA_DEFAULT,
         CC.PK,
         AA.NULLABLE,
         CC.FK
    FROM ALL_TAB_COLUMNS AA,
         ALL_COL_COMMENTS BB,
         (SELECT A.OWNER,
                 A.TABLE_NAME,
                 A.CONSTRAINT_TYPE,
                 COLUMN_NAME,
                 POSITION,
                 CASE WHEN A.CONSTRAINT_TYPE = 'P' THEN 'Y' END AS PK,
                 CASE WHEN A.CONSTRAINT_TYPE = 'R' THEN 'Y' END AS FK
            FROM ALL_CONSTRAINTS A, ALL_CONS_COLUMNS B
           WHERE     UPPER (A.OWNER) = UPPER ('AdminJoongo')
                 AND A.TABLE_NAME = UPPER ('BOARD')
                 AND A.TABLE_NAME = B.TABLE_NAME
                  AND A.CONSTRAINT_NAME = B.CONSTRAINT_NAME
                 AND A.CONSTRAINT_TYPE IN ('P', 'F')) CC
   WHERE     UPPER (AA.OWNER) = UPPER ('AdminJoongo')
         AND UPPER (AA.TABLE_NAME) = UPPER ('BOARD')
         AND AA.OWNER = BB.OWNER
         AND AA.TABLE_NAME = BB.TABLE_NAME
         AND AA.COLUMN_NAME = BB.COLUMN_NAME
         AND AA.OWNER = CC.OWNER(+)
         AND AA.TABLE_NAME = CC.TABLE_NAME(+)
         AND AA.COLUMN_NAME = CC.COLUMN_NAME(+)
ORDER BY COLUMN_ID
 

SELECT *  FROM MEMBER;
SELECT * FROM LOGIN;
SELECT * FROM NOTI_BOARD ;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

	SELECT U_PWD FROM MEMBER WHERE (USER_ID = 'kim');

DELETE FROM NOTI_BOARD ;
 		select COUNT(*) FROM MEMBER 
 		WHERE USER_ID = 'test';
 	
  		insert into noti_board(NOTI_BOARD_ID,MANAGER_ID,N_REGDATE,N_TITLE,N_COUNT,N_IMPORTANT,N_CONTENTS)
 	values('1','admin',sysdate,'ad',1,0,'asdasd')
 	
 	
UPDATE  NOTI_BOARD SET   ARCHIVE = 1 ;
	update noti_board set N_TITLE = '긴급하닙니다',N_CONTENTS = '긴급아님',N_IMPORTANT= 1 where NOTI_BOARD_ID = 11;

SELECT M_NICKNAME  FROM MANAGER WHERE (MANAGER_ID  = 'admin' AND M_PWD = '1234')
select max(noti_board_id) from noti_board;
UPDATE LOGIN  SET AUTHKEY  = 1    WHERE LOGIN.USER_ID IN (SELECT MEMBER.USER_ID  FROM MEMBER WHERE   LOGIN.USER_ID  = MEMBER.USER_ID AND MEMBER.EMAIL ='gudrbwkd98@gmail.com'   AND MEMBER.AUTHPATH  = 'OYyKJRO4nzxGCRPPFgX5LBZ4PY6IqE5srjoXW4TdxXVHHYR3oW' )   ;
DELETE FROM MEMBER WHERE USER_ID != 'sfdag';
DELETE  FROM MEMBER;
COMMIT;
DELETE FROM MEMBER WHERE USER_ID  = 'aaa';