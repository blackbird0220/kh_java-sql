use kh;

show tables;

select * from memeber;
select * from book;
select * from sales;

-- select 문을 활용한 Update safe mode => sql_safe_updates
-- SQL 실행시 자동 커밋 => antocommit
-- 아래의 내용을 수정하고, MySQL 서버를 재시작하게 되면 Safe Mode와 AutoCommit의 비활성화
-- c:\programData\MySQL Server 8.0\my.ini
-- [mysqld]
-- sql_safe_update = 0
-- autocommit=0

-- WorkBench에서 해당 내용을 설정하고 싶다면, 
-- SET 명령에 해당 옵션을 설정하면 된다.alter
-- SET SQL_SAFE_UPDATES = 0
-- SET AUTOCOMMIT = FALSE : 트랜잭션 처리가 필요한 경우 반드시 OFF(FALSE)이어야 함


-- 엑셀



-- 1) 회원 테이블에 다음과 같은 내용을 추가하시오.
insert into member values ('kkt', 'a1004', '김기태', '가산동 123', '010-1004-1004', '2023-09-12');


-- 2)도서 테이블에 다음 데이터를 추가하시오.
insert into book values(default, 'IT', '스프링크레임워크', 38000, 8, '김기태', '정복사', '2022-09-10');

select count(*) from member; -- 멤버의 수
 
-- 3)판매 테이블에 다음 튜플(레코드)을 추가하시오.
insert into sales values(default, 1, 'kkt', 2, null, now()); -- now() 오늘날짜 함수
insert into sales values(default, 1, 'kkt', 2, null, default);
-- 도서목록 도서코드와 판매도서코드가 같은 도서가격을 가격으로 업데이트
update sales set money=(select bprice from b where bid=sales.bno)*amount;

-- 4)회원 테이블에 기본값이 0인 숫자 데이터를 저장할 포인트(pt) 컬럼을 추가하시오.
alter table member add pt int default 0;


-- 5)회원 테이블에 방문횟수(visited) 컬럼을 추가하시오.(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
alter table member add visited int default 0;

-- 6)회원 테이블에 이메일(email) 컬럼을 추가하시오(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
alter table member add email varchar(200);

-- 7)회원 테이블에 지역코드(areacode) 컬럼을 추가하시오.(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
alter table member add areacode varchar(8);

-- 8) 회원 테이블에 있는 컬럼 중에서 방문횟수 컬럼을 제거하시오.
alter table member drop column visited;

-- 9) 회원 테이블에 지역(areacode) 컬럼의 이름을 areadata 로 변경하시오.
alter table member rename column areacode to areadata;

-- 10) 판매(sales) 테이블을 복제하여 판매2(sales2) 테이블을 만드시오.
create table sales2 as select * from sales;

-- 1) 도서 테이블을 복제하여 도서2(book2) 테이블을 만드시오.
create table book2 as select * from book;

-- 12) 회원 테이블을 복제하여 회원2(member2) 테이블을 만드시오.
create table member2 as select * from member;

-- 13) 판매2(sales2) 테이블을 제거하시오.
drop table sales2;

-- select * from member limit 5, 3(5번째 줄부터 3개의 명령만 실행해서 보여줌) 

-- 14) 복제된 회원2(member2) 테이블에서 아이디가 j가 포함된 회원을 삭제하시오. 항상 지우기 전에 확인부터 하는 습관 만들기
select * from member2 where id like '%j%';
delete from member2 where id like '%j%';

-- 15) 회원(member) 테이블에서 모든 회원에 대한 포인트를 100 이 지급될 수 있도록 변경하시오.
select point from member; -- (멤버들 포인트 조회)
update member set point = point + 100;

-- 16) 회원(member) 테이블에서 회원의 아이디가 lsh인 회원의 주소를 '도화동 27'로 변경하시오.
update member set ad ='도화동 27' where id = 'lsh';

-- 17) 회원2(member2) 테이블에서 연락처가 02인 회원에 대하여 가입일을 오늘날짜로 변경하시오.
select tel from member;
update member2  set reg_date = curdate() where tel like '02%';  -- curdate()는 시간이 안나옴

-- 18) 도서2(book2) 테이블에서 도서 분류가 HC인 레코드에 대하여 도서 수량을 5로 변경하시오.
update book2 set bcount = 5 where bkind like 'HC';

-- 19) 도서2(book2) 테이블에서 도서 분류가 TC인 튜플을 제거하시오.
delete from book2 where bkind like 'TC';

-- 20) 도서2(book2) 테이블에 도서상태(ckdata) 컬럼을 추가하시오.(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
alter table book2 add ckdata varchar(20);

-- 21) 도서2(book2) 테이블에 도서 수량이 7이하인 튜플에 대하여 도서상태를 '재입고요망' 으로 내용을 추가하시오.
update book2 set ckdata='재입고요망' where bcount<=7;

-- 22) 회원2(member2) 테이블에 id를 기본키로 추가하시오. 기본키를 지우려면 constraints 이용해야 함
alter table member2 add contraints mpkey1 primary key(id);

-- 오라클 alter table member2 modify id varchar(12) primary key; -- 또는
-- alter table member2 add constraint idkey primary key(id);
-- alter table memeber2 drop constraints idkey;(기본키 제거)

-- 23) 도서2(boo2) 테이블에 도서코드(bookid)를 기본키로 도서분류(bookkind)를 외래키로 추가하시오.
alter table book2 add constraint bpkey2 primary key (bid);

-- 참조하는 테이블이 존재해야 하므로 bookkind 테이블 생성
drop table bookind;
create table bkind(kindcode varchar(6), kindname varchar(50));
insert into bookkind values('IT', 'IT관련서적');
insert into bookkind values('NV', '소설');
insert into bookkind values('DV', '자기계발');
insert into bookkind values('HC', '역사');
insert into bookkind values('TC', '일반상식');

-- 오라클 create table bkind(kindcode varchar(6) primary key, kindname varchar(50));

-- 외래키(MUL) 설정
alter table book2 add constraint bfkey1 foreign key (bkind) references bkind(kindcode);

-- alter table book2 add constraint bpk2 primary key (bid);
-- alter table book2 add constraint bfk2 foreign key (bkind) references bkind(kindcode);

-- 24) 도서2(book2) 테이블에서 출판일(pubdate)가 2022년 8월 인 데이터의 수량을 5씩 더 증가시키시오.
update book2 set bcount = bcount +5 where pubdate between '2022-08-01' and '2022-08-30';



-- 25) 회원(member) 테이블에서 모든 회원의 모든 정보를 조회하시오.
select * from member;

-- 26) 판매(sales) 테이블에서 구매한 적이 있는 회원의 아이디를 중복을 제거하여 조회하시오. distinct 중복제거
select distinct id, name, tel from member where id in (select id from sales);


-- 27) 도서(book) 테이블에서 도서종류(bookkind)가 IT인 튜플을 검색하시오.

select * from book where bkind='IT';


-- 28) 회원(member) 테이블에서 아이디가 k가 포함된 회원의 이름(name),  연락처(tel) 컬럼을 검색하시오.
select name, tel from member where id like '%k%';


-- 29) 판매(sales) 테이블에서 수량(amount)이 2이상인 레코드를 검색하시오.
select * from sales where amount >= 2;

-- 30) 도서(book) 테이블에서 단가(bookprice)가 19000이상 30000이하인 데이터의 도서명(booktitle) 
--     도서가격(bookprice), 저자(author) 를 조회하시오. 
select btitle, bprice, author from book where bprice>=19000 and bprice<=30000;
select btitle, bprice, author from book where bprice between 19000 and 30000;

-- 31)  도서(book) 테이블에서 출판사(pubcom)이 한빛미디어 이거나 남가람북스인 
-- 튜플의 도서명(booktitle), 저자(author), 수량(bookcount)를 조회하시오.
select btitles, author, bcount from book where pubcom = '한빛미디어' or pubcom='남가람북스';

-- 32) 도서(book) 테이블에서 출판일(pubdate)이 2022년인 튜플을 검색하시오. date는 varchar 와 timestamp의 중간 자료형
select * from book where pdate  >='2022-01-01' and pubdate <='2022-12-31';
select * from book where pubdate between '2022-01-01' and '2022-12-31';
--select * from book where pubdate like '2022%' (x);

-- 33) 회원(member) 테이블에서 비밀번호(password)가 5글자 이상인 회원의 아이디(id), 이름(name), 주소(tel)을 검색하시오.
select id, name, tel from member where length(pw)>=5;


-- 34) 도서(book) 테이블에서 출판일(pubdate)을 기준으로 오름차순하여 검색하되 출판일(pubdate)이 같은 경우
--		도서코드(bookid)의 내림차순으로 하시오.
select * from book order by pubdate asc, bookid desc;
-- 오름차순 asc: 작은 것에서부터 큰 것순으로
-- 내림차순 desc: 큰 것에서부터 작은 것순으로

-- 35) 도서(book) 테이블에서 도서의 수량(bookcount)가 10권 미만인 튜플에 대하여 도서분류(bookkind), 도서명(booktitle), 출판사(pubcom) 을 검색하되 
-- 		그 결과가 저자(author)의 오름차순으로 정렬하여 표시되도록 하시오.
select bkind, btitle, pubcom from book where bcount<10 order by author;

-- 36)  도서(book) 테이블에서 도서분류(bookkind)가 IT, NV, TC가 아닌 레코드의 도서코드(bookid), 도서명(booktitle), 저자(author) 를 검색하되
-- 		그 결과가 출판일을 기준으로 내림차순되어 표시되도록 하시오.
select bid, btitle, author from book where bkind not in('IT','NV','TC') order by pubdate desc;

-- 36) 판매(sales) 테이블의 전체 구매 건수를 출력하되 표시되는 컬럼명은 구매건수로 출력될 수 있도록 조회하시오. *******
select count(*) as "구매건수" from sales; -- "한글과 같이 영어가 아니거나/ 영어명인데 띄어쓰기가 되어있으면 쌍따옴표 사용"

-- 37) 판매(sales) 테이블의 회원별 구매 건수를 출력하되 회원아이디(id)와 구매건수를 표시하되 컬럼명은 구매건수로 하며,
-- 		회원아이디(id)의 오름차순 정렬되어 표시되도록 하시오.
select id, count(*) as "구매건수" from sales group by id having order by id; -- group by 사용할 때는 where 가 아니라 having

-- having 문제 못 적음



select id, count(*) as "구매건수" from sales group by id order by id;

-- 38) 판매(sales) 테이블의 도서별 판매금액의 합계를 구하여 표시하되, 도서코드(bno), 판매금액합계 로 출력되게 하시오.
select bno, sum(money) as "판매금액합계" from sales;

select b.bno, a.btitle, sum(b.money) as "판매금액합계" from book a inner join sales b on a.bid = b.bno group by b.bno, a.btitle;
-- 연관쿼리
select b.bno, a btitle, sum(b.money) as "판매금액합계" from book a, sales b where a.bid = b.bno group by b.bno, a.btitle;
 

-- 39) 판매(sales) 테이블에서 가장 큰 판매금액을 출력하되, 회원아이디(id), 도서코드(bno), 판매금액이 표시되도록 하시오.
select id, bno, max(money) as  "최대판매금액" from sales group by id, bno; 

-- 40) 회원(member) 테이블에서 가입일별 인원수를 구하여 출력하되, 가입일 오름차순으로 출력되도록 하시오.
select reg_date, count(*) as "인원수" from member group by reg_date order by reg_date;

-- select reg_date, count(*) as "인원수" from member group by reg_date order by reg_date;

-- 41) 도서(book) 테이블에서 도서수량(bookcount)가 남은 수량이 적은 것을 기준으로 5위권까지 모든 도서 정보가 출력되도록 하시오. (rownum 남은 수량)
select * from book order by bookcount asc limit 5;
-- select * from (select * from book order by bcount asc) where rownum<=5;

-- 42) 판매(sales) 테이블에서 판매금액(money)가 큰 순으로 3위 까지인 튜플의 판매코드(sno), 도서코드(bno), 회원아이디(id)가 출력될 수 있도록 하시오.

select sno, bno, id from sales order by money desc limit 3;
-- select sno, bno, id from (select * from sales order by money desc) where rownum<=3;

-- 43) 회원 뷰(mem_view)를 생성하되 회원2(member2) 테이블을 활용하고, 회원 데이터 중에서 가입일을 기준으로 2022년 09월 이후에 가입한 회원을 대상으로 하시오. -- 이후는 당일 포함
create view mem_view --------------------
create view mem_view as (select * from member2 where reg_date >= '2022-09-01');


-- 44) 판매 뷰(mem_view)를 생성하되 판매2(sales) 테이블을 활용하고, 판매코드(sno), 도서코드(bno), 아이디(id), 판매금액(money) 컬럼만 추출되어 생성되게 하시오.
create view sales_view as select sno, bno, id, money from sales2 ;
select * from  sales_view;

-- 45) 도서 뷰(book_view)를 생성하되 도서2(book2) 테이블을 활용하고, 도서 데이터 중에서 도서분류(bookkind)가 'IT', 'TC', 'HC' 인 데이터를 대상으로 하며, 
-- 컬럼은 도서분류(bookkind), 도서명(booktitle), 도서가격(bookprice), 출판사(pubcom) 만으로 구성되게 하시오.
create view book_view as select bid, btitle, bprice, pubcom from book2 where bkind in ('IT','TC','HC');

-- 46) 도서 뷰(book_view)에서 도서가격(bookprice)가 현재 가격에서 10% 인상이 될 수 있도록 데이터를 갱신하시오.(데이터 변경)
update book_view set bprice=bprice*1.1; 
select * from book_view;

-- 47) 판매 뷰(sales_view)를 편집하되 기존 select 구문에서 수량(amount) 가 2이상인 조건을 추가되게 하시오.(sql 구문을 바꾸는 것)
create or replace view sales_view as select * from sales2 where amount >=2;

select * from sales_view;

-- 48) 회원 뷰(mem_view)에서 아이디(id)가 y로 끝나는 회원의 데이터를 삭제하시오.
delete from mem_view where id like '%y';

-- 49) 판매 뷰(sales_view) 를 제거하시오.
drop view sale_view;

-- 50)  판매 뷰(sales_view) 를 제거하시오.
drop view sale_view;

-- 51) 상반기 판매순번 시퀀스(sd_seq)를 만들되 1부터 1씩 증가하도록 생성하시오.
-- create sequence sd_seq start with 1 increment by 1; 
-- MariaDB와 MySQL에서는 시퀀스 개념이 사용되지 않는다. 또한 사용하려면 별도로 설치가 필요함. 

-- 52) 상반기 판매순번 시퀀스(sd_seq)를 시작값이 6부터 될수 있도록 수정하시오.
-- drop sequence sd_seq;
-- create sequence sd_seq start with 6 increment by 1;
-- MariaDB와 MySQL에서는 시퀀스 개념이 사용되지 않는다. 또한 사용하려면 별도로 설치가 필요함. 

-- 53) 상반기 판매순번 시퀀스(sd_seq)의 현재값이 조회될 수 있도록 하시오.
-- select system.sd_seq.currval from dual;

-- MariaDB와 MySQL에서는 시퀀스 개념이 사용되지 않는다. 또한 사용하려면 별도로 설치가 필요함. 
-- 54) 상반기 판매순번 시퀀스(sd_seq)를 제거하시오.
-- drop sequence sd_seq;
-- MariaDB와 MySQL에서는 시퀀스 개념이 사용되지 않는다. 또한 사용하려면 별도로 설치가 필요함. 

-- 55) 서브쿼리를 이용하여 구매한 적이 있는 (판매 테이블에 있는) 회원의 이름(name)을 중복성을 제거하여 조회하시오.
select distinct name from member where id in (select id from sales);
-- select name from member where id in (select id from sales);
-- select name from member where id not in(select id from sales);

-- 56) 서브쿼리를 이용하여 판매되지 않은 (판매 테이블에 있는) 도서의 정보를 조회하시오.



select * from book where bid not in (select bno from sales);

-- 57) 서브쿼리를 활용하여 판매 테이블에서 판매금액의 평균이상인 모든 컬럼을 조회하시오.




select * from sales where money>=(select avg(money) from sales);

-- 58) 내부조인을 활용하여 판매된 적이 있는 도서이름(booktitle), 도서가격(bookprice), 판매수량(amount), 판매금액(money) 을 조회하시오.


select a btitle, a.bprice, b.amount, b.money from book a inner join sales b on a bid=b.bno;

-- 58) 내부조인을 활용하여 구매한 적이 있는 회원아이디(id), 회원명(name), 판매수량(amount), 판매금액(money) 을 조회하시오.
select a.id, a.name, a.amount, a.money from member a inner join sales b on a.id = b.id; 

select a.id, a.name, b.amount, b.money from member a inner join sales b on a.id=b.id;



-- 59) 내부조인을 활용하여 구매한 도서의 도서코드(bid), 도서명(bname), 총판매수량합계(amount), 총판매금액(money)을 조회하시오.

select a.bid, a.btitle, sum(b.aomount) as "총판매수량합계", sum(b.money) as "총판매금액" 
from book a inner join sales b on a.bid = b.bno group by a.bid, a,btitle order by a bid;
 

-- 60) 외부조인을 활용하여 판매되지 않은 도서의 도서명(booktitle), 도서가격(bookprice), 저자(author) 을 조회하시오.
select distinct btitle , bprice, author from book where bid not in (select bno from sales);
--  교집합:   select distinct a.btitle , a.bprice, a.author from book a, sales b where a.bid = b.bno;
--  차집합: 	select distinct a.btitle , a.bprice, a.author from book a left join sales b on a.bid = b.bno where b.bno is null;
-- *** 제일어려운 내용 	select distinct a.btitle, a.bprice, a.author from book a where not exists(select 1 from sales b where a.bid = b.bno)

-- 61) 외부조인을 활용하여 구매한 적이 없는 회원의 회원아이디(id), 회원명(name) 을 조회하시오.
select id, name from member where id not in (select distinct id from sales);
-- 연관쿼리 select distinct a.btitle, a.bprice, a.author from book a, sales b where a.bid = b.bno;
-- 
-- 62) 판매(sales)와 판매2(sales2) 테이블을 합집합하여 종합 판매 뷰(tot_sales_view)를 생성하시오. 
create view tot_sales_view as (select * from sales UNION select *from sales2);

-- 63) 회원(member)와 회원2(member2) 테이블을 교집합하여 중복회원 뷰(cross_mem_view)를 생성하시오. 
select view cross_mem_view as (select * from member INTERSECT select * from member2);


-- 64) 도서(book)와 도서2(book2) 테이블을 차집합하여 도서(book)에만 있는 도서 뷰(minus_book_view)를 생성하시오. 
-- 	서브쿼리를 이용한 차집합 뷰 작성
create view minus_book_view as select bid, bkind, btitle , bcount from book where bid not in ( select distinct bookid from book2);
-- 외부저인을 이용한 차집합 뷰 작성
create view minus_book_view2 as select a.bid, a.bkind, a.btitle, a.bcount from book a left join

select * from book2;
-- 외부조인을 이용한 차집합 뷰 작성


