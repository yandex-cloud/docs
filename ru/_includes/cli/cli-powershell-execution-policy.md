Если PowerShell сообщает, что выполнение скриптов запрещено, проверьте действующие политики выполнения с помощью команды `Get-ExecutionPolicy -List`. Изменяйте политики только в том случае, если это разрешено правилами безопасности вашей организации. Если политика задана администратором или запуск скриптов запрещен, [установите CLI без использования скрипта](../../cli/operations/install-cli.md#bin).

Подробнее о политиках выполнения PowerShell читайте в [документации Microsoft](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).
