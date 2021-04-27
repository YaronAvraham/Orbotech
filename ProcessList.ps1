# Get a list of running processes, sort by descebding CPU usage and output to processList.csv file
Get-Process | Select-Object -property ProcessName,CPU | Sort-Object -Property CPU -Descending | Export-Csv -Path $PSScriptRoot".\processList.csv"

# Get the process name and the cpu usage of the first (highst) process  
$ProcessName = (Import-Csv -Path $PSScriptRoot".\processList.csv")[0].ProcessName
$ProcessCpuUsage = (Import-Csv -Path $PSScriptRoot".\processList.csv")[0].CPU
Write-Host $ProcessName $ProcessCpuUsage

# Send alert by mail (outlook)
$Outlook = New-Object -ComObject Outlook.Application
$file = ".\file.csv"
$date = Get-Date -Format g
$Mail = $Outlook.CreateItem(0)
$Mail.To = "yarona@gmail.com"
$Mail.Subject = "Cpu usage alert"
$Mail.Body = "Hi All`n`nThe following process has the higest cpu usage. Process name: " + $ProcessName + " Cpu usage: " + $ProcessCpuUsage
$Mail.Send()