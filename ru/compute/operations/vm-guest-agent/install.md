# Установить агент для сброса паролей на виртуальную машину Windows

{% if audience == "draft" %}

Агент для {% if product == "cloud-il" %}[сброса паролей пользователей](../../concepts/guest-agent.md){% else %}сброса паролей пользователей{% endif %} и программа для его обновления входят в состав стандартных образов Windows с xx ноября 2021 года. Если ваша ВМ создана раньше или вы пользуетесь собственным образом, для сброса паролей установите агент и программу на ВМ самостоятельно.

{% endif %}

Чтобы {% if product == "cloud-il" %}[сбрасывать пароли пользователей](../../concepts/guest-agent.md){% else %}сбрасывать пароли пользователей{% endif %} на виртуальных машинах Windows средствами {{ yandex-cloud }}, установите агент для сброса паролей и программу для обновления агента. В июне 2022 года они войдут в состав стандартных образов Windows. 

{% include [password-reset-linux](../../../_includes/compute/password-reset-linux.md) %}

Агент устанавливается с помощью программы для его обновления.

Чтобы установить агент и настроить его автоматическое обновление:

1. [Подключитесь к ВМ по RDP](../vm-connect/rdp.md).
1. Скачайте и настройте программу для обновления агента:

   {% list tabs %}
   
   - PowerShell
   
     1. Получите номер последней версии программы:
     
        ```powershell
        $YCAgentUpdaterBaseUri = "https://{{ s3-storage-host }}/yandexcloud-guestagent-updater"
        $YCAgentUpdaterVersion = (Invoke-RestMethod "$YCAgentUpdaterBaseUri/release/stable").Trim()
        ```
   
     1. Скачайте программу и проверьте ее контрольную сумму:
     
        ```powershell
        $YCAgentUpdaterDir = "C:\Program Files\Yandex.Cloud\Guest Agent Updater"
        New-Item -Path $YCAgentUpdaterDir -ItemType "directory"
        
        $p = @{
          Uri = "$YCAgentUpdaterBaseUri/release/$YCAgentUpdaterVersion/windows/amd64/guest-agent-updater.exe"
          OutFile = "$YCAgentUpdaterDir\guest-agent-updater.exe"
        }
        Invoke-RestMethod @p
        
        $YCAgentUpdaterHashOrig = (Invoke-RestMethod "$YCAgentUpdaterBaseUri/release/$YCAgentUpdaterVersion/windows/amd64/guest-agent-updater.exe.sha256").Trim()
        $YCAgentUpdaterHashCopy = (Get-Filehash -Path "$YCAgentUpdaterDir\guest-agent-updater.exe" -Algorithm SHA256 | Select-Object -ExpandProperty Hash).ToLower()
        if ($YCAgentUpdaterHashOrig -eq $YCAgentUpdaterHashCopy) {
          Write-Host "Agent updater checksum verified"
        } else {
          Write-Host "Agent updater checksum NOT verified"
        }
        ```
        
        Результат:
        
        ```
        Agent updater checksum verified
        ```
        
     1. Установите агент:
     
        ```powershell
        & $YCAgentUpdaterDir\guest-agent-updater.exe update
        ```
        
     1. Проверьте, что агент установлен в качестве службы, а служба запущена:
     
        ```powershell
        Get-Service "yc-guest-agent"
        ```
        
        Результат:
        
        ```
        Status   Name               DisplayName
        ------   ----               -----------
        Running  yc-guest-agent     yc-guest-agent
        ```
        
        Служба должна иметь статус `Running`.
        
     1. Если служба не запущена, запустите ее:
     
        ```powershell
        Start-Service "yc-guest-agent"
        ```
        
        Чтобы проверить, что служба запустилась, повторите шаг 4.
        
     1. Настройте задание на обновление агента каждую неделю в случайное время:
     
        ```powershell
        $YCAgentUpdaterLogFilepath = "C:\Windows\Temp\guest-agent-updater.log"
        $p = @{
          Execute = 'C:\Windows\System32\cmd.exe'
          Argument = "/c `"$YCAgentUpdaterDir\guest-agent-updater.exe`" update --log-level debug > $YCAgentUpdaterLogFilepath"
        }
        $YCAgentUpdaterAction = New-ScheduledTaskAction @p
        
        $RandomWeekdayNumber = Get-Random -Minimum 0 -Maximum 6
        $DaysOfWeek = @("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
        $RandomWeekday = $DaysOfWeek[$RandomWeekdayNumber]
        
        $RandomHour = Get-Random -Minimum 0 -Maximum 23
        $RandomMinute = Get-Random -Minimum 0 -Maximum 59
        $RandomSecond = Get-Random -Minimum 0 -Maximum 59
        $p = @{
          Weekly = $true
          At = ([datetime]::Today).AddHours($RandomHour).AddMinutes($RandomMinute).AddSeconds($RandomSecond)
          RandomDelay = New-TimeSpan -Hours 24 # with huge random delay
          DaysOfWeek = $RandomWeekday
         }
        $YCAgentUpdaterTrigger = New-ScheduledTaskTrigger @p
        
        $YCAgentUpdaterTaskName = "yc-guest-agent-updater"
        $p = @{
          TaskName = $YCAgentUpdaterTaskName
          Action = $YCAgentUpdaterAction
          User = 'System'
          RunLevel = 'Highest'
          Trigger = $YCAgentUpdaterTrigger
        }
        Register-ScheduledTask @p | Out-Null
        ```
        
     1. Запустите задание:
     
        ```powershell
        Get-ScheduledTask -TaskName $YCAgentUpdaterTaskName | Start-ScheduledTask
        
        $Timeout = 30
        $Deadline = ([datetime]::Now).AddSeconds($timeout)
        
        while ((Get-ScheduledTask $YCAgentUpdaterTaskName).State -ne "Ready") {    
          Start-Sleep -Seconds 1
        
          if ([datetime]::Now -gt $Deadline) {
            Write-Host "Deadline exceeded"
            break
          }
        } 
        ```
                
   {% endlist %}