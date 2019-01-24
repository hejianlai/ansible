::echo off ::

@echo off

echo start running...


C:\soft\mysql-5.7.24-winx64\bin\mysql -u root -pnpsdb2018 --max_allowed_packet=1048576 --net_buffer_length=16384 < C:\soft\PreventCopy\sql_import_bat\all_sql\all.sql

echo ok。

pause
