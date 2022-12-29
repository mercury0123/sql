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
where st_num = in_st_num and at_pass is not null;
end//
delimiter ;

call select_pass(2020123001);

-- 김영철 학생의 지도교수 이름을 출력student
select st_name'학생명', pr_name '지도교수' from guide 
join student on gu_st_num = st_num 
join professor on gu_pr_num = pr_num
where st_name = '김영철';

select pr_name from guide
join (select * from student where st_name ='김영철') student on gu_st_num = st_num
join professor on pr_num = gu_pr_num;

-- 김영철 학생이 들었던 강의 정보 출력 (co_year, co_term, sub_title)
select co_year, co_term, sub_title from attend
join course on co_num = at_co_num
join subject on sub_num = co_sub_num 
join (select * from student where st_name ='김영철') student on st_num = at_st_num;


