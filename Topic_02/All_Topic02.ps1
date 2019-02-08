# 1. Просмотреть содержимое ветви реeстра HKCU
cd HKCU:
ls

# 2. Создать, переименовать, удалить каталог на локальном диске
mkdir -path e:\PowerShell_Topic02
Rename-Item -path e:\PowerShell_Topic02 -newname toKill
rmdir -path e:\toKill

# 3. Создать папку C:\M2T2_ФАМИЛИЯ. Создать диск ассоциированный с папкой C:\M2T2_ФАМИЛИЯ.
mkdir -path C:\M2T2_DERVOEDOV
New-PSDrive -Name M2T2 -PSProvider FileSystem -Root "C:\M2T2_DERVOEDOV"

# 4. Сохранить в текстовый файл на созданном диске список запущенных(!) служб. Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
Get-Service | Where-Object {$_.Status -eq 'Running'} | Out-File M2T2:\services.txt
cd m2t2:
$a = Get-Content ".\services.txt"
foreach ($i in $a)
{$i}

# 5. Просуммировать все числовые значения переменных текущего сеанса.

# 6. Вывести список из 6 процессов занимающих дольше всего процессор.
Get-Process | Sort UserProcessorTime -desc -ErrorAction SilentlyContinue | Select Name, Id, UserProcessorTime -first 6

# 7. Вывести список названий и занятую виртуальную память (в Mb) каждого процесса, 
# разделённые знаком тире, при этом если процесс занимает более 100Mb – выводить информацию красным цветом, иначе зелёным.
$Proc = (Get-Process | Select Name, VirtualMemorySize)
foreach ($i in $Proc) {
    if (($i.VirtualMemorySize / 1048576) -gt 100)
    {
        Write-Host($i.Name + " - " + ($i.VirtualMemorySize / 1048576) + "Mb") -ForegroundColor Red
    }
    else
    {
        Write-Host($i.Name + " - " + ($i.VirtualMemorySize / 1048576) + "Mb") -ForegroundColor Green
    }
}

# 8. Подсчитать размер занимаемый файлами в папке C:\windows (и во всех подпапках) за исключением файлов *.tmp

# 9. Сохранить в CSV-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
Set-Location HKLM:\Software\Microsoft
Get-ChildItem > "M2T2:\HKLM_Software_Microsoft.csv"

# 10. Сохранить в XML -файле историческую информацию о командах выполнявшихся в текущем сеансе работы PS.
Get-History > "m2t2:\history.xml"

# 11. Загрузить данные из полученного в п.10 xml-файла и вывести в виде списка информацию о каждой записи, в виде 5 любых (выбранных Вами) свойств.
Get-Content "m2t2:\history.xml" | Select PSDrive, PSParentPath, PSPath, PSProvider, Length

# 12. Удалить созданный диск и папку С:\M2T2_ФАМИЛИЯ
Remove-PSDrive -Name M2T2
rmdir -path C:\M2T2_DERVOEDOV