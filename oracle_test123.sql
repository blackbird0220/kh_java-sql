
--테이블 생성
create table member(no int not null, id varchar(20) primary key, pw varchar(300), name varchar(100), birth timestamp, email varchar(300));
--시퀀스 생성
create sequence c##test123.mem_seq increment by 1 start with 1 minvalue 1 maxvalue 9999 nocycle;
--데이터 추가
insert into member values(mem_seq.nextval, 'kim', '1234', '김응원', '1988-02-20', 'kewchb@naver.com');
insert into member values(mem_seq.nextval, 'jung', '1357', '정도준', '1998-01-24', 'jdj@naver.com');
insert into member values(mem_seq.nextval, 'cho', '2597', '조우진', '1996-12-20', 'jwj@naver.com');
insert into member values(mem_seq.nextval, 'ksa', '1004', '김설아', '1992-04-13', 'ksa@naver.com');
insert into member values(mem_seq.nextval, 'han', '7921', '한혜진', '1983-11-06', 'hanhj@naver.com');
--데이터 검색
select * from member;


