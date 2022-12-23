# drop
# drop table table명
# 부모테이블은 삭제할 수 없다.
# 부모테이블을 삭제하기 위해서는 자식 테이블을 먼저 삭제한 후에,
# 참조하고 있는 테이블이 없는 경우 부모테이블을 삭제할 수 있다.

drop table our_dept;
drop table our_emp;