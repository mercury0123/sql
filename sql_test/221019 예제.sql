-- 1. 2022년도 1학기 '대학수학'의 수강자 명단 출력

select distinct st_name as '대학수학 수강자 명단' from student 
join attend on st_num = at_st_num
join course on at_co_num = co_num
join subject on co_sub_num = sub_num 
where co_year = 2022 and co_term = 1 and sub_title = '대학수학' order by st_name;
-- group by 로 중복제거 하고 정렬해도 됨!!


-- 2. 전체 수강자 명단 학번, 이름 출력 (중복없이)

select distinct st_num '학번', st_name '이름' from student
join attend on st_num = at_st_num
join course on at_co_num = co_num
join subject on co_sub_num = sub_num group by st_num;
-- group by 는 한 변수만 써줘도 된다 group by st_num,st_name; 이렇게 안써도 됨


-- 3. 2020123001(김영철) 학생이 수강하는 강의번호 출력
-- 4. 2020123001(김영철) 학생이 수강하는 강의명 출력

select distinct sub_code, sub_title from subject 
join course on sub_num = co_sub_num
join attend on co_num = at_co_num
join student on at_st_num = st_num
where st_name = '김영철';



-- 5. 2020123001(김영철) 학생이 2022 2학기에 수강하는 강의시간표 출력
-- 6. 2020123001(김영철) 학생이 2022 2학기에 수강하는 과목명 출력

select distinct co_timetable '시간표', sub_title'과목' from subject 
join course on sub_num = co_sub_num
join attend on co_num = at_co_num
join student on at_st_num = st_num
where st_name = '김영철' and co_year =2022 and co_term =2;


-- 7. 2010160001(강길동) 교수님이 지도하는 학생의 학번 출력
-- 8. 2010160001(강길동) 교수님이 지도하는 학생의 이름 출력

select distinct st_num '학번', st_name '이름' from student
join guide on st_num = gu_st_num
join professor on gu_pr_num = pr_num
where pr_name = '강길동';

