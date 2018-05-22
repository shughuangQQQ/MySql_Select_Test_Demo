



#授权
grant  select on  0506colin.test to testshuang;


#撤回
revoke select on 0506colin.test from testshuang; 


create user mytest identified by '123456';


alter user mytest identified by '123478';

drop user mytest;

use 0506colin;

create table PInfo
(
      num int primary key ,#主键约束，表中这列不允许重复
      name varchar(45) unique , #唯一约束
      sex   ENUM('男','女'),#枚举类型
      age   int default 18  #默认约束
);

create table Ptest
(
     number int   references Pinfo(num),
     name  varchar(55)
     
);


alter table Pinfo
add tt varchar(10);


alter table Pinfo
modify tt int;

alter table Pinfo
drop column tt;


drop table  test;


#use 数据库名；
#查询
#select 列名 from 表名
select num from pinfo;
select num,age,name from pinfo;
select * from pinfo;
#添加
insert into pinfo values(8,'插入生','男',20);

insert into pinfo(num,age) values(10,30);
#修改
update pinfo set sex = '女';

#删除
delete from pinfo;


select * from pinfo where num = 1;


select * from pinfo where num != 1;
select * from pinfo where num <> 1;
select * from pinfo where num >=1 and num <=6;

select * from pinfo where num between 1 and 6;

select * from pinfo where num in(4,7,10);


select * from pinfo where num not in(4,7,10);

update pinfo set sex ='男' where num = 8;

#模糊查询

select * from pinfo where name like '灰%';


select * from pinfo where name like '%灰';

select * from pinfo where name like '%灰%';
select * from pinfo where name like '_灰%';




use 0506colin;

select * from pinfo;

insert into pinfo values(12,'testt','女',59);

update pinfo set sex = '男' where name like 't%';


delete from pinfo where num = 12;

select * from student order by sage asc;

select * from student order by sage desc;


select * from student limit 2,3;


select * from student;


#select isnull(要判断的值,如果第一个参数返回的值);

select ifnull(0,4);


select count(*) from student;


select sum(score) from sc;

select avg(score) from sc;

select * from student;
insert into student(snum)  values(12);


select snum,sum(score) from sc group by snum having sum(score) >200 order by sum(score) desc;

#求学生表中男生和女生的个数
select ssex,count(*) from student group by ssex;

select snum,sum(score) from sc 
where snum !='01' 
group by snum 
having sum(score) >200 
order by sum(score) desc ;


select * from student;
select * from sc;


#多表查询


#内联

select * from student
inner join  sc on student.snum = sc.snum;


#左联

select * from student
left join  sc on student.snum = sc.snum;

#右联
select * from student
right join  sc on student.snum = sc.snum;

#笛卡尔积

select * from student,sc where student.snum = sc.snum;

# 01
select *,
(select score from sc where cnum ='01' and sc.snum = student.snum) sc01,
(select score from sc where cnum ='02' and sc.snum = student.snum) sc02
from student ;


select * from (select *,
(select score from sc where cnum ='01' and sc.snum = student.snum) sc01,
(select score from sc where cnum ='02' and sc.snum = student.snum) sc02
from student ) a where sc01 >sc02;

#02

# 01 > 02

select * from student 
inner join sc  on student.snum = sc.snum and cnum ='01'
inner join sc sc02 on student.snum = sc02.snum and sc02.cnum ='02'
where sc.score > sc02.score;

select student.*,sc.score sc01,sc02.score sc02 from student 
inner join sc  on student.snum = sc.snum and cnum ='01'
inner join sc sc02 on student.snum = sc02.snum and sc02.cnum ='02';

select * from 
(select student.*,sc.score sc01,sc02.score sc02 from student 
inner join sc  on student.snum = sc.snum and cnum ='01'
inner join sc sc02 on student.snum = sc02.snum and sc02.cnum ='02'
) a;


select * from sc where cnum ='01';

select * from sc where cnum ='02';


select student.*, a.snum,a.score sc01,b.score sc02 from (select * from sc where cnum ='01') a 
inner join (select * from sc where cnum ='02') b  on  a.snum = b.snum
inner join student  on student.snum = a.snum;

#3、查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩

select student.snum,sname,avg(score) from sc 
inner join student on student.snum = sc.snum group by student.snum
having  avg(score) >=60;

#5、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩
#5.1、查询所有有成绩的SQL。


select  s.snum,sname,count(cnum),sum(score) from student s
inner join sc on s.snum = sc.snum 
group by s.snum,sname;

#5.2、查询所有(包括有成绩和无成绩)的SQL。


#6、查询"李"姓老师的数量 
select count(*) from teacher where tname like '李%';

#视图 是一张或者多张表导出的虚拟表

select s.*,cnum,score from student s
inner join sc  on s.snum = sc.snum;



create view myview as(
select s.*,cnum,score from student s
inner join sc  on s.snum = sc.snum);


select * from myview;


update student set sname ='test' where snum = '01';

insert into myview(snum,sname,ssex) values('11','aa','男');


drop view myview;


select snum,avg(score) from sc group by snum;

create view myview as (select snum,avg(score) from sc group by snum);

insert into myview values(10,300);


drop view myview;


drop function if exists myadd;
delimiter //
create function myadd(a int, b int)
returns int
begin
    declare c int default 0;
    set c = a+b;
    return c;
   
end //

delimiter ;

set @a = myadd(5,6);

select @a;


drop function if exists myFun;
delimiter //
create function myFun(a int)
returns varchar(10)
begin
      declare b varchar(10) default '';
     if(a = 0)
     then set b = '等于0';
     elseif(a <0) then set b = '小于0';
     else set b = '大于0';
     end if;
     
    return b;
end //

delimiter ;

select myFun(5);

drop function if exists myFun;
delimiter //
create function myFun(a int)
returns varchar(10)
begin
      declare b varchar(10) default '';
      case a when 1 then set b = '等于0';
      when  2 then set b = '大于0';
       else
       set b = '小于0';
      end case;
     
    return b;
end //

delimiter ;


select myFun(2);

drop function if exists myFun;
delimiter //
create function myFun(a int)
returns int
begin
      declare nsum int default 0;
	  declare i   int default 0;
      
	  out_label: BEGIN 
    
      while (i <= a) do
     
	   set nsum = i + nsum;
	   set i = i+ 1;
       if(i = a) then leave out_label;
       end if;
       
       end while;
      
	END out_label;
     
    return nsum;
end //

delimiter ;

select myFun(10);


drop function if exists myFun;
delimiter //
create function myFun(nmonth int)
returns int
begin
      declare f1 int default 1;
      declare f2 int default 1;
	  declare f3 int default 0;
	  declare i   int default 3;
      
      if(nmonth = 1 or nmonth =2)
      then return 1;
      end if;
      
      while (i <= nmonth) do
		set f3 = f1 + f2;
        set f1= f2;
        set f2 = f3;
	   set i = i+ 1;      
       end while;
       
    return f3;
end //

delimiter ;

select myFun(11);


drop function if exists myFun;
delimiter //
create function myFun(nmonth int)
returns int
begin
   
       select * from student;
    return 0;
end //

delimiter ;

select myFun(11);


drop procedure if exists myProc;
delimiter //
create procedure myProc(ncurrentpage int ,pagenum int)
begin
      declare noffset int default 0;
      declare ncountnum int default 0;
      declare ncountpage int default 0;
      set ncountnum = (select count(*) from student);
      
      set ncountpage = ncountnum/pagenum;
      
      if(ncurrentpage >ncountpage)
      then set ncurrentpage = ncountpage;
      end if;
      
      set noffset = (ncurrentpage-1)*pagenum;
	 select * from student limit noffset,pagenum;
end //
delimiter ;

call myProc(10,4);














