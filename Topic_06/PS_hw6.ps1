# 1.1. Вывести все IP адреса вашего компьютера (всех сетевых интерфейсов)
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName . | Select-Object -Property IPAddress

# 1.2. Получить mac-адреса всех сетевых устройств вашего компьютера и удалённо.
Get-WmiObject -Class Win32_NetworkAdapter -ComputerName . | Select-Object -Property MACAddress

# 1.3. На всех виртуальных компьютерах настроить (удалённо) получение адресов с DHСP.

# 1.4. Расшарить папку на компьютере
net share tempshare=c:\temp /users:25 /remark:"test share of the temp folder"

# 1.5. Удалить шару из п.1.4
net share tempshare /delete

# 1.6. Скрипт входными параметрами которого являются Маска подсети и два ip-адреса. Результат  – сообщение (ответ) в одной ли подсети эти адреса.

# 2.1. Получить список коммандлетов работы с Hyper-V (Module Hyper-V)
Get-Command -Module Hyper-V

# 2.2. Получить список виртуальных машин 
Get-VM

# 2.3. Получить состояние имеющихся виртуальных машин
Get-MV | Select-Object -Property Name, State

# 2.4. Выключить виртуальную машину
Stop-VM -Name dervoedov_vm2

# 2.5. Создать новую виртуальную машину
New-VM -Name DERVOEDOV_VM_PS

# 2.6. Создать динамический жесткий диск
New-VHD -Path C:\Test.vhdx -Dynamic -SizeBytes 127Gb

# 2.7. Удалить созданную виртуальную машину
Remove-VM -Name DERVOEDOV_VM_PS -Force
