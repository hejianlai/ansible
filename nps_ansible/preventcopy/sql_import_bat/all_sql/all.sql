use prevent_copy;
SELECT station_id, terminal_no, ip, device_time, start_time, update_time, 
CASE WHEN `status` = '00' THEN 'NPS已连接' ELSE 'NPS未连接' END AS NPS连接状态,
CASE WHEN UNIX_TIMESTAMP(SYSDATE()) - UNIX_TIMESTAMP(update_time) > 66 THEN 'SDK未连接' ELSE 'SDK已连接' END AS SDK连接状态
        FROM  sdk_heartbeat a
        WHERE NOT EXISTS (
            SELECT 1
            FROM sdk_heartbeat b
            WHERE
                a.station_id = b.station_id
            AND a.terminal_no = b.terminal_no
            AND a.update_time < b.update_time
        )
        ORDER BY a.terminal_no
