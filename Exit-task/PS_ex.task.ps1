# 1. Вывести список событий-ошибок из системного лога, за последнюю неделю. Результат представить в виде файла XML.
Get-EventLog -LogName System -EntryType Error -After (get-date).adddays(-7) | Export-Clixml "C:\temp\error.xml"

# 2. Вывести список файлов *.log хранящихся в папке C:\Windows. 
# Вывод организовать в виде таблицы с обратной сортировкой по имени файла, при этом выводить полное имя файла, размер файла, время создания. 
Get-ChildItem C:\Windows -Filter *.log | Sort Name -Descending | Select Name, Length, CreationTime

# 3. Создать файл-сценарий вывода всех чисел делящихся без остатка на 3, на интервале от А до В, где А и В — входные параметры, 
# параметр А по умолчанию равен 0, параметр В обязателен для ввода.
Param (
    [parameter(Mandatory=$true,HelpMessage="Enter B:")]
    [int]$B,
    [int]$A=0
)
for ($A=0; $A -le $B; $A++) {
    if ($A%3 -eq 0) { 
            Write-Output $A
    }
}

# 4. Проверить на удалённых компьютерах состояние одной службы (имя определить самостоятельно). 
# Перечень имен компьютеров должен браться из текстового файла. Вывод организовать следующим образом: 
# Имя компьютера – статус (если служба запущена, то строка зелёная, иначе красная)

$hosts = Get-Content -Path C:\Temp\rm.txt
foreach ($name in $hosts) {
$service = gwmi win32_service -Credential $name\Administrator -ComputerName $name | where-Object {$_.Name -eq "wuauserv"}
        if ($service.state -match "Run") {
            Write-Host "$name - Running" -ForegroundColor Green
        }
        elseif ($service.state -match "Stop") { 
            Write-Host "$name - Stopped" -ForegroundColor Red 
        }
        else { Write-Host "Other state" }
}

# 5. Все файлы из прилагаемого архива перенести в одну папку, не содержащую подпапок. 
# Имя каждого файла изменить, добавив в его начало имя родительской папки и время переноса файла. 
# В конце выдать отчёт о количестве файлов и общем размере перенесённых файлов. 
Expand-Archive -Path C:\temp\test.zip -DestinationPath C:\zip
Get-ChildItem -Path C:\zip | Rename-Item -NewName {$_.Directory.Name + "-" + $_.Name}
$size = 0
cd C:\zip
foreach ($file in Get-ChildItem *) { 
    $size += $file.length 
}
Write-Output ("Total size: " + ($size/1kb) + "Kb")