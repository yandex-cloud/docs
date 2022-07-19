# Проверить работу агента для сброса паролей на виртуальной машине Windows

## Проверить, что агент установлен {#check-installation}

1. [Подключитесь к ВМ по RDP](../vm-connect/rdp.md).
1. Проверьте, что агент установлен и запущен как служба `yc-guest-agent`:

   {% list tabs %}
   
   - PowerShell
   
     ```powershell
     Get-Service "yc-guest-agent"
     ```
     
     * Если агент установлен и запущен, он отобразится в списке со статусом `Running`:
     
       ```
       Status   Name               DisplayName
       ------   ----               -----------
       Running  yc-guest-agent     yc-guest-agent
       ```
       
     * Если агент установлен, но не запущен, он отобразится в списке со статусом `Stopped`. Чтобы запустить агент, выполните следующую команду:
     
       ```powershell
       Start-Service "yc-guest-agent"
       ```
       
       После этого снова проверьте, что агент запущен.
       
     * Если агент не установлен, он не отобразится. Установите его по [инструкции](install.md).
     
   {% endlist %}
   
## Проверить обновление агента {#check-updater}

1. [Подключитесь к ВМ по RDP](../vm-connect/rdp.md).
1. Проверьте, что обновление агента корректно настроено и работает:

   {% list tabs %}
   
   - PowerShell
   
     1. Проверьте, что задание по обновлению агента запущено:

        ```powershell
        Get-ScheduledTask "yc-guest-agent-updater" -OutVariable Task
        ```
   
        Результат:
   
        ```
        TaskPath           TaskName                          State
        --------           --------                          -----
        \                  yc-guest-agent-updater            Ready
        ```
   
        У задания `yc-guest-agent-updater` должен быть статус `Ready`.
   
     1. Получите информацию о последнем выполнении задания:

        ```powershell
        $Task | Get-ScheduledTaskInfo
        ```
   
        Результат:
   
        ```
        LastRunTime        : 11/8/2021 1:26:26 PM
        LastTaskResult     : 0
        NextRunTime        : 11/15/2021 12:10:10 AM
        NumberOfMissedRuns : 0
        TaskName           : yc-guest-agent-updater
        TaskPath           : \
        PSComputerName     :
        ```
   
        Если последнее обновление прошло успешно, в поле `LastTaskResult` будет значение `0`.
        
   {% endlist %}

## Получить логи агента {#get-logs}

Логи агента для сброса паролей можно получить из последовательного порта 4 (COM4) или напрямую от агента в PowerShell.

Чтобы получить логи:

{% list tabs %}

- Консоль управления

  1. Выберите каталог, которому принадлежит виртуальная машина.
  1. Выберите сервис **{{ compute-name }}**.
  1. Нажмите на строку с нужной виртуальной машиной.
  1. Перейдите на вкладку **Последовательный порт**.
  1. Выберите порт **COM4**.
  1. Чтобы воспользоваться поиском с помощью сочетания клавиш **Ctrl** + **F**, включите переключатель **Исходные данные** в правом верхнем углу.

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Выполните следующую команду:

  ```
  yc compute instance get-serial-port-output <имя ВМ> --port 4 > output.txt
  ```
  
  Логи будут сохранены в файл `output.txt`
  
- PowerShell

  1. Остановите агент:
  
     ```powershell
     Stop-Service "yc-guest-agent"
     ```
     
  1. Запустите агент с нужным уровнем логирования, указанным в параметре `--log-level`. Например:
  
     ```powershell
     & "C:\Program Files\Yandex.Cloud\Guest Agent\guest-agent.exe" start --log-level debug
     ```

- API

  Чтобы получить вывод последовательного порта, используйте вызов gRPC API [InstanceService/GetSerialPortOutput](../../api-ref/grpc/instance_service.md#GetSerialPortOutput) или метод REST API [getSerialPortOutput](../../api-ref/Instance/getSerialPortOutput.md). В поле `port` укажите значение `4`.

{% endlist %}