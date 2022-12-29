/* at_repetition 재수강여부 */
/* 출석이 5 이하 또는 점수 총합이 50점 이하이면 재수강 y*/
/* 점수와 상관없이 출석이 5 이하이면 무조건 y */
update attend set at_repetition =  if(at_attend <= 5, 'y' ,if(at_tot <= 50, 'y','n'));

/* at_score A90, B80, C70, D60, F~*/

update attend set at_score = 
case 
when at_tot < 60 or at_attend <=5 then 'F'
when at_tot >=90 then 'A'
when at_tot >=80 then 'B'
when at_tot >=70 then 'C'
when at_tot >=60 then 'D'
end;
select * from attend;