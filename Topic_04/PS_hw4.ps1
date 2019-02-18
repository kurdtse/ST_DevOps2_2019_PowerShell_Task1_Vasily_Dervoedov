# 1. Вывести список всех классов WMI на локальном компьютере.
Get-WmiObject -List

# 2. Получить список всех пространств имён классов WMI. 
Get-WmiObject -List "*namespace*"

# 3. Получить список классов работы с принтером.
Get-WmiObject -List "*printer*"

# 4. Вывести информацию об операционной системе, не менее 10 полей.
Get-WmiObject -Class Win32_OperatingSystem | Select-Object BuildNumber, BuildType, CountryCode, CurrentTimeZone, `
FreePhysicalMemory, Name, OSLanguage, OSType, WindowsDirectory, SystemDrive

# 5. Получить информацию о BIOS.
Get-WmiObject -Class Win32_BIOS

# 6. Вывести свободное место на локальных дисках. На каждом и сумму.
$arr_disks = Get-WmiObject -Class Win32_LogicalDisk | Select-Object Name, FreeSpace
$sum = 0
foreach ($i in $arr_disks) {
    $sum += ($i.FreeSpace / 1gb)
    Write-Host("Free space on disk $($i.Name) -> " + $($i.FreeSpace / 1Gb) + "Gb")
}
Write-Host("Free space on the all disks: " + $sum + "Gb")

# 7. Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.
$sum = 0
for ($i = 0; $i -lt 4; $i++) {
    $ping = Get-WmiObject -Class Win32_PingStatus -Filter "Address='10.0.0.1'"
    $sum += $ping.ResponseTime
}
Write-Output("Response time = $sum ms")

# 8. Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.
Get-WmiObject -Class Win32_Product | Select-Object Name, Version | Format-table -Autosize

# 9. Выводить сообщение при каждом запуске приложения MS Word.
Register-WmiEvent -Query "select * from __instancecreationevent within 5 where targetinstance isa 'Win32_Process' and targetinstance.name='WINWORD.EXE'" `
-Action { Write-Host "Microsoft Word has been started" }