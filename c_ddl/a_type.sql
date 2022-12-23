# DDL : Data definition language 
# type

create table tb_type(
	# 컬럼명 타입	
    # 정수형
    # tinyint		1byte    
    t_tinyint tinyint    
    # smallint		2byte
	,t_smallint smallint    
    # mediumint		3byte
    ,t_mediumint mediumint    
    # int			4byte
    ,t_int int    
    # bigint	    8byte
    ,t_bigint bigint
    
	# 실수형
    # float		4byte
    ,t_float float
    # double	8byte
    ,t_double double
    # decimal   데이터타입 + 1byte
    ,t_decimal decimal(5,3)

    #논리형		# tinyint
    ,t_bool bool
    
    #문자열
    #CHAR		고정길이데이터, 255BYTE    
    ,t_char char(10)   # (10), 컬럼의 크기, 10글자
    
    #varchar	가변길이데이터, 65,535byte
    ,t_varchar varchar(100)  # (100) 컬럼의 최대 크기, 100글자
    
    #text		대량의 텍스트를 저장하기 위한 용도, 같은 크기의 문자열을 읽을 때 varchar보다 많이 느리다.
    #  tinytext(255byte), text(65535byte)
    # ,t_mediumtext mediumtext   최대 16,777,215 byte
	,t_longtext longtext 	  # 최대 4,294,967,295 byte

	#날짜
    # date 연월일
    ,t_date date
	# time 시분초
	,t_time time
	# datetime 연월일시분초
	,t_datetime datetime
    # timestamp 연월일시분초
    ,t_timestamp timestamp
);
