create table student(
st_num int not null ,
st_name varchar(20) not null,
st_term int not null default 0,
st_point int not null default 0,
primary key(st_num));

insert into student (st_num,st_name,st_term)
values
(2020123001,'김영철',2),
(2020123002,'나영희',2),
(2020160001,'강철수',2),
(2020160002,'박철수',2),
(2020456001,'강군',2);

create table course (
co_num int not null auto_increment,
co_pr_num int not null,
co_sub_num int not null,
co_term varchar(10) not null default 1, 
co_year int not null,
co_timetable varchar(100) not null,
primary key(co_num));

insert into course (co_pr_num,co_sub_num,co_term,co_year,co_timetable)
values
(2005789001,1,1,2022,'월2a/2b/3a/3b/4a/4b'),
(2005789001,1,2,2022,'월2a/2b/3a/3b/4a/4b'),
(2010160001,2,1,2022,'화1a/1b/2a/2b'),
(2010160001,3,1,2022,'목2a/2b/3a/3b/4a/4b'),
(2011123001,4,2,2022,'화1a/1b/2a/2b'),
(2011123001,5,2,2022,'수1a/1b/2a/2b');


create table attend (
at_num int not null,
at_st_num int not null,
at_co_num int not null,
at_mid int not null ,
at_fin int not null ,
at_attend int not null ,
at_homework int not null ,
at_score varchar(45) default 'n',
at_pass varchar(1) default 'n',
at_repetition varchar(1) default 'n',
primary key(at_num));

insert into attend (at_num,at_st_num,at_co_num,at_mid,at_fin,at_attend,at_homework)
values 
(1,2020123001,1),
(2,2020123001,2),
(3,2020123001,3),
(4,2020123001,5),
(5,2020123002,2),
(6,2020123002,4),
(7,2020123002,6),
(8,2020160001,1),
(9,2020160001,3),
(10,2020160001,6),
(11,2020160002,2),
(12,2020160002,4),
(13,2020160002,5),
(14,2020456001,1),
(15,2020456001,3),
(16,2020456001,4),
(17,2020456001,6),
(18,2020123001,1),
(19,2020160001,4),
(20,2020160001,2),
(21,2020160002,4),
(22,2020456001,5),
(23,2020160001,6),
(24,2020160002,1),
(25,2020160002,1),
(26,2020123001,5),
(27,2020123001,4);

create table subject (
sub_num int not null auto_increment,
sub_code varchar(20) not null,
sub_title varchar(45) not null,
sub_point int not null default 0,
sub_time int not null default 0,
primary key(sub_num));

insert into subject (sub_code,sub_title,sub_point,sub_time)
values
('msc001','대학수학',3,3),
('com001','컴퓨터개론',2,2),
('com002','운영체제',3,3),
('acb001','글쓰기',2,2),
('abc002','영어1',2,3);


create table professor (
pr_num int not null,
pr_name varchar(20) not null,
pr_age int not null,
pr_room varchar(45) not null,
pr_state varchar(45) not null default '재직',
pr_position varchar(45) not null default '조교수',
primary key (pr_num));

insert into professor (pr_num,pr_name,pr_age,pr_room,pr_state,pr_position)
values
(2005789001,'홍길동',60,'B동302호','재직','정교수'),
(2006456001,'박영실',60,'B동301호','안식년','정교수'),
(2010160001,'강길동',55,'A동202호','재직','정교수'),
(2011123001,'이순신',55,'A동203호','재직','정교수');

create table guide (
gu_num int not null auto_increment,
gu_pr_num int not null,
gu_st_num int not null,
gu_year varchar(45) default null,
primary key (gu_num));

insert into guide (gu_pr_num,gu_st_num,gu_year)
values
(2010160001,2020160001,2020),
(2010160001,2020160002,2020),
(2011123001,2020123001,2020),
(2011123001,2020123002,2020),
(2006456001,2020456001,2020);

alter table attend add foreign key (at_st_num) references student (st_num);
alter table attend add foreign key (at_co_num) references course (co_num);
alter table course add foreign key (co_pr_num) references professor (pr_num);
alter table course add foreign key (co_sub_num) references subject (sub_num);
alter table guide add foreign key (gu_pr_num) references professor (pr_num);
alter table guide add foreign key (gu_st_num) references student (st_num);


select * from student;
select * from course;
select * from attend;
select * from subject;
select * from professor;
select * from guide;