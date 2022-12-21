# where 절

# and, or
# 1. employee 테이블에서 부서 코드가 'D6'이고 급여를 200만원 이상 받는 지원의 이름, 부서코드, 급여 조회
select emp_name, dept_code, salary
from employee
where dept_code ="D6" and salary >= 2000000;

# 2.employee 테이블에서 부서코드가 D9이거나 D5인 사원중
# 급여를 400만원 이상 받는 모든 사원을 조회하시오.
select *
from employee
where 1=1
and (dept_code ="D5" or dept_code ="D9") 
and salary >= 4000000;

# 3. employee 테이블에서 월급이 350만원 이상, 600만원 이하에 속하는 사원들의 모든 정보를 조회
select emp_name, salary
from employee
where salary >= 3500000 and salary <= 6000000;

# BETWWEN A AND B : a 와 b 사이
SELECT EMP_NAME, SALARY 
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

# 3-1 EMPLOYEE 테이블에서 월급이 350만우너 이상, 600만원 이하에 속하지 않는 사우너들의 모든 정보를 조회
select emp_name, salary
from employee
where NOT (salary >= 3500000 and salary <= 6000000);

SELECT EMP_NAME, SALARY 
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;


## 날짜 데이터로 조건식 만들어보기
# 날짜 데이터 : 비교연산이 가능, +, -
# employee 테이블에서 고용일이 90-01-01 ~ 01-01-01 사이에 속하는 
# 사원들을 조회하시오
select emp_name, hire_date
from employee
where hire_date >= '90--09-09' and hire_date <= '01-01-01';

select emp_name, hire_date
from employee
where not(hire_date >= '90--09-09' and hire_date <= '01-01-01');

select emp_name, hire_date
from employee
where hire_date not between '90-01-01' and '01-01-01';

# *** like *** #
# 컬럼값에 like절에서 지정한 패턴을 만족하는 문자열이 있다면 true
# 컬럼명 like '패턴'
# 패턴문자 : %, _
# % : 'A%' : A로 시작하는
#     '%A' : A로 끝나는
#     '%A%': A를 포함하는

# employee 테이블에서 성이 이씨이고 입사일이 12-01-01 이후인 사우너으 ㅣ사번, 이름, 고용일 조회
select emp_id , emp_name, hire_date
from employee
where 1=1
and emp_name like '이%'
and hire_date > '12-01-01';

# employee 테이블에서 성이 이가 포함되고  부서코드가 'D5'인 사원의 사번, 이름, 고용일 조회
select emp_id, emp_name, hire_date
from employee
where 1=1
and emp_name like '%이%'
and DEPT_CODE = 'D5';

# employee 테이블에서 이름이 연으로 끝나고퇴하사지 않은 사원을 조회
select *
from employee
where 1=1
and emp_name like '%연'
and ent_yn = 'N';

# like 절의 와일드카드, _
# like 절에서 문자 자리수를 지정:
#  _ -> 한자리
#  __ -> 두자리

# employee 테이블에서 전화번호 뒤에서 4번째 자리가 9인 사원의 이름, 전화번호 조회
select emp_name, phone
from employee
where 1=1
and phone like '%9___';

# 사원 중 '_' 의 앞 글자가 3자리인 이메일 주소를 가진 사원의 정보를 조회
# escape문자를 만들어서 사용
select emp_name, email
from employee
where 1=1
and email like '___$_%' escape'$';

# 사원중 010으로 시작하지 않는 전화번호를 가진 사람을 조회하시오
select emp_name, phone
from employee
where 1=1
and not phone like '010%';

# 직급코드가 'J7' 또는 'J2'인 직원 중 급여가 200만원 이상인 직원의 이름, 급여, 직급코드를 조회(sal_lebel)
select emp_name, salary, job_code
from employee
where 1=1
and (job_code = 'J7' or job_code = 'J2') and salary * 12 >= 2000000;

# In 
# 컬럼값이 목록에 있으면 true
select emp_name, salary, job_code
from employee
where 1=1
and job_code in('J7','J2')
and salary * 12 >= 2000000;

# IN
#  직급코드가 'J7' 또는 'J2'인 직원 중 급여가 200만원 이상인 직원의 이름, 급여, 직급코드를 조회
select emp_name, salary, job_code
from employee
where (job_code = 'J7' or job_code = 'J2') 
and SALARY >= 200;

# IN
# 컬럼값이 목록에 있으면 true
select emp_name, salary, job_code
from employee
where job_code in('J7', 'J2')
and SALARY >= 200;

# is null
# 컬럼값이 null인지 확인

# employee 테이블에서 보너스가 null인 사원을 조회
select emp_name, bonus
from employee
where BONUS is null;

# null은 알 수 없는 값(undefined)
# null과 숫자간 산술연산의 결과는 null로 처리
# 	* dual 함수나 식을 테스트 할때 사용하는 가상테이블
select 10 + null from dual;

# null로 비교연산도 null로 처리
select 100 > null from dual;

# null 논리연산은?
# true or null -> true
select true or null from dual;
# false or null -> null
select false or null from dual;

# true and null -> null
select true and null from dual;
# false and null -> false
select false and null from dual;






