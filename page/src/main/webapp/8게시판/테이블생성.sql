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
--보드 테이블 삭제
DROP TABLE BOARD;

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
--시퀀스 삭제
DROP SEQUENCE seq_board_num;


-- 더미데이터 입력
insert into member (id, pass, name) values ('test', '1234', '머스트해브');
insert into member (id, pass, name) values ('test1', '1234', '머스트해브1');
insert into member (id, pass, name) values ('test2', '1234', '머스트해브2');

insert into board  (num, title, content, id, postdate, visitcount) 
values (seq_board_num.nextval, '제목1입니다', '내용1입니다', 'test', sysdate, 0);

insert into board  (num, title, content, id, postdate, visitcount) 
values (seq_board_num.nextval, '제목2입니다', '내용1입니다', 'test', sysdate, 0);
insert into board  (num, title, content, id, postdate, visitcount) 
values (seq_board_num.nextval, '제목3입니다', '내용1입니다', 'test', sysdate, 0);
insert into board  (num, title, content, id, postdate, visitcount) 
values (seq_board_num.nextval, '제목4입니다', '내용1입니다', 'test', sysdate, 0);
insert into board  (num, title, content, id, postdate, visitcount) 
values (seq_board_num.nextval, '제목5입니다', '내용1입니다', 'test', sysdate, 0);
insert into board  (num, title, content, id, postdate, visitcount) 
values (seq_board_num.nextval, '제목6입니다', '내용1입니다', 'test', sysdate, 0);
insert into board  (num, title, content, id, postdate, visitcount) 
values (seq_board_num.nextval, '제목7입니다', '내용1입니다', 'test', sysdate, 0);
insert into board  (num, title, content, id, postdate, visitcount) 
values (seq_board_num.nextval, '제목8입니다', '내용1입니다', 'test', sysdate, 0);
insert into board  (num, title, content, id, postdate, visitcount) 
values (seq_board_num.nextval, '제목9입니다', '내용1입니다', 'test', sysdate, 0);
insert into board  (num, title, content, id, postdate, visitcount) 
values (seq_board_num.nextval, '제목10입니다', '내용1입니다', 'test', sysdate, 0);
insert into board  (num, title, content, id, postdate, visitcount) 
values (seq_board_num.nextval, '제목11입니다', '내용1입니다', 'test', sysdate, 0);

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


select num, title, content, id, postdate, visitcount from board order by num desc;

SELECT * FROM board WHERE "+searchField+" LIKE '%'"+searchWord+"'%' order by num desc;

select count(*) from board order by num desc;

select * from board where num = 11;

UPDATE board SET visitcount = visitcount + 1 WHERE num = 2 ;
UPDATE board SET visitcount = visitcount + 1 WHERE num = 4;

UPDATE board SET title = 'ss', content = 'ff'  WHERE num =5;

select num,title,content,id,decode(trunc(sysdate),trunc(postdate),to_char(postdate,'hh24:mi:ss'),to_char(postdate,'yyyy-mm-dd')) as datea,visitcount from board order by num desc;

select num,title,content,id,decode(trunc(sysdate),trunc(postdate)
            ,to_char(postdate,'hh24:mi:ss'),to_char(postdate,'yyyy-mm-dd')) as datea
            ,visitcount 
from board 
order by num desc;

select num,title,content,id,decode(trunc(sysdate),trunc(postdate),to_char(postdate,'hh24:mi:ss'),to_char(postdate,'yyyy-mm-dd')) as postdate,visitcount 
from board 
WHERE title LIKE '%an%' ;



select * from(
    select rownum rn,t.* from(
    
            select num,title,content,id
                ,decode(trunc(sysdate)
                ,trunc(postdate)
                ,to_char(postdate,'hh24:mi:ss')
                ,to_char(postdate,'yyyy-mm-dd')) as datea
                ,visitcount 
            from board 
            order by num desc
    )t
)
where rn between 1 and 10;


insert into board values (seq_board_num.nextval, '제목1입니다', '내용1입니다', 'test', sysdate, 0);
insert into board values (seq_board_num.nextval,'title','content','id', sysdate, 0);

drop table member;

select * 
from(   
    select rownum rn , board.*
    from board
    order by num desc

)
where rn between 1 and 10; 

--더미데이터 대량 추가하기 한번에 여러개 추가됨
insert into board
select SEQ_BOARD_NUM.nextval,'제목','내용','test',sysdate, 0
from board;
