# order by 
# select문에서 result set을 정렬하기 위해 사용하는 구문
# select문의 가장 마지막에 작성되고, 실행 순서도 가장 마지막
# select문 해석순서 : from -> where -> group by -> having -> select -> order by

# order by 작성
# asc(오름차순), desc(내림차순)
# 만약 컬럼에 null이 있다면 오름차순으로 적용

# 사원들의 이름, 급여, 보너스, 연봉레벨, 부서코드를 조회하되 bonus 로 오름차순 정렬하시오
select emp_name, salary, bonus, SAL_LEVEL, DEPT_CODE
from employee
#order by BONUS asc;
#내림차순으로 정렬
#order by bonus desc;
# result set의 두번째 컬럼을 기준으로 내림차순 정렬
#order by 2 desc;
# 연봉레벨로 오름차순 정렬, 연봉레벨이 같다면 연봉으로 내림차순 정렬
#order by SAL_LEVEL asc, SALARY desc;
# 보너스로 오름차순 정렬, null은 뒤에 정렬
order by bonus is null asc, bonus asc;


# TOP N 구문
# 쿼리의 결과중 상위 N개의 결과만 받아보는 구문
# limit
# limit start idx, 출력할 개수
# limit 5 == limit 0, 5

# employee 테이블에서 급여 순위 1~5등을 뽑아보자
select 
emp_name, salary 
from employee
order by salary desc
limit 0,5;

# employee 테이블에서 급여순위 6~10등을 뽑아보자
select 
emp_name, salary 
from employee
order by salary desc
limit 5,5;

# employee 테이블에서 가장 최근에 입사한 사원 5명을 뽑아보자.
select 
emp_name, salary, hire_date 
from employee
order by hire_date desc
limit 0,5;








