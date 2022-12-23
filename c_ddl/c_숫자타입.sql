# 정수형 데이터 추가
insert into tb_type(t_tinyint, t_smallint, t_mediumint, t_int, t_bigint)
values(100, 1000, 10000, 100000, 1000000);
select * from tb_type;

# 고정소수점 표현방식, 부동소수점 표현방식
# 부동소수점 표현방식 : float, double
#				   연산의 결과를 근사값으로 저장한다.
# 고정소수점 표현방식 : 자리수를 고정하는 표현방식
#				   연산의 결과를 정확하게 저장한다.
# decimal(precison, scale)
# precison : 전체 자리수
# scale    : 소수부의 자리수
insert into tb_type(t_float, t_double) values(0.000001, 0.000000002);
select * from tb_type;
commit;

insert into tb_type(t_decimal) values(99.999);
rollback;

insert into tb_type(t_bool) values(true);
select t_bool from tb_type;

delete from tb_type;
commit;




