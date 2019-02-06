#20. Напишите функцию для предыдущего задания. Запустите её на выполнение.
Function Get-Sum([int]$N)
{
  $i = 1
  $sum = 0
  while ($i -le $N)
  {
  $sum += 3 * $i
  Write-Host "На шаге $i сумма S равна $sum"
  $i++
  } 
  
} #end Get-Sum

Write-Host "Введите N:" 
$N = Read-Host
Get-Sum $N