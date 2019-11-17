# Oracle数据库默认三张表的sql练习62题

**（1）** 查询20号部门的所有员工信息。

~~~sql
Select * from emp e where e.deptno = 20;
~~~

**（2）** 查询所有工种为CLERK的员工的工号、员工名和部门名。 

```sql
select empno ,ename,deptno from emp where job='CLERK';
```

select ename,sal,comm from emp where comm > sal;                                                                                                                                                                                                                 

**（3）** 查询奖金（COMM）高于工资（SAL）的员工信息。

~~~sql
select ename,sal,comm from emp where comm > sal;
~~~

**（4）** 查询奖金高于工资的20%的员工信息。

~~~sql
select ename,sal,comm from emp where comm > (sal*0.2);
~~~

**（5）** 查询10号部门中工种为MANAGER和20号部门中工种为CLERK的员工的信息。

~~~sql
select ename,job,deptno from emp where job ='MANAGER'and deptno = 10 or job='CLERK' and deptno=20;
~~~

**（6）** 查询所有工种不是MANAGER和CLERK，且工资大于或等于2000的员工的详细信息。

~~~sql
select * from emp where job !='MANAGER' and job !='CLERK' and sal >= 2000;
~~~

**（7）** 查询有奖金的员工的不同工种。

~~~sql
select distinct job from emp where comm is not null;
~~~

**（8）** 查询所有员工工资和奖金的和。

~~~sql
select sum(sal) from emp;
~~~

**（9）** 查询没有奖金或奖金低于100的员工信息。

~~~sql
select ename,comm from emp where comm is null or nvl(comm,0) < 100;
~~~

**（10）**  查询各月倒数第2天入职的员工信息。

~~~sql
Select*fromempwhere(last_day(hiredate)-2) = hiredate;
~~~

**（11）**  查询员工工龄大于或等于10年的员工信息。

~~~sql
select ename, hiredate from emp where (to_char(sysdate, 'yyyy') - to_char(hiredate, 'yyyy')) >= 10;
~~~

**（12）**  查询员工信息，要求以首字母大写的方式显示所有员工的姓名。

~~~sql
select initcap(ename) from emp;
~~~

**（13）**  查询员工名正好为6个字符的员工的信息。

~~~sql
select ename from emp where length(ename)=6;
~~~

**（14）**  查询员工名字中不包含字母“S”员工。

~~~sql
select ename from emp where ename not like '%S%';
~~~

**（15）**  查询员工姓名的第2个字母为“M”的员工信息。

~~~sql
select ename from emp where ename like '_M%';
~~~

**（16）**  查询所有员工姓名的前3个字符。

~~~sql
select substr(ename,1,3) from emp;
~~~

**（17）**  查询所有员工的姓名，如果包含字母“s”，则用“S”替换。

~~~sql
select replace(ename,' s ',' S ') from emp;
~~~

**（18）**  查询员工的姓名和入职日期，并按入职日期从先到后进行排列。

~~~sql
select ename,hiredate from emp order by hiredate asc;
~~~

**（19）**  显示所有的姓名、工种、工资和奖金，按工种降序排列，若工种相同则按工资升序排列。

~~~sql
select ename,job,sal,comm from emp order by job , sal desc;
~~~

**（20）**  显示所有员工的姓名、入职的年份和月份，若入职日期所在的月份排序，若月份相同则按入职的年份排序。

~~~sql
 select ename,
    extract(YEAR from hiredate) year1,
    extract(MONTH from hiredate) month1
 from emp
 order by month1 ,year1;
~~~

**（21）**  查询在2月份入职的所有员工信息。

~~~sql
select * from emp where extract(MONTH from hiredate) = 2;
~~~

**（22）**  查询所有员工入职以来的工作期限，用“**年**月**日”的形式表示。(<u>比较笨的方法</u>)

~~~sql
select replace(rq, '*', '日') 日期
 from (select replace(rq, ' ', '月') rq
     from (select replace(rq, '-', '年') rq
         from (select to_char(hiredate, 'yy-mm dd*') rq from emp)));
~~~

**（23）**  查询至少有一个员工的部门信息。

~~~sql
select * from dept t right join emp e on t.deptno=e.deptno;
~~~

**（24）**  查询工资比SMITH员工工资高的所有员工信息。

~~~sql
select * from emp where sal > (select sal from emp where ename = 'SMITH');
~~~

**（25）**  查询所有员工的姓名及其直接上级的姓名。

~~~sql
select e.ename,e.job,e1.mgr from emp e join emp e1 on e.empno=e1.mgr;
~~~

**（26）**  查询入职日期早于其直接上级领导的所有员工信息。

~~~sql
 select distinct(e.ename), e.mgr, e.hiredate
 from emp e
 join emp e1
  on e.empno = e1.mgr
  and e.hiredate > e1.hiredate;
~~~

**（27）**  查询所有部门及其员工信息，包括那些没有员工的部门。

~~~sql
select * from dept t left join emp e on t.deptno=e.deptno;
~~~

**（28）**  查询所有员工及其部门信息，包括那些还不属于任何部门的员工。

~~~sql
select * from dept t full outer join emp e on t.deptno=e.deptno;
~~~

**（29）**  查询所有工种为CLERK的员工的姓名及其部门名称。

~~~sql
 select e.ename, d.dname,e.job
 from emp e
 join dept d
  on e.deptno = d.deptno
  and e.job = 'CLERK';
~~~

**（30）**  查询最低工资大于2500的各种工作。

~~~sql
select distinct (e.job)
 from (select ename, job, sal from emp where sal > 2500) e;
~~~

**（31）**  查询最低工资低于2000的部门及其员工信息。

~~~sql
select * from emp e join dept d on e.deptno=d.deptno and e.sal < 2000;
~~~

**（32）**  查询在SALES部门工作的员工的姓名信息。

~~~sql
select e.ename from emp e join dept d on e.deptno=d.deptno and d.dname='SALES';
~~~

**（33）**  查询工资高于公司平均工资的所有员工信息。

~~~sql
select * from emp e where e.sal > (select avg(sal) from emp);
~~~

**（34）**  查询与SMITH员工从事相同工作的所有员工信息

~~~sql
select * from emp where job = (select job from emp where ename='SMITH');
~~~

**（35）**  列出工资等于30号部门中某个员工工资的所有员工的姓名和工资。

~~~~sql
select * from emp e join (select sal from emp where deptno=30) s on e.sal=s.sal;
~~~~

**（36）**  查询工资高于30号部门中工作的所有员工的工资的员工姓名和工资。

~~~sql
 select e.ename, e.sal
 from emp e
 join (select max(s.sal) vsal
     from (select sal from emp where deptno = 30) s) v
  on e.sal > v.vsal;
~~~

**（37）**  查询每个部门中的员工数量、平均工资和平均工作年限。

~~~sql
select count(e.ename) coun,
    avg(e.sal) sal,
    avg(to_char(sysdate, 'yyyy') - to_char(e.hiredate, 'yyyy')) avgyer
  from emp e
 group by e.deptno;
~~~

**（38）**  查询从事同一种工作但不属于同一部门的员工信息。

~~~sql
select *
 from emp e
 join (select job, deptno from emp) e1
  on e.job = e1.job
  and e.deptno != e1.deptno;
~~~

**（39）**  查询各个部门的详细信息以及部门人数、部门平均工资。

```sql
select *
 from dept de
 join (select d.deptno, count(e.ename), avg(sal)
     from emp e
     right join dept d
      on e.deptno = d.deptno
     group by d.deptno) d
  on de.deptno = d.deptno;
```

**（40）**  查询各种工作的最低工资。

```sql
select job,min(sal) from emp group by job;
```

**（41）**  查询各个部门中的不同工种的最高工资。

```sql
select d.deptno, e.job, max(e.sal)
 from dept d
  join emp e
  on d.deptno = e.deptno
 group by d.deptno, e.job;
```

**（42）**  查询10号部门员工以及领导的信息。

```sql
 select * from emp e ,(select * from emp where deptno=10) e1 where e.empno=e1.mgr or e.empno=e1.empno;
```

**（43）**  查询各个部门的人数及平均工资。

```sql
select count(ename),avg(sal) from emp group by deptno;
```

**（44）**  查询工资为某个部门平均工资的员工信息。

```sql
select * from emp e join (select avg(sal) vsal from emp group by deptno) e1 on e.sal =e1.vsal;
```

**（45）**  查询工资高于本部门平均工资的员工的信息。

```sql
select e.ename, e.sal, e.deptno
 from emp e
 join (select deptno, avg(sal) vsal from emp group by deptno) d
  on e.deptno = d.deptno
  and e.sal > d.vsal;
```

**（46）**  查询工资高于本部门平均工资的员工的信息及其部门的平均工资。

```sql
select e.ename, e.sal, e.deptno,d.vsal
 from emp e
 join (select deptno, avg(sal) vsal from emp group by deptno) d
  on e.deptno = d.deptno
  and e.sal > d.vsal;
```

**（47）**  查询工资高于20号部门某个员工工资的员工的信息。

```sql
select * from emp e,(select max(sal) vsal from emp where deptno=20) d where e.sal >d.vsal;
```

**（48）**  统计各个工种的人数与平均工资。

```sql
select job,count(ename),avg(sal) from emp group by job;
```

**（49）**  统计每个部门中各个工种的人数与平均工资。

```sql
select d.deptno, e.job,count(empno), avg(e.sal)
 from dept d
  join emp e
  on d.deptno = e.deptno
 group by d.deptno, e.job;
```

**（50）**  查询工资、奖金与10 号部门某个员工工资、奖金都相同的员工的信息。

```sql
 select e.ename, e.sal, nvl(e.comm, 0), deptno comm
 from emp e,
    (select e.ename, e.sal, nvl(e.comm, 0) cm
     from emp e
     where deptno = 10) e1
 where e.sal = e1.sal
  and e.comm = e1.cm
```

**（51）**  查询部门人数大于5的部门的员工的信息。

```sql
select * from dept d ,(select deptno,count(job) co from emp group by deptno) e where d.deptno=e.deptno and e.co > 5;
```

**（52）**  查询所有员工工资都大于1000的部门的信息。

```sql
select *
  from dept d,
    (select ename, sal, deptno from emp where sal >1000) e
 where d.deptno = e.deptno;
```

**（53）**  查询所有员工工资都大于1000的部门的信息及其员工信息。

```sql
 select distinct d.deptno, d.dname, d.loc, e.*
 from dept d, (select * from emp e where sal > 1000) e
 where d.deptno = e.deptno;
```

**（54）**  查询所有员工工资都在900~3000之间的部门的信息。

```sql
select *
  from dept d,
    (select ename, sal, deptno from emp where sal between 900 and 3000) e
 where d.deptno = e.deptno;
```

**（55）**  查询所有工资都在900~3000之间的员工所在部门的员工信息。

~~~sql
select e.*
  from emp e,
    (select distinct d.deptno
      from dept d,
        (select ename, sal, deptno
          from emp
        where sal between 900 and 3000) e
     where d.deptno = e.deptno) d
 where e.deptno = d.deptno;
~~~

**（56）**  查询每个员工的领导所在部门的信息。

~~~sql
select *
 from dept d,
    (select distinct e1.mgr, e1.deptno
     from emp e, (select mgr, deptno from emp) e1
     where e.empno = e1.mgr) e
 where d.deptno = e.deptno;
~~~

**（57）**  查询人数最多的部门信息。

```sql
select *
 from dept d
 join (select d.deptno
     from (select deptno, count(ename) cn from emp group by deptno) d
     join (select max(cn) c
         from (select deptno, count(ename) cn
             from emp
            group by deptno)) d1
     on d.cn = d1.c) d2
  on d.deptno = d2.deptno;
```

**（58）**  查询30号部门中工资排序前3名的员工信息

~~~sql
select e.ename, e.job, e.sal, e.comm,e.rn
 from (select e.*,rownum rn from(select e.* from emp e where deptno=30 order by sal) e) e where e.rn <= 3;
~~~

**（59）**  查询所有员工中工资排在5~10名之间的员工信息。

~~~sql
select e.ename, e.job, e.sal, e.comm,e.rn

 from (select e.*,rownum rn from(select e.* from emp e order by sal) e) e

 where e.rn > 5 and e.rn <=10

 order by sal;
~~~

**（60）**  向emp表中插入一条记录，员工号为1357，员工名字为oracle，工资为2050元，部门号为20，入职日期为2002年5月10日。

~~~sql
insert into emp (empno,ename,hiredate,sal,deptno) values(1357,'oracle',to_date('2002/5/10','yyyy/mm/dd'),2050,20);
~~~

**（61）**  向emp表中插入一条记录，员工名字为FAN，员工号为8000，其他信息与SMITH员工的信息相同。

~~~sql
 insert into emp (empno,ename,job,mgr,hiredate,sal,deptno) values(8000,'FAN','CLERK',7920,to_date('1980/12/17','yyyy/mm/dd'),800,20);
~~~

**（62）**  将各部门员工的工资修改为该员工所在部门平均工资加1000。

~~~sql
 update emp e
  set e.sal = (case
         when e.deptno =10 then
         e.sal + (select avg(sal) + 1000 vsal
               from emp
              where deptno = 10
              group by deptno)
         when e.deptno= 20 then
         e.sal + (select avg(sal) + 1000 vsal
               from emp
              where deptno = 20
              group by deptno)
         when e.deptno =30 then
         e.sal + (select avg(sal) + 1000 vsal
               from emp
              where deptno = 30
              group by deptno)
        end
);
~~~





