[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Backup](../index.md) > [Пошаговые инструкции](index.md) > Compute Cloud в Cloud Backup > Обновить агент Cloud Backup

# Обновить агент Yandex Cloud Backup на виртуальной машине Yandex Compute Cloud

В некоторых ситуациях, чтобы обеспечить бесперебойное автоматическое резервное копирование [виртуальных машин](../../compute/concepts/vm.md) Compute Cloud, может потребоваться обновить [агент Cloud Backup](../concepts/agent.md) или восстановить его нарушенную работоспособность.

## Обновление агента Cloud Backup {#update-agent}

Обновление агента Cloud Backup может потребоваться при технических обновлениях на стороне [провайдера резервного копирования](../concepts/index.md#providers). О подобных случаях Yandex Cloud заблаговременно предупреждает клиентов.

{% note info %}

Обновление агента Cloud Backup не влияет на данные в существующих резервных копиях.

{% endnote %}

Чтобы обновить агент Cloud Backup на ВМ Compute Cloud:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по SSH.
  1. В терминале выполните команду:

      ```bash
      curl \
        --output backup_agent_linux_installer.bin \
        https://storage.yandexcloud.net/backup-distributions/backup_agent_linux_installer.bin && \
      sudo bash ./backup_agent_linux_installer.bin -a
      ```

      Результат:

      ```text
      ...
      Congratulations!
      Cyber Backup Agent has been successfully installed in the system.
      ```

      Обновление агента Cloud Backup может занимать около 15 минут.

  1. Отключитесь от ВМ.


- Windows {#windows}

  1. [Подключитесь](../../compute/operations/vm-connect/rdp.md) к ВМ по RDP.
  1. Запустите [Windows PowerShell](https://learn.microsoft.com/ru-ru/powershell/).
  1. Выполните команды:

      ```powershell
      Invoke-WebRequest `
        "https://storage.yandexcloud.net/backup-distributions/backup_agent_windows_installer.exe" `
        -OutFile ".\backup_agent_windows_installer.exe"
      Invoke-Expression .\backup_agent_windows_installer.exe
      ```

  1. В открывшемся окне нажмите **Repair**.
  1. Дождитесь сообщения `The installation was successfully repaired` и нажмите **CLOSE**.
      
      Обновление агента Cloud Backup может занимать около 15 минут.
  1. Отключитесь от ВМ.

{% endlist %}

Если по какой-либо причине обновить агент Cloud Backup не удалось, [обратитесь](https://center.yandex.cloud/support) в техническую поддержку.

#### См. также {#see-also}

* [Восстановить работоспособность агента Cloud Backup после обновления ядра Linux](backup-baremetal/restore-agent.md)