--��ҵ
--��ѯ���ֱ��Ϊ10�ĵ�Ա��
select * from emp e where e.deptno=10;
--��ѯ��н����30000��Ա��
select e.ename , e.deptno from emp e where (e.sal*12) > 30000; 
--��ѯӶ��Ϊnull��Ա��
select * from emp e where e.comm is null;
--��ѯ���ʴ���1500 �� Ӷ��Ϊ��
select * from emp e where e.sal > 1500 and comm is not null;
--��ѯ���ʴ���1500 �� ��Ӷ�����Ա
select e.ename , e.sal , e.comm from emp e where e.sal > 1500 or comm is not null;
--��ѯ�����д��� S�� ��Ա
select e.ename , e.sal from emp e where e.ename like('%S%');
--��ѯ������J��ͷ�ڶ����ַ���O����Ա
select e.ename , e.sal from emp e where e.ename like('JO_%');
--��ѯ����%��Ա����Ϣ
SELECT E.ENAME FROM EMP E WHERE E.ENAME LIKE('%\%%');
--��ѯ��������Ϊ sales �� research ����Ϣ
select * from dept t , emp e where  t.deptno = e.deptno AND T.DNAME IN('SALES','RESEARCH');
--exists�÷�
select t.dname , t.deptno ,  e.sal  from dept t , emp e where exists( select  t.dname , t.deptno ,  e.sal from emp e , dept t  where t.dname in('SALES','RESEARCH')) 

--������ѯ
--��ѯ���в�������
select t.dname from dept t 
--��ѯ��н ��ָ������Ϊ ��н
select (e.sal+nvl(comm , 0))*12 ��н from emp e 
--��ѯ��ʾ�����ڹ�Ա�����в��źú�
select * from emp e , dept t where t

--�޶���ѯ
--���ʳ���2850��Ա��
select e.ename , e.sal from emp e where e.sal > 2850;
--��ѯ���ʲ���1500��2850֮���
select e.ename , e.sal from emp e where e.sal not in(1500,2850);
--��ѯ���Ϊ7566�����ֺͲ���
select e.ename , e.deptno from emp e   where e.empno =7566
--��ʾ����10����30�й��ʴ���1500����Ա 
select e.ename , e.sal , e.deptno from emp e where e.deptno in(10,30) and e.sal >1500
--�����еڶ�����A ��
select e.ename , e.sal from emp e where e.ename like('_A_%')
--��ѯ������Ϊnull��Ա��
select e.ename , e.comm from emp e where e.comm is not null;


--����
--���ְ�������
select e.ename ,  e.sal , e.hiredate from emp e order by ename asc
--�����ڹ涨����������
select e.ename , e.job , e.hiredate from emp e where hiredate > to_date('1981-2-1','yyyy/mm/dd')  and hiredate < to_date('1981-5-1','yyyy/mm/dd') order by hiredate asc��
--���Ӷ���Ա�� ����������
select e.ename , e.sal , e.comm from emp e where e.comm is not null order by e.sal desc
