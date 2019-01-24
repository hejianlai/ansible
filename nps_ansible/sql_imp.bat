::echo off ::

@echo off

echo start running...

for %%i in (all_sql\*.sql) do (

echo antion %%i ...

echo set names utf8;>all.sql

echo source %%i>>all.sql

C:\soft\mysql-5.7.24-winx64\bin\mysql -u root -pnpsdb2018 --max_allowed_packet=1048576 --net_buffer_length=16384 < all.sql

echo %%i 。

)

del all.sql

echo ok。

pause