# subquery
# sql query 안에 포함된 또다른 select문

# 서브쿼리의 분류
# 1. 사용 위치에 따른 분류
# 	select절			: 스칼라(단일값) 서브쿼리
#	from절			: inline view
#   where, having	: subquery

# 2. 서브쿼리의 결과에 따른 분류
# 단일행, 단일열, 다중행, 다중열

# 부서코드가 노옹철사원과 같은 직원명단을 조회하시오
# 쿼리를 여러개 작성해도 괜찮으니, 위 직원명단을 조회해봅시다.

select dept_code from employee where emp_name = '노옹철';

select emp_name 
from employee 
where dept_code = 'D9';

# 단일행, 단일열 서브쿼리
# 비교연산자 사용.
# select절에서 서브쿼리는 단일행, 단일열 서브쿼리만 사용 가능

select emp_name 
from employee 
where dept_code = (select dept_code from employee where emp_name = '노옹철');

select emp_name, (select dept_code from employee where emp_name = '노옹철')
from employee;

#다중행 서브쿼리
#서브쿼리의 조회결과 행이 여러 개인 서브쿼리
# IN, ANY, ALL, EXISTS 연산자와 조합하여 사용

# IN
# 최대급여가 4999999보다 적은 급여등급을 가지고 있는 직원을 조회
SELECT SAL_LEVEL FROM sal_grade WHERE MAX_SAL < 4999999;

SELECT EMP_NAME, SAL_LEVEL
FROM EMPLOYEE
WHERE SAL_LEVEL IN(SELECT SAL_LEVEL FROM sal_grade WHERE MAX_SAL < 4999999);

# ANY
# 서브쿼리의 결과값과 컬럼값간의 비교연산 결과가 하나라도 TRUE가 된다면 TRUE
# 박나라가 속한 부서 사람들의 급여레벨에 속하는 사원들의 정보를 출력해보자
#  WHERE 1 > ANY(0.1, 100, 200 ,300) == TRUE
SELECT DISTINCT sal_LEVEL 
FROM EMPLOYEE 
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '박나라');

SELECT EMP_NAME, SAL_LEVEL
FROM EMPLOYEE 
WHERE SAL_LEVEL = ANY(SELECT DISTINCT sal_LEVEL 
					  FROM EMPLOYEE 
					  WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '박나라'));

# 박나라가 속한 부서의 사람들 중 가장 적은 연봉을 받는 사람보다 많은 연봉을 받는 사람을 구해보자.
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > ANY(SELECT SALARY 
				   FROM EMPLOYEE 
				   WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '박나라'));


# ALL
# 서브쿼리의 결과값들과 컬럼값을 비교연산 했을 때 모두 TRUE 이야지만 TRUE
# WHERE 1 > ALL(100, 200, 300, 400, 0.9) == FALSE
# 박나라가 속한 부서의 사람들 중 가장 많은 연봉을 받는 사람보다 많은 연봉을 받는 사람을 구해보자.
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > ALL(SELECT SALARY 
				   FROM EMPLOYEE 
				   WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '박나라'));

#EXISTS : SUBQUERY의 결과가 있으면 TRUE 없으면 FALSE
#매니저인 사원을 조회하시오
SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE E
WHERE EXISTS (SELECT EMP_ID FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);

# 상관쿼리(상호연관쿼리)
# 메인쿼리에서 사용한 컬럼값을 서브쿼리에서도 사용하는 쿼리
# 메인쿼리의 컬럼값이 변경이되면 서브쿼리의 결과값도 바뀐다.
# 상관쿼리를 사용하기 위해서는 참조를 위한 레퍼런스가 필요하다. 메인쿼리의 FROM절에 별칭을 지정한다.
SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE E
WHERE EXISTS (SELECT EMP_ID FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);

# IN을 사용해서 위와 같은 결과를 반환하는 쿼리를 작성
SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE E
WHERE emp_id in (SELECT manager_id from employee);

#퇴사한 직원이 존재하는 부서의 사원 중에서
#퇴사한 사원과 같은 직급인 사원의 이름, 직급, 부서를 조회
select emp_name, job_code, dept_code
from employee
where dept_code in(select dept_code from employee where ent_yn = 'Y')
and job_code in(select job_code from employee where ent_yn = 'Y');

# 다중열 서브쿼리
# 서브쿼리의 열이 여러 개인 경우
select emp_name, job_code, dept_code
from employee
where (dept_code, job_code) in(select dept_code, job_code from employee where ent_yn = 'Y');


# 인라인뷰
# from절에서 사용하는 서브쿼리
# mysql에서는 인라인뷰에 반드시 별칭을 붙여야 한다.
select * 
from (select emp_id, emp_name, dept_code, job_code
	  from employee where job_code = 'J6') a;









