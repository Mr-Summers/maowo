/*
     �ַ�����
*/
--�ַ�ƴ��
select concat('studen','person') from dual;
--����ĸ���д
select initcap('sssdd') from dual;
--����Сд�ַ�
select lower('SERING') from dual;
--�ַ������7�����û��7λ����a����
select ename,lpad(ename,'7','a') from emp;
--���ֶ�������A���a
select ename,replace(ename,'A','a') from emp;
--���ĩβ���ַ�
select rtrim('gao qiao jing','g') test from dual;
--���ǰ����ַ�
select trim(both 's' from 'xxxxssssdd') from dual;
--��ȡ�������ֶ�
select substr('ashgodn',1,3) from dual;
--Сдת��д
select upper('hello word') from dual;
--��ȡ�ַ����Ķ����ֵ�λ��
select instr('hello word','w') from dual; 
--����ַ��ĳ���
select length('hello word') from dual;

/*
              ��ֵ����       
*/
--��������,����Ĳ�����ʾ������λ
select round(11.5) from dual;
select round(11.4) from dual;
select round(22.265,2) from dual;
--ȥ��ĩβ�����������ʾ������λ
select trunc(22.265) from dual;
select trunc(22.265,2) from dual;
--ȡ����
select mod(15,4) from dual;
--����ȡ��
select ceil(15.2) from dual;
--����ȡ��
select floor(15.6) from dual;

/*
              ʱ�亯��     
*/
--��ѯ��ǰʱ��,���ַ�ʽ
select sysdate from dual;
select current_date from dual;
--��üӼ����ģ�����
select add_months(sysdate,2) from dual;
--���ر��µ����һ��
select last_day(sysdate) from dual;
--
select * from emp;
--������������֮�������
select ename,hiredate, months_between(sysdate,sysdate-50) from emp;

/*
       ת������
*/
--����ת��
select to_char(sysdate,'yy-mm-dd hh24:mi:ss') ��ǰʱ�� from dual;
select ename,hiredate,to_char(hiredate,'yyyy-mm-dd') ת��ĸ�ʽ from emp;
--��ֵת��
select ename,sal,to_char(sal,'$999,999.999') salary from emp ;
select to_char(2250,'$000,000.000') from dual;
select to_char(1555,'99,99.00') from dual;
--�ַ�ת����
select to_date('19,05,25,22,12,25','yy-mm-dd hh24:mi:ss') from dual;
select to_date('2019-05-25','yyyy-mm-dd') from dual;
--�ַ�ת��ֵ
select to_number('$1224.56','$9000.000') from dual;
select to_number('11.25','99.999') from dual;

/*
       Ƕ�׺���
*/
select ename,nvl(to_char(comm),'0') from emp where comm in null;
--��ʾԱ����Ӷ����6���µĺ���һ�����ڶ��ĵ�����
select to_char(next_day(add_months(hiredate,6),'���ڶ�'),'fmday,month,yyyy') review from emp order by hiredate;
--�����Ÿ�Ա���ǹ���
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
--��ѯԱ����82���
select hiredate from emp where to_char(hiredate,'yy') = '82' ;
--��ѯ����39���
select hiredate from emp where to_char(sysdate ,'yyyy') - to_char(hiredate,'yyyy') =39;
--��ʾԱ��6���º����һ��������
select ename,
       to_char(next_day(add_months(hiredate, 6), '������'),
               'fmday,month,yyyy') review
  from emp
 order by hiredate;
 --
 select * from emp
 --��ѯ��û���ϼ��쵼���ˣ������ó�boss
 select ename,nvl(to_char(mgr),'boss') from emp where mgr is null;
 

/*
        �麯��
*/
select avg(sal) from emp; --ƽ����
select min(sal) from emp;--��Сֵ
select max(sal) from emp;--���ֵ
select sum(sal) from emp;--���
select count(sal) from emp;--��������
--����Ա��ƽ�����ʴ���2000
select avg(sal),deptno from emp group by deptno having avg(sal) > 2000 order by deptno;
select deptno ,avg(sal) from emp where sal >1200 group by deptno having avg(sal) >1500 order by deptno;
--��ѯ����Ա������Ա��������Ա��
select e1.ename, e1.hiredate, e1.sal
  from emp e1,
       (select max(hiredate) mind, min(hiredate) maxd
          from emp e
         where e.deptno = 10) e2
 where e1.hiredate = e2.mind
    or e1.hiredate = e2.maxd;

--���ַ�λ�ã��ӳ��ȣ��滻�ַ�
select instr('software','f'),rpad('software',15,'*'),replace('software','a','j') from dual;
 -- �н������ʾ�У��޾���ʾ��
select  nvl2(comm, 'wu', 'you')from emp 
--��õ�ǰ���ڣ�����Ϊdate���ڼ�6�£���������գ��Լ�������������
select sysdate as "Date" , add_months(sysdate , 6),next_day(add_months(sysdate , 6),'������')��last_day(add_months(sysdate,6)) from dual;

select * from emp where deptno =30
--��ѯ�ϰ幤�Ű�������
select ename,nvl(mgr,9999) from emp order by mgr desc;
--�����ž�ƽ�ֹ���
select avg(sal),deptno from emp group by deptno;
--������������ʴ���1300 ��ƽ�����ʣ���СӶ�����Ӷ�𣬲���Ӷ�����100
select deptno, avg(sal),min(comm),max(comm) from emp where  sal >1300 and comm >100 group by deptno;
--�ҳ�ÿ�����ŵ�ƽ���������С����
select avg(sal),min(sal),max(sal) from emp group by deptno;

select * from salgrade;
--��ѯÿ��Ա���� ���ʵȼ�
select e.ename,e.deptno,e.sal,s.grade from emp e,salgrade s where sal between s.losal and hisal; 
