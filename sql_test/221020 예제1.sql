select * from attend;
desc attend;

-- 40 / 40 / 10/ 10 을 맥스값으로 해서 at_score ( ABCDF 형태로) 구하기 

update attend set at_score = at_mid + at_fin + at_attend + at_homework;

update attend set at_score = 
case 
when at_score >=90 then 'A'
when at_score >=80 then 'B'
when at_score >=70 then 'C'
when at_score >=60 then 'D'
when at_score < 60 then 'F'
end;



-- 2022년 2학기 데이터는 0으로 변경 
-- at_pass 변경 : 학점이 'F' 이고, 출석이 3미만이면 N 아니면 Y
-- at_repetition : at_pass N 이면 재수강 Y



update attend join course on at_co_num = co_num 
set at_mid =0, at_fin =0, at_attend =0, at_homework =0, at_score = null 
where co_term = 2 and co_year = 2022;

-- update attend set at_score - null
-- where at_co_num in 
-- (select co_num from course where co_year=2022 and co_term-2);
-- join 안주고 위처럼 해도 됨

update attend set at_pass = if(at_score ='F'or at_attend < 3, 'N','Y');
update attend set at_repetition = if(at_pass = 'N', 'Y' ,'N');

-- at_score 가 null 이면 at_pass at_repetition 도 null 로
update attend set at_pass = null, at_repetition = null where at_score is null;


-- pass를 못한 친구들의 명단 출력 (가나다순)
select distinct st_name '불합격자 명단' from student
join attend on st_num = at_st_num where at_pass ='N' order by st_name;

-- 학생(이름)별로 중간, 기말의 평균을 출력
select st_name '이름', round(avg(at_mid),1) as '중간 고사 평균' from attend 
join student on at_st_num = st_num
join course on at_co_num = co_num
where co_year = 2022 and co_term = 1
group by st_name order by st_name;


select st_name '이름', round(avg(at_fin),1) as '기말 고사 평균' from attend 
join student on at_st_num = st_num
join course on at_co_num = co_num
where co_year = 2022 and co_term = 1
group by st_name order by st_name;



-- score 별 인원수 출력 

select at_score '학점', count(at_score)'인원수' from attend where at_score is not null	
-- null은 is is not 으로 설정
group by at_score order by at_score;


-- student 테이블의 st_point는 subject 테이블의 각 sub_point의 합계
-- st_point 학번별로 각 sub_point의 합계

update student set st_point = 
(select sum(sub_point) from subject 	-- from 테이블명 을 주체로 해서 join 대상 테이블 정한다
join course on co_sub_num = sub_num
join attend on at_co_num = co_num
where co_year = 2022 and co_term = 1 and st_num = at_st_num
group by at_st_num); 


select * from course;
select * from attend;
select * from subject;
select * from student;

-- course 테이블에 co_degree 필드 추가
-- co_degree : 각 코스를 수강하는 인원을 집계하는 필드

alter table course add co_degree int default 0; 

update course set co_degree = (
select count(at_co_num) from attend
where at_co_num = co_num
group by at_co_num);


-- trigger 생성, attend 테이블에 insert 하면 co_degree 값이 1증가
-- 혹시 모르니 drop 관련 트리거 생성

drop trigger if exists insert_attend;
delimiter //
create trigger insert_attend after insert on attend		-- insert_attend 트리거 생성, attend 테이블에 새값 생기면
for each row
begin 
update course set co_degree = co_degree +1	
where co_num = new.at_co_num;
end //
delimiter ; 


insert into attend(at_num,at_st_num,at_co_num)
values(30,2020123001,1);
select * from attend;
select * from course;

-- 프로시저를 이용하여 학번을 입력하면 학번, 이름, 과목, pass 여부를 출력해주는 프로시저 생성
-- 프로시저 명 : select_pass

drop procedure if exists select_pass;
delimiter //
create procedure select_pass (
in_st_num int)
begin
select st_num, st_name,sub_title,at_pass from student 
join attend on at_st_num = st_num
join course on at_co_num = co_num
join subject on co_sub_num = sub_num
where st_num = in_st_num;
end//
delimiter ;

call select_pass(2020123001);
