#날짜
insert into tb_type(t_date, t_time, t_datetime, t_timestamp)
values('22-12-23', '12:00:01', '22-12-23 12:01:01', '22-12-23 12:01:01');

select * from tb_type;

# datetime과 timestamp의 차이
# timestamp는 db서버의 timezone을 참조한다.
# 글로벌서비스를 만들거나, 또는 해외의 클라우드 DB를 사용하는 경우에 timestamp를 쓰는게 좋다.

# timezone을 변경하여 확인
set @@session.time_zone = '+09:00';
select t_datetime, t_timestamp from tb_type;

rollback;


