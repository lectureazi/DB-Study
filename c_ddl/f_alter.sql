# 테이블 수정

# 테이블 이름 변경
# 이름 변경 : RENAME TO
ALTER TABLE EMPLOYEE_DEPT rename TO CP_EMP_DEPT;

# 테이블 컬럼 수정
# ALTER TABLE 테이블명 ADD | MODIFY | DROP  컬럼명 

# 컬럼 추가
ALTER TABLE OUR_EMP ADD(JOB_CODE CHAR(2) DEFAULT 'J0' NOT NULL);

# 컬럼 삭제
#ALTER TABLE OUR_EMP DROP JOB_CODE;

# 컬럼 이름변경
ALTER TABLE OUR_EMP rename column JOB_CODE TO JOB;

# 컬럼 변경
# 1. 컬럼의 타입은 변경이 불가능 하다. 단, 해당 컬럼에 값이 하나도 없으면 변경 가능
# 2. 컬럼의 크기는 컬럼에 포함된 데이터보다 큰 크기로만 변경이 가능
# 3. 제약조건은 현재 데이터들가 충돌하지 않는 제약조건만 지정이 가능
#		기존 컬럼에 NULL값이 하나라도 존재하면 NOT NULL 불가
#		기존 컬럼에 중복값이 존재한다면 UNIQUE 불가
#		기존 컬럼에 CHECK의 범위를 벗어나는 데이터가 존재하면 CHECK 불가능

# ALTER TABLE OUR_EMP modify EMP_NAME varchar(2); 불가능!
ALTER TABLE OUR_EMP modify EMP_NAME varchar(20);
ALTER TABLE OUR_EMP modify EMP_NAME varchar(20) unique;
DELETE FROM OUR_EMP WHERE EMP_ID = 6;
COMMIT;

# ALTER TABLE OUR_EMP modify AGE INT CHECK( AGE >= 20); 
ALTER TABLE OUR_EMP modify AGE INT CHECK( AGE >= 10 );


# 제약조건 변경
# ALTER TABLE 테이블명 ADD | DROP CONSTRAINT 제약조건명

# 기본키 삭제
ALTER TABLE OUR_EMP drop primary key;
# 기본키 추가
ALTER TABLE OUR_EMP ADD primary key(EMP_ID); 

# 외래키 삭제
ALTER TABLE OUR_EMP DROP constraint our_emp_ibfk_1;

# 외래키 추가
#	외래키 제약조건에 대한 옵션
#	ON DELETE CASCADE 	: 부모테이블에서 자식테이블이 참조하고 있는 행이 삭제 될 경우, 자식테이블의 행도 함께 삭제
#	ON DELETE SET NULL	: 부모테이블에서 자식테이블이 참조하고 있는 행이 삭제 될 경우, 자식테이블의 외래키를 NULL 처리
#   ON DELETE RESTRICT	: 부모테이블에서 자식테이블이 참조하고 있는 행을 삭제 할 수 없음(DEFAULT)

ALTER TABLE our_emp ADD constraint FK_OUR_DEPT
foreign key(DEPT_CODE) references our_dept(DEPT_CODE) ON DELETE SET NULL;

# 외래키 삭제
ALTER TABLE OUR_EMP DROP constraint FK_OUR_DEPT;

ALTER TABLE our_emp ADD constraint FK_OUR_DEPT
foreign key(DEPT_CODE) references our_dept(DEPT_CODE) ON DELETE cascade;

SELECT * FROM our_dept;
SELECT * FROM our_EMP;
DELETE FROM OUR_DEPT WHERE DEPT_CODE = 'D01';
ROLLBACK;

#	ON UPDATE CASCADE 	: 부모테이블에서 자식테이블이 참조하고 있는 행이 수정 될 경우, 자식테이블의 행도 함께 수정
#	ON UPDATE SET NULL	: 부모테이블에서 자식테이블이 참조하고 있는 행이 수정 될 경우, 자식테이블의 외래키를 NULL 처리
#   ON UPDATE RESTRICT	: 부모테이블에서 자식테이블이 참조하고 있는 행을 수정 할 수 없음(DEFAULT)

ALTER TABLE our_emp ADD constraint FK_OUR_DEPT
foreign key(DEPT_CODE) references our_dept(DEPT_CODE) ON UPDATE SET NULL;

# 외래키 삭제
ALTER TABLE OUR_EMP DROP constraint FK_OUR_DEPT;

ALTER TABLE our_emp ADD constraint FK_OUR_DEPT
foreign key(DEPT_CODE) references our_dept(DEPT_CODE) ON UPDATE cascade;

SELECT * FROM our_dept;
SELECT * FROM our_EMP;
UPDATE OUR_DEPT SET DEPT_CODE = 'D90' WHERE DEPT_CODE = 'D01';
ROLLBACK;