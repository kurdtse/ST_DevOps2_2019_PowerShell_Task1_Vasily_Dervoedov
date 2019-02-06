# 18. Откройте любой документ в MS Word (не важно как) и закройте его с помощью PowerShell
$word = New-Object -ComObject word.application
$word.Visible = $true
$doc = $word.documents.add()
$a = Get-Process -Name WINW*
stop-process -id $a.id