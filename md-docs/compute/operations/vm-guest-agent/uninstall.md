# Удалить агент для сброса паролей с виртуальной машины Windows Server

1. [Подключитесь к ВМ по RDP](../vm-connect/rdp.md).
1. Остановите службу Windows Server и удалите агент:

   {% list tabs group=programming_language %}

   - PowerShell {#powershell}

     1. Остановите службу `yc-guest-agent`:

        ```powershell
        Stop-Service -Name "yc-guest-agent"
        ```

     1. Проверьте, что служба остановлена:

        ```powershell
        Get-Service "yc-guest-agent"
        ```

        Результат:

        ```text
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

        ```text
        2023-03-16T14:47:00.248Z        INFO    uninstall windows service: yc-guest-agent       {"server": "windows"}
        ```

   {% endlist %}