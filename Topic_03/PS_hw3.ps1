# 2. Работа с профилем
# 2.1. Создать профиль
New-Item -ItemType file -Path $profile -force

# 2.2. В профиле изменить цвета в консоли PowerShell
# Изменение цвета консоли
(Get-Host).UI.RawUI.ForegroundColor = "yellow"
(Get-Host).UI.RawUI.BackgroundColor = "black"

# 2.3. Создать несколько собственный алиасов
Set-Alias -name Help -value Get-Help
Set-Alias -name Member -Value Get-Member

# 2.4. Создать несколько констант
Set-Variable pi -value 3.14 -option constant
Set-Variable G -value 9.8065 -option constant

# 2.5. Изменить текущую папку
Set-Location C:\

# 2.6. Вывести приветствие
Write-Host "What about PowerShell, Master?"

# 2.7. Проверить применение профиля
Get-Alias
Get-Variable

# 3. Получить список всех доступных модулей
Get-Module -ListAvailable
