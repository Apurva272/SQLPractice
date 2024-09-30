select * from session_logs;
delimiter |
#write a query to remove all records older than 5 days
create event e_daily_log_purge
on schedule
every 5 second
comment "purge logs that are 5 days or older"
do
begin
delete from session_logs
where date(ts)<date("2022-10-23")- interval 5 day; #hardcoded date can be changed with currdate()
end |
delimiter ;