CREATE TABLE mvcboard(
    idx NUMBER not null PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    postdate DATE DEFAULT SYSDATE NOT NULL,
    ofile varchar2(200) ,
    sfile varchar2(100) ,
    downcount number default 0 not null,
    pass varchar2(50) not null,
    visitcount NUMBER default 0 not null
);

--시퀀스 생성
CREATE SEQUENCE seq_board_num
    INCREMENT BY 1
    START WITH 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;
    


SELECT idx, name, title, content,DECODE(TRUNC(sysdate), TRUNC(postdate), TO_CHAR(postdate, 'HH24:MI:SS'), TO_CHAR(postdate, 'YYYY-MM-DD')) AS postdate
                    ,ofile
                    , sfile
                    , downcount
                    , visitcount
                    , pass
                    FROM MVCBoard
                   ORDER BY idx DESC;
                   
delete from MVCBoard where idx= 6;

insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '������', '�ڷ�� ����5 �Դϴ�.','����','1234');