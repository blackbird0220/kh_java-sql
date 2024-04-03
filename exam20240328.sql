create database kh;
show databases;
use kh;

create table member (member_id varchar(10), member_pw varchar(10), member_name varchar(6), grade_code int, area_code int );

insert into member values('hong01', 'pass01', '홍길동', 10, 02);
insert into member values('leess99', 'pass02', '이순신', 10, 032);
insert into member values('ss50000', 'pass03', '신사임당', 30, 031);
insert into member values('iu93', 'pass04', '아이유', 30, 02);
insert into member values('pcs1234', 'pass05', '박철수', 20, 031);
insert into member values('you_js', 'pass06', '유재석', 10, 02);
insert into member values('kyh9876', 'pass07', '김영희', 20, 031);



create table grade (grade_code int, grade_name varchar(6));

insert into grade values (10, '일반회원');
insert into grade values (20, '우수회원');
insert into grade values (30, '특별회원');


create table area (area_code int, area_name varchar(5));

insert into area values(02, '서울');
insert into area values(031, '경기');
insert into area values(032, '인천');


-- 문제 1) 김영희 회원과 같은 지역에 사는 회원들의 지역명, 아이디, 이름, 등급명을 이름 오름차순으로 조회
SELECT AREA_NAME 지역명, MEMBER_ID 아이디, MEMBER_NAME 이름, GRADE_NAME 등급명
FROM TB_MEMBER
JOIN TB_GRADE ON(GRADE = GRADE_CODE)
JOIN TB_AREA ON (AREA_CODE = AREA_CODE)
WHERE AREA_CODE = (
SELECT AREA_CODE FROM TB_MEMBER
WHERE 이름 = '김영희')
ORDER BY 이름 DESC;

select area_name 지역명, member_id 아이디, member_name 이름, grade_name 등급명 
from memeber join grade on (grade = grade_code) -- 정확하게 지정해주기
join area using (area_code= area_code) -- --------------------------------- 컬럼이름이 같을 경우 using을 사용함
where area_code=(
select area code from member where 이름 ='김영희')
order by 이름 desc; -- asc 로 변경


-- 문제 2) 아이디에 1234가 포함되는 회원과 같은 등급, 같은지역인 회원들의 아이디, 비밀번호, 이름, 등급명, 지역명을 아이디 내림차순으로 조회
SELECT MEMBER_ID AS 아이디, MEMBER_PWD 비밀번호, MEMBER_NAME AS 이름, GRADE_NAME AS 등급명
FROM TB_MEMBER
JOIN TB_GRADE USING(GRADE_CODE)
JOIN TB_AREA USING(AREA_CODE)
WHERE (GRADE, AREA_CODE) =
(SELECT GRADE, AREA_CODE FROM TB_MEMBER
WHERE MEMBER_ID = '1234')
ORDER BY MEMBER_ID DESC;

select member_id as 아이디, member_pw 비밀번호, member_name as 이름, 
grade_name as 등급명 -- 지역명이 설정되지 않아서 지역명이 출력되지 않음
from member join grade using(grade_code) 
join grade using (grade code) 
join area using(area_code)  -- using이 아니라 
where(grade, area_code)= --  아이디가 1234인 사람이 없기 때문에 검색되는 결과가 없다. 
(select grade, area_code from member 
where member_id = '1234');


-- 문제 3) 서울, 경기 지역에 사는 회원들의 정보를 번호, 아이디, 이름, 등급명, 지역명을 아이디 오름차순으로 정렬
-- 		(번호는 ROWNUM을 이용. 메인 쿼리 조회 결과의 번호는 1,2,3,... 순서대로 조회되어야 함.)
SELECT ROWNUM 번호, MEMBER_ID 아이디, MEMBER_NAME 이름, GRADE_NAME 등급명, AREA_NAME 지역명
FROM (SELECT MEMBER_ID, MEMBER_NAME, GRADE_NAME
FROM TB_MEMBER
JOIN TB_GRADE ON(GRADE = GRADE_CODE)
JOIN TB_AREA USING(AREA_CODE)
WHERE AREA_NAME = ('서울', '경기'))
ORDER BY MEMBER_ID;

select rownum 번호, member_id 아이디, member_name 이름, grade_name 등급명 area_name 지역명 
from (select member_id, member_name, grade_name 
from member 
join grade on(grade = grade_name) -- 테이블 이름 앞에 기재해주는 것이 좋음
join area using(area_code)
where area_name = ('서울', '경기') -- =을 in으로 바꿔야 함 
order by member_id; -- select 중복기재, area name이 없음, order by 구절이 밖에 있어서 실행되지 않는다.

















