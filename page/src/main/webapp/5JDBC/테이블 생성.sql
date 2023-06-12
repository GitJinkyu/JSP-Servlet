--id : jsp
--pw : 1234

CREATE USER jsp IDENTIFIED BY 1234;

GRANT CONNECT TO jsp;

GRANT resource TO jsp;


CREATE TABLE member(
    ID VARCHAR2(10)  NOT  NULL,
    PASS VARCHAR2(10) NOT  NULL,
    NAME VARCHAR2(30) NOT  NULL,
    REGIDATE DATE DEFAULT SYSDATE NOT  NULL ,
    PRIMARY KEY (ID)
);

CREATE TABLE board(
    NUM NUMBER PRIMARY KEY,
    TITLE VARCHAR2(200) NOT NULL,
    CONTENT VARCHAR2(2000) NOT NULL,
    ID VARCHAR2(10) NOT NULL,
    POSTDATE DATE DEFAULT SYSDATE NOT NULL,
    VISITCOUNT NUMBER(6)
    
);

--외래키 생성
ALTER TABLE board
    ADD CONSTRAINT board_mem_FK FOREIGN KEY (ID)
    REFERENCES member(ID);

--시퀀스 생성
CREATE SEQUENCE seq_board_num
    INCREMENT BY 1
    START WITH 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

-- 더미데이터 입력
insert into member (id, pass, name) values ('test', '1234', '머스트해브');
insert into board  (num, title, content, id, postdate, visitcount) 
	values (seq_board_num.nextval, '제목1입니다', '내용1입니다', 'test', sysdate, 0);

--코멘트 달아주기
COMMENT ON TABLE board IS '게시판';
COMMENT ON COLUMN board.NUM IS '일련번호';
COMMENT ON COLUMN board.TITLE IS '제목';
COMMENT ON COLUMN board.CONTENT IS '내용';
COMMENT ON COLUMN board.ID IS '작성자 아이디';
COMMENT ON COLUMN board.POSTDATE IS '작성일';
COMMENT ON COLUMN board.VISITCOUNT IS '조회수';

COMMENT ON TABLE member IS '회원';
COMMENT ON COLUMN member.ID IS '아이디';
COMMENT ON COLUMN member.PASS IS '비밀번호';
COMMENT ON COLUMN member.NAME IS '이름';
COMMENT ON COLUMN member.REGIDATE IS '생성일';




drop table member;