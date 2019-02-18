# 1. При помощи WMI перезагрузить все виртуальные машины.
$comp = @("VM1", "VM2", "VM3")
Invoke-Command -ScriptBlock {Restart-Computer -Force} -ComputerName $comp 

# 2. При помощи WMI просмотреть список запущенных служб на удаленном компьютере. 
Invoke-Command -ScriptBlock {Get-Service | Where-Object {$_.Status -eq "Running"}} -ComputerName VM2

# 3. Настроить PowerShell Remoting, для управления всеми виртуальными машинами с хостовой.
Enter-PSSession -ComputerName VM2 -Credential VM2\Administrator

# 4. Для одной из виртуальных машин установить для прослушивания порт 42658. Проверить работоспособность PS Remoting.
# на VM2
Set-Item WSMan:\localhost\Listener\listener*\port -Value 42658
# на хостовой машине
Enter-PSSession -ComputerName VM2 -Port 42658 -Credential VM2\Administrator

# 5. Создать конфигурацию сессии с целью ограничения использования всех команд, кроме просмотра содержимого дисков.