/*
     字符函数
*/
--字符拼接
select concat('studen','person') from dual;
--首字母变大写
select initcap('sssdd') from dual;
--返回小写字符
select lower('SERING') from dual;
--字符都变成7，如果没有7位就用a代替
select ename,lpad(ename,'7','a') from emp;
--把字段中所有A变成a
select ename,replace(ename,'A','a') from emp;
--清除末尾的字符
select rtrim('gao qiao jing','g') test from dual;
--清除前面的字符
select trim(both 's' from 'xxxxssssdd') from dual;
--提取给定的字段
select substr('ashgodn',1,3) from dual;
--小写转大写
select upper('hello word') from dual;
--提取字符在哪儿出现的位置
select instr('hello word','w') from dual; 
--获得字符的长度
select length('hello word') from dual;

/*
              数值函数       
*/
--四舍五入,后面的参数表示保留几位
select round(11.5) from dual;
select round(11.4) from dual;
select round(22.265,2) from dual;
--去掉末尾，后面参数表示保留几位
select trunc(22.265) from dual;
select trunc(22.265,2) from dual;
--取余数
select mod(15,4) from dual;
--向上取整
select ceil(15.2) from dual;
--向下取整
select floor(15.6) from dual;

/*
              时间函数     
*/
--查询当前时间,两种方式
select sysdate from dual;
select current_date from dual;
--获得加几天后的，日期
select add_months(sysdate,2) from dual;
--返回本月的最后一天
select last_day(sysdate) from dual;
--
select * from emp;
--返回两个日期之间的月数
select ename,hiredate, months_between(sysdate,sysdate-50) from emp;

/*
       转换函数
*/
--日期转换
select to_char(sysdate,'yy-mm-dd hh24:mi:ss') 当前时间 from dual;
select ename,hiredate,to_char(hiredate,'yyyy-mm-dd') 转后的格式 from emp;
--数值转换
select ename,sal,to_char(sal,'$999,999.999') salary from emp ;
select to_char(2250,'$000,000.000') from dual;
select to_char(1555,'99,99.00') from dual;
--字符转日期
select to_date('19,05,25,22,12,25','yy-mm-dd hh24:mi:ss') from dual;
select to_date('2019-05-25','yyyy-mm-dd') from dual;
--字符转数值
select to_number('$1224.56','$9000.000') from dual;
select to_number('11.25','99.999') from dual;

/*
       嵌套函数
*/
select ename,nvl(to_char(comm),'0') from emp where comm in null;
--显示员工雇佣期满6个月的后下一个星期二的的日期
select to_char(next_day(add_months(hiredate,6),'星期二'),'fmday,month,yyyy') review from emp order by hiredate;
--按部门给员工涨工资
select ename,sal,decode(deptno,30,sal*1.1,20,sal*1.2,10,sal*1.3)  from emp;
select ename,
       sal,
       deptno,
       case deptno
         when 30 then
          sal * 1.1
         when 20 then
          sal * 1.2
         when 10 then
          sal * 1.3
       end
  from emp;
--查询员工是82年的
select hiredate from emp where to_char(hiredate,'yy') = '82' ;
--查询工龄39年的
select hiredate from emp where to_char(sysdate ,'yyyy') - to_char(hiredate,'yyyy') =39;
--显示员工6个月后的下一个星期五
select ename,
       to_char(next_day(add_months(hiredate, 6), '星期五'),
               'fmday,month,yyyy') review
  from emp
 order by hiredate;
 --
 select * from emp
 --查询出没有上级领导的人，并设置成boss
 select ename,nvl(to_char(mgr),'boss') from emp where mgr is null;
 

/*
        组函数
*/
select avg(sal) from emp; --平均数
select min(sal) from emp;--最小值
select max(sal) from emp;--最大值
select sum(sal) from emp;--求和
select count(sal) from emp;--多少条数
--求部门员工平均工资大于2000
select avg(sal),deptno from emp group by deptno having avg(sal) > 2000 order by deptno;
select deptno ,avg(sal) from emp where sal >1200 group by deptno having avg(sal) >1500 order by deptno;
--查询部门员工最老员工和最新员工
select e1.ename, e1.hiredate, e1.sal
  from emp e1,
       (select max(hiredate) mind, min(hiredate) maxd
          from emp e
         where e.deptno = 10) e2
 where e1.hiredate = e2.mind
    or e1.hiredate = e2.maxd;

--找字符位置，加长度，替换字符
select instr('software','f'),rpad('software',15,'*'),replace('software','a','j') from dual;
 -- 有奖金就显示有，无就显示无
select  nvl2(comm, 'wu', 'you')from emp 
--获得当前日期，列名为date，在加6月，后的星期日，以及本月最后的日期
select sysdate as "Date" , add_months(sysdate , 6),next_day(add_months(sysdate , 6),'星期日')，last_day(add_months(sysdate,6)) from dual;

select * from emp where deptno =30
--查询老板工号按升序排
select ename,nvl(mgr,9999) from emp order by mgr desc;
--按部门就平局工资
select avg(sal),deptno from emp group by deptno;
--按部门求出工资大于1300 的平均工资，最小佣金，最大佣金，并且佣金大于100
select deptno, avg(sal),min(comm),max(comm) from emp where  sal >1300 and comm >100 group by deptno;
--找出每个部门的平均，最大，最小工资
select avg(sal),min(sal),max(sal) from emp group by deptno;

select * from salgrade;
--查询每个员工的 工资等级
select e.ename,e.deptno,e.sal,s.grade from emp e,salgrade s where sal between s.losal and hisal; 
