# DDL : CREATE(생성), DROP(삭제), ALTER(수정)
# DDL은 AUTO COMMIT

# 테이블 생성 구문
# CREATE TABLE 테이블명 (
#	컬럼명 TYPE(크기) 제약조건
#	,...
#   제약조건
#)

# 데이터무결성
# 데이터의 정확성, 일관성, 유효성을 지키는 것
# 데이터 무결성 보장을 위해 DBMS은 무결성 제약조건을 제공해준다.

CREATE TABLE OUR_DEPT(
	DEPT_CODE CHAR(3) primary key
    ,DEPT_TITLE VARCHAR(30)
);

INSERT INTO OUR_DEPT VALUES('D01', '개발팀');
INSERT INTO OUR_DEPT(DEPT_CODE, DEPT_TITLE) VALUES('D02', '인사팀');
INSERT INTO OUR_DEPT VALUES('D03', '총무팀');
COMMIT;
SELECT * FROM OUR_DEPT;

CREATE TABLE OUR_EMP(
	# PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, DEFAULT, NOT NULL
	# PRIMARY KEY(기본키)
    # 테이블을 대표하며, 테이블의 각 행을 식별하기 위해 사용하는 컬럼에 지정
    # 컬럼에 중복값을 허용하지 않는다. 유일성 
    # 기본키는 유일성과 최소성이 반드시 만족되는 컬럼에 지정해야한다.
	# 컬럼에 NULL을 허용하지 않는다. 
    # 모든 테이블에 기본키를 만들어주는 것이 좋다.
    # 기본키를 지정하면, 내부적으로 고유 인덱스가 생성되 DB가 테이블의 데이터를 검색할 때 빠르게 수행할 수 있다.
    
    # 식별자로 사용할 수 있는 컬럼, 또는 컬럼집합 슈퍼키라고 부른다.
    # 식별자로 사용할 수 있고 최소한의 컬럼집합을 후보키라고 부른다.
    # 후보키 중에서 가장 대표성을 지니는 컬럼을 기본키로 지정.
    
    # EMP_ID를 기본키로 지정.
    # auto_increment : INSERT문에서 컬럼을 지정하지 않으면 순차적으로 1씩 증가하는 숫자값을 EMP_ID에 DEFAULT로 넣어준다.
    # EMP_ID INT auto_increment primary KEY
    EMP_ID INT primary KEY
    
    # NOT NULL : 컬럼에 NULL값을 허용하지 않음
    ,EMP_NAME VARCHAR(30) NOT NULL
    
    # CHECK : 도메인 무결성을 보장 : 도메인에 속한 값만 컬럼 추가 가능
    ,AGE INT CHECK(AGE > 0)
    
	# UNIQUE : 중복값을 허용하지 않음
    ,EMP_NO CHAR(14) UNIQUE
    
    # DEFAULT : INSERT때 컬럼을 명시하지 않으면, DEFAULT값을 세팅
    ,HIRE_DATE timestamp default NOW()
    
	# 참조무결성
    # 1. 자신이 참조하고 있는 테이블에 존재하지 않는 값은 지정할 수 없다.
    # 2. 자신을 참조하고 있는 테이블이 있다면, 참조되고 있는 행은 삭제 할 수 없다.
    
    # 참조하고 있는 테이블 : 자식테이블
    # 참조되고 있는 테이블 : 부모테이블
    , DEPT_CODE CHAR(3)
    
    # DEPT_CODE를 외래키 (부모테이블을 참조하는 키)로 사용
    # 부모테이블에서 유일성과 최소성을 만족하는 컬럼을 외래키로 사용해야한다.
    , foreign key(DEPT_CODE) references OUR_DEPT(DEPT_CODE)    
);

# DEFAULT 확인 : HIRE_DATE에 현재시간이 들어간 것을 확인

INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, dept_code)
VALUES(1, '하명도', 19, '000000-0000000', 'D01');
COMMIT;

# 외래키 제약조건 확인
# DELTE FROM OUR_DEPT WHERE DPET_CODE = 'D01';  => 삭제 불가. , 자식 테이블이 D01로 식별되는 행을 참조하고 있음
# DELTE FROM OUR_DEPT WHERE DPET_CODE = 'D02';  => 삭제 가능.
# UPDATE OUR_DEPT SET DEPT_CODE = 'D10' WHERE DEPT_CODE = 'D01'; => 자식테이블에서 외래키로 사용하고 있는 컬럼은 수정이 불가능
ROLLBACK;

# 외래키 제약조건 확인 2
# 부모테이블의 컬럼에 존재하지 않는 값을 자식테이블의 외래키 컬럼에 넣을 수 없음
-- INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
-- VALUES(1, '하명도', 19, '000000-0000000', 'D04');

# NULL 제약조건 : NOT NULL이 지정된 EMP_NAME을 빼고 INSERT
# 실패
-- INSERT INTO OUR_EMP(EMP_ID, AGE, EMP_NO, DEPT_CODE)
-- VALUES(2, 19, '000000-0000001', 'D01');

# 성공
INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
VALUES(2, '신비', 19, '000000-0000001', 'D01');
COMMIT;

# CHECK 제약조건
# AGE에 -100을 넣어보자.
# 실패
-- INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
-- VALUES(3, '배재현', -100, '000000-0000002', 'D01');

# 성공
INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
VALUES(3, '배재현', 10, '000000-0000002', 'D01');
COMMIT;

# UNIQUE 제약조건
-- INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
-- VALUES(4, '이준형', 10, '000000-0000002', 'D01');

INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
VALUES(4, '이준형', 10, '000000-0000003', 'D01');

# 기본키 : primary key : unique + not null
# not null 어겨보기
-- INSERT INTO OUR_EMP( EMP_NAME, AGE, EMP_NO, DEPT_CODE)
-- VALUES('여태양', 15, '000000-0000004', 'D01');

# 유일성 어겨보기
-- INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
-- VALUES(4, '여태양', 15, '000000-0000004', 'D01');

INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
VALUES(5, '여태양', 15, '000000-0000004', 'D01');
COMMIT;


INSERT INTO OUR_EMP(EMP_ID, EMP_NAME, AGE, EMP_NO, DEPT_CODE)
VALUES(6, '여태양', 15, '000000-0000005', 'D01');
COMMIT;

# 테이블 복제
CREATE TABLE CP_EMPLOYEE
AS SELECT * FROM EMPLOYEE WHERE ENT_YN = 'Y';

# 테이블 구조 복제
CREATE TABLE EMPLOYEE_DEPT
AS SELECT 
* 
FROM EMPLOYEE 
JOIN department ON(DEPT_ID = DEPT_CODE)
WHERE 1=0;












