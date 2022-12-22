# join
# 관계형 데이터베이스에서는 데이터의 중복을 최소화하고, 이상현상을 방지하기 위해 
# 연관된 데이터들을 분리하여 저장하도록 설계한다. 
# 필요할 때 테이블간 join을 통해 원하는 형태의 데이터를 조회한다.

# 모든 직원의 직원번호, 이름, 부서코드, 부서명을 조회
select 
emp_id, emp_name, dept_code
, (select dept_title from department where dept_id = e.dept_code) as 부서명
from employee e;

select
*
from employee e
join department d on(e.dept_code = d.dept_id);

# join
# cross join, inner join, outer join(left join, right join, full outer join)
# cross join
# 	cross join : 조인 조건절의 결과가 무조건 참인 join
# 30만개의 상품데이터와 300만개의 주문데이터를 cross join하면... 9천억개 => DB 사망, 서비스 멈춤... 재앙
select *
from employee cross join department
order by emp_id;

# 2. inner join(equals join, 등가 조인)
# 사번, 이름, 직급코드, 직급명을 출력하시오
select emp_id, emp_name, e.job_code, job_name
from employee e
join job j on(e.job_code = j.job_code);

select *
from employee 
join job using(job_code);

# 여러 테이블 join하기
# 모든 사원들의 사번, 이름, 부서명, 근무지이름을 출력하시오
select emp_id, emp_name, dept_title, local_name
from employee
join department on(DEPT_CODE = DEPT_ID)
join location on(location_id = local_code);
 
# ASIA 지역에서 근무하는 급여 500만원 미만의 직원들을 조회.
# ASIA 지역 : ASIA1, ASIA2, ASIA3 
select emp_name, local_name, salary
from employee
join department on(dept_code = dept_id)
join location on(location_id = LOCAL_CODE)
where SALARY < 5000000
and local_name like 'ASIA%';

# outer join
# 특정 테이블을 기준으로 join을 수행
# 특정 테이블을 기준으로 join 조건절이 false를 반환하더라도 특정 테이블의 컬럼은 result set에 포함시킨다.
# left join, right join, full outer join

# 부서별 사원수를 조회해보자.
select DEPT_ID, dept_title, count(emp_id)
from department left join employee on(DEPT_CODE = DEPT_ID)
group by DEPT_ID, DEPT_TITLE
order by DEPT_ID;

select DEPT_ID, dept_title, count(emp_id)
from department right join employee on(DEPT_CODE = DEPT_ID)
group by DEPT_ID, DEPT_TITLE
order by DEPT_ID;

# full outer join : left join + right join
# union : 합집합
# 두 result set의 합집합을 반환
select DEPT_ID, dept_title, count(emp_id)
from department left join employee on(DEPT_CODE = DEPT_ID)
group by DEPT_ID, DEPT_TITLE
union
select DEPT_ID, dept_title, count(emp_id)
from department right join employee on(DEPT_CODE = DEPT_ID)
group by DEPT_ID, DEPT_TITLE;

# SELF JOIN
# 자기 자신과 JOIN
# EMPLOYEE 테이블에서 이름, 부서코드, 관리자 사번, 관리자 이름을 출력하세요
SELECT E.EMP_NAME, DEPT_CODE, MANAGER_ID 
, (SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID)
FROM EMPLOYEE E;

SELECT E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, E2.EMP_NAME
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE E2 ON(E2.EMP_ID = E.MANAGER_ID)
ORDER BY E2.EMP_NAME DESC;






