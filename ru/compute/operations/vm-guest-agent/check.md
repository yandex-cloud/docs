---
title: Как проверить работу агента для сброса паролей на виртуальной машине Windows Server
description: Из статьи вы узнаете, как проверить работу агента для сброса паролей на виртуальной машине Windows Server.
---

# Проверить работу агента для сброса паролей на виртуальной машине Windows Server

## Проверить, что агент установлен {#check-installation}

1. [Подключитесь к ВМ по RDP](../vm-connect/rdp.md).
1. Проверьте, что агент установлен и запущен как служба `yc-guest-agent`:

   {% list tabs group=programming_language %}
   
   - PowerShell {#powershell}
   
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

   {% list tabs group=programming_language %}
   
   - PowerShell {#powershell}
   
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
        LastRunTime        : 3/15/2023 2:39:39 PM
        LastTaskResult     : 2147946720
        NextRunTime        : 3/20/2023 6:36:36 AM 12:10:10 AM
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

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите каталог, которому принадлежит виртуальная машина.
  1. Выберите сервис **{{ compute-name }}**.
  1. Нажмите на строку с нужной виртуальной машиной.
  1. Перейдите на вкладку **Последовательный порт**.
  1. Выберите порт **COM4**.
  1. Чтобы воспользоваться поиском с помощью сочетания клавиш **Ctrl** + **F**, включите переключатель **Исходные данные** в правом верхнем углу.

- CLI {#cli}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Выполните следующую команду:

  ```
  yc compute instance get-serial-port-output <имя_ВМ> --port 4 > output.txt
  ```
  
  Логи будут сохранены в файл `output.txt`
  
- PowerShell {#powershell}

  1. Остановите агент:
  
     ```powershell
     Stop-Service "yc-guest-agent"
     ```
     
  1. Запустите агент с нужным уровнем логирования, указанным в параметре `--log-level`. Например:
  
     ```powershell
     & "C:\Program Files\Yandex.Cloud\Guest Agent\guest-agent.exe" start --log-level debug
     ```

- API {#api}

  Чтобы получить вывод последовательного порта, воспользуйтесь методом REST API [getSerialPortOutput](../../api-ref/Instance/getSerialPortOutput.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/GetSerialPortOutput](../../api-ref/grpc/Instance/getSerialPortOutput.md). В `port` укажите значение `4`.

{% endlist %}