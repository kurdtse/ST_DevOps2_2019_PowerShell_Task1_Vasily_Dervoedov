# 17. Выведите дату и время, когда был запущен процесс «explorer». Получите какой это день недели. 
$a = Get-Process -name explorer
$a.StartTime
$a.StartTime.DayOfWeek