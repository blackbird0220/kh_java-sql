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
insert into member values(mem_seq.nextval, 'ju', '1200', '주연하', '1986-08-21', 'yeonha@naver.com');
--데이터 검색
select * from member;


--1989년 1월1일 이후 출생자만 출력
select id, name, birth from member where birth>='1989-01-01';

--1983 1월1일 부터 1989년 12월 31일 까지의 출생자
select id, name, birth from member where birth>='1983-01-01' and birth<='1989-12-31';
select id, name, birth from member where birth between '1983-01-01' and '1989-12-31';
select id, name from member where id like '%i%' or id like '%e%';
--id가 'kim','lee','cho'인 경우
select * from member where id='kim' or id='lee' or id='cho';
select * from member where id in('kim','lee','cho');

--id가 'kim','lee','cho'가 아닌 경우
select * from member where id not in('kim','lee','cho');
-- 회원 테이블로부터 id, name/ name 중 성씨를 검색
select id,name,substr(name,1,1) as surname from member;
--자바에서 rs.getString("surname");으로 표현. 컬럼명이 길거나 수식이나 함수를 적용하여 컬럼을 구성할 경우 컬럼에 대한 alias(별칭을 붙일 수 있다).

-- id가 i로 시작하거나 j으로 끝나는 사람 id name 출력
select id, name, birth from member where id like'k%' or id like '%o';
--id에 i 가 포함된 사람 출력
select id, name, birth from member where id like'%i%';

--id에 k로 시작하는사람 출력
select id, name, birth from member where id like 'k%';

--id가 O로 끝나는사람 출력
select id, name, birth from member where id like'%o';

--id가 kew인 회원의 email을 kewchb@naver.com로 바꾼다
update member set email='kewchb@naver.com' where id='kew';

-- id가 ksa인 회원을 강제 탈퇴하도록 한다(예전에 개인정보법이 강하지 않았을 때는 
-- 회원수나 회원정보가 중요하기 때문에 강제 탈퇴가 아니라 회원유지는 하되 아이디 사용중지 방법으로 처리했음)
--id가 ksa인 멤버 삭제/ 테이블은 남아있고 데이터만 삭제됨
delete from member where id='ksa';


--현재 날짜 표시: oracle에서는 sysdate 명령어 사용/ 현재 날짜 MariaDB MySQL currentdate 명령어 사용
alter table member add regdate timestamp default sysdate;
-- oracle MariaDB MySQL에서 모두 같은 명령어 사용 desc

alter table member add point int default 0;
--컬럼명 변경
alter table member rename column regdate to reg;

--컬럼데이터 타입 변경-
alter table member modify pw varchar(200);
select * from member;
--alter table member add point int default

--컬럼 제거 alter table 테이블명 drop column 컬럼명;
alter table member drop column point;

alter table member rename to temp1;
select * from temp1;
--특정 테이블에 어떤 칼럼이 있는지 구조가 무엇인지 조회하는 명령어
desc temp1;

create table temp2(no int, name varchar(200), point int);
insert into temp2 values(1, '김', 90);
insert into temp2 values(2, '박', 70);
insert into temp2 values(3, '최', 85);
insert into temp2(name, point) values('이', 75);

select * from temp2;
--null경우 컬럼삭제
delete from temp2 where no is null;
--제약조건(기본키)추가 
alter table temp2 add constraints key1 primary key (no);

-----EMP(직원) 테이블-----
create table emp(no int, name varchar(100), pcode int, constraints key2 primary key (no));

insert into emp values(1, '김', 1);
insert into emp values(2, '이', 2);
insert into emp values(3, '이', 3);
insert into emp values(4, '이', 4);
insert into emp values(5, '이', 5);

update emp set name='박' where no=3;
update emp set name='최' where no=4;
update emp set name='이' where no=5;

-----POS(직위) 테이블-----
create table pos(pcode int primary key, pname varchar(100));
insert into pos values(1, '이사');
insert into pos values(2, '부장');
insert into pos values(3, '과장');
insert into pos values(4, '사원');
--
insert into pos values(5, '인턴');
--참조무결성 원칙, 외래키 설정못함/ 단, 제약조건 설정시 기본키 조건이 만족되지 않으면 실행할 수 없음

select * from emp;
select * from pos;
--emp 테이블의 pcode는 pos pcode를 참조한다는 뜻
alter table emp add constraints fkey foreign key (pcode) references pos (pcode);
--제약조건 보기// 검색할 때 값은 대문자로 검색
select * from ALL_CONSTRAINTS where OWNER='C##TEST123';
select * from ALL_CONSTRAINTS where TABLE_NAME='EMP';

--KEY2 제거
alter table emp drop constraint key2;

--테이블 제거 : 외래키를 만들어 놓으면 참조테이블은 지울수... 
drop table pos cascade constraints;
desc pos;
desc emp;

commit;
--view의 생성
create view view_pos as select *from pos;
select * from pos;
desc emp;
commit;
create view view_emp as select *from emp;
select * from emp;
select * from view_emp;

create view view_emp2 as select * from emp where no>=3;
select * from emp where no>=3;
select * from view_emp2;
--view의 삭제
drop view view_emp;
--alter view view_emp2 as select *from emp where no>=2 or name like ;

--뷰 수정
create or replace view view_emp2 as select * from emp where no>=2 or name like '%이%';

--시퀀스(자동순번) 생성/수정/제거/조회 
create sequence emp_seq increment by 1 start with 6 minvalue 1 maxvalue 9999 nocycle;
select * from emp;

--alter sequence emp_seq 수정할 내용
alter sequence emp_seq increment by 1;
--시퀀스 삭제
drop sequence emp_seq;
--emp_seq의 시퀀스 정보 조회
    select * from all_sequences where sequence_name = 'EMP_SEQ';
--emp 테이블에 다음 순번(nextval)으로 적용하여 레코드 추가

-- emp 테이블에 no의 값을 다음 순번(nextval)으로 적용하여 레코드 추가
insert into emp values(emp_seq.nextval, '고', 3);
--현재 시퀀스값 조회
select emp_seq.currval from dual; 
--테이블 복제 (단, 제약조건을 복제가 되지 않음)
create table emp2 as select * from emp;

desc emp2;

select * from emp2;

--no컬럼을 기본키로 설정
alter table emp2 modify no int primary key;
--내부조인(inner join)
select a.no, a.name, b.pcode, b.pname from emp a inner join pos b on a.pcode=b.pcode;
--외부조인(left outer join)
select a.no, a.name, b.pcode, b.pname from emp a left outer join pos b on a.pcode=b.pcode;
--외부조인(right outer join)
select a.no, a.name, b.pcode, b.pname from emp a right outer join pos b on a.pcode=b.pcode;



-직위별 인원수 
join emp on pos.pcode= emp.pcode group by pos.name;




--연관쿼리
select a.no, a.name, b.pname from emp a pos b where a.pcode= b.pcode;

select emp.no, emp.name, pos.pname from emp, pos where emp.pcode= pos.pcode;

select *from emp2;
insert into emp2 values(8. '성', 5);
--서브쿼리(emp2 테이블에 존재하는 no만 emp 테이블 조회)=일치 쿼리
select no, name from emp where no in(select pcode from emp2);
--서브쿼리(emp2 테이블에 존재하지 않는 no만 emp 테이블 조회) =>불일치 쿼리
update emp set pcode=4 where no=4 or no=6 or no=2;

select distinct b.pname, count(*) as cnt from emp a, pos b where emp.pcode=pos.pcode ;
select distinct pcode, count(*) as cnt from emp group by pcode;
--그룹화 하는 항목과 출력되는 항목이 달라서
select pos.pname, count(emp.no) as cnt from pos,emp where pos.pcoed= enp.pcode;

select emp.no emp.name from emp where emp.pcode in(select pcode from pos);
select * from emp, pos; -- 두 테이블간의 product



--집계함수: count, sum, avg, max, min
-- 정렬하여 출력 : 반드시 order by 구절은 맨 끝에다 지정해야 함. 안그럼 오류남
--desc 내림차순 asc 오름차순
select * from emp order by name desc
--집합 연산시에는 연산하는 두개의 테이블의 구조가 같거나 
--연산하는 컬럼명이 같아야 함
--잡합연산 UNION(합집합), INTERSECT(교집합), MINUS(차집합)
select * from emp select * from emp2;





