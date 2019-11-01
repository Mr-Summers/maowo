--作业
--查询部分编号为10的的员工
select * from emp e where e.deptno=10;
--查询年薪大于30000的员工
select e.ename , e.deptno from emp e where (e.sal*12) > 30000; 
--查询佣金为null的员工
select * from emp e where e.comm is null;
--查询工资大于1500 且 佣金不为空
select * from emp e where e.sal > 1500 and comm is not null;
--查询工资大于1500 或 有佣金的人员
select e.ename , e.sal , e.comm from emp e where e.sal > 1500 or comm is not null;
--查询姓名中带有 S的 人员
select e.ename , e.sal from emp e where e.ename like('%S%');
--查询姓名已J开头第二个字符是O的人员
select e.ename , e.sal from emp e where e.ename like('JO_%');
--查询带有%的员工信息
SELECT E.ENAME FROM EMP E WHERE E.ENAME LIKE('%\%%');
--查询部门名称为 sales 和 research 的信息
select * from dept t , emp e where  t.deptno = e.deptno AND T.DNAME IN('SALES','RESEARCH');
--exists用法
select t.dname , t.deptno ,  e.sal  from dept t , emp e where exists( select  t.dname , t.deptno ,  e.sal from emp e , dept t  where t.dname in('SALES','RESEARCH')) 

--基本查询
--查询所有部门名称
select t.dname from dept t 
--查询年薪 并指定列名为 年薪
select (e.sal+nvl(comm , 0))*12 年薪 from emp e 
--查询显示不存在雇员的所有部门好号
select * from emp e , dept t where t

--限定查询
--工资超过2850的员工
select e.ename , e.sal from emp e where e.sal > 2850;
--查询工资不在1500和2850之间的
select e.ename , e.sal from emp e where e.sal not in(1500,2850);
--查询编号为7566的名字和部门
select e.ename , e.deptno from emp e   where e.empno =7566
--显示部分10或者30中工资大于1500的人员 
select e.ename , e.sal , e.deptno from emp e where e.deptno in(10,30) and e.sal >1500
--名字中第二个是A 的
select e.ename , e.sal from emp e where e.ename like('_A_%')
--查询补助不为null的员工
select e.ename , e.comm from emp e where e.comm is not null;


--排序
--名字按升序排
select e.ename ,  e.sal , e.hiredate from emp e order by ename asc
--按日期规定的日期排序
select e.ename , e.job , e.hiredate from emp e where hiredate > to_date('1981-2-1','yyyy/mm/dd')  and hiredate < to_date('1981-5-1','yyyy/mm/dd') order by hiredate asc；
--获得佣金的员工 按降序排列
select e.ename , e.sal , e.comm from emp e where e.comm is not null order by e.sal desc
