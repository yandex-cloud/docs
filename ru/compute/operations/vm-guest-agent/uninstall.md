# Удалить агент для сброса паролей с виртуальной машины Windows

1. [Подключитесь к ВМ по RDP](../vm-connect/rdp.md).
1. Остановите службу Windows и удалите агент:

   {% list tabs %}
   
   - PowerShell
   
     1. Остановите службу `yc-guest-agent`:
     
        ```powershell
        Stop-Service -Name "yc-guest-agent"
        ```
        
     1. Проверьте, что служба остановлена:

        ```powershell
        Get-Service "yc-guest-agent"
        ```
        
        Результат:
        
        ```
        Status   Name               DisplayName
        ------   ----               -----------
        Stopped  yc-guest-agent     yc-guest-agent
        ```
        
        Служба должна иметь статус `Stopped`.
        
     1. Удалите агент:
     
        ```powershell
        & "C:\Program Files\Yandex.Cloud\Guest Agent\guest-agent.exe" uninstall
        ```
        
        Результат:
        
        ```
        2021-10-28T14:47:00.248Z        INFO    uninstall windows service: yc-guest-agent       {"server": "windows"}
        ```
        
   {% endlist %}